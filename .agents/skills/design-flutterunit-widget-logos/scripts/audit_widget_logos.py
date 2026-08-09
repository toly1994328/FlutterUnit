from __future__ import annotations

import argparse
import re
import sqlite3
import sys
import xml.etree.ElementTree as ElementTree
from dataclasses import dataclass
from pathlib import Path


@dataclass(frozen=True)
class SvgStatus:
    name: str
    path: Path
    valid: bool
    issues: tuple[str, ...]


def find_project_root() -> Path:
    current = Path(__file__).resolve()
    for candidate in current.parents:
        if (candidate / "pubspec.yaml").is_file() and (
            candidate / "assets" / "flutter.db"
        ).is_file():
            return candidate
    raise RuntimeError("无法定位 FlutterUnit 仓库根目录")


def read_widget_names(database_path: Path) -> set[str]:
    with sqlite3.connect(database_path) as connection:
        return {
            row[0]
            for row in connection.execute("SELECT name FROM widget ORDER BY id")
        }


def read_mapping(mapping_path: Path) -> dict[str, str]:
    content = mapping_path.read_text(encoding="utf-8")
    return dict(
        re.findall(r"'([^']+)'\s*=>\s*'([^']+\.svg)'", content)
    )


def inspect_svg(path: Path) -> SvgStatus:
    issues: list[str] = []
    if path.stat().st_size == 0:
        return SvgStatus(path.stem, path, False, ("文件为空",))

    try:
        root = ElementTree.parse(path).getroot()
    except ElementTree.ParseError as error:
        return SvgStatus(path.stem, path, False, (f"XML 无法解析: {error}",))

    if root.tag.split("}")[-1] != "svg":
        issues.append("根元素不是 svg")
    if root.attrib.get("width") != "128" or root.attrib.get("height") != "128":
        issues.append("width/height 不是 128")
    if root.attrib.get("viewBox") != "0 0 128 128":
        issues.append('viewBox 不是 "0 0 128 128"')

    return SvgStatus(path.stem, path, not issues, tuple(issues))


def main() -> int:
    parser = argparse.ArgumentParser(description="审计 FlutterUnit Widget SVG Logo")
    parser.add_argument("--component", help="只校验指定组件")
    arguments = parser.parse_args()

    project_root = find_project_root()
    svg_dir = project_root / "assets" / "images" / "widgets"
    database_path = project_root / "assets" / "flutter.db"
    mapping_path = (
        project_root
        / "modules"
        / "widget_system"
        / "widget_ui"
        / "lib"
        / "src"
        / "view"
        / "widget_tiled"
        / "widget_logo.dart"
    )

    widget_names = read_widget_names(database_path)
    mapping = read_mapping(mapping_path)
    paths = sorted(svg_dir.glob("*.svg"))
    if arguments.component:
        paths = [svg_dir / f"{arguments.component}.svg"]

    statuses: list[SvgStatus] = []
    for path in paths:
        if not path.is_file():
            statuses.append(
                SvgStatus(path.stem, path, False, ("文件不存在",))
            )
        else:
            statuses.append(inspect_svg(path))

    failures = 0
    for status in statuses:
        issues = list(status.issues)
        if status.name != "Widget" and status.name not in widget_names:
            issues.append("数据库中没有同名组件")
        mapped_file = mapping.get(status.name)
        if status.name != "Widget" and status.valid and mapped_file != status.path.name:
            issues.append("有效 SVG 尚未接入 widgetLogo 映射")
        if mapped_file and mapped_file != status.path.name:
            issues.append(f"映射指向 {mapped_file}")

        if issues:
            failures += 1
            print(f"[FAIL] {status.name}: {'; '.join(issues)}")
        else:
            print(f"[OK]   {status.name}")

    if not arguments.component:
        valid_custom = {
            status.name
            for status in statuses
            if status.name != "Widget" and status.valid
        }
        integrated = {
            name
            for name, filename in mapping.items()
            if name in valid_custom and filename == f"{name}.svg"
        }
        total = len(widget_names)
        print()
        print(f"数据库组件: {total}")
        print(f"有效定制 SVG: {len(valid_custom)}")
        print(f"已接入映射: {len(integrated)}")
        print(f"映射覆盖率: {len(integrated) / total * 100:.2f}%")

    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
