import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 370 DropdownMenu 表单菜单
//    {
//      "widgetId": 370,
//      "name": '下拉菜单样式设置',
//      "priority": 2,
//      "subtitle":
//          "【controller】 : 文字输入控制器   【TextEditingController?】\n"
//          "【label】 : 输入框标签   【Widget?】\n"
//          "【textStyle】 : 输入框文字样式   【TextStyle?】\n"
//          "【inputDecorationTheme】 : 输入框装饰主题   【InputDecorationTheme?】\n"
//          "【leadingIcon】 : 左侧图标   【Widget?】\n"
//          "【trailingIcon】 : 右侧为展开菜单时图标   【Widget?】\n"
//          "【selectedTrailingIcon】 : 右侧展开菜单时图标   【Widget?】\n"
//          "【hintText】 : 输入框提示文字   【String?】\n"
//          "【helperText】 : 输入框辅助文字   【String?】\n"
//          "【errorText】 : 输入框错误文字   【String?】\n"
//          "【menuStyle】 : 弹出菜单样式   【MenuStyle?】",
//    }
enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Orange', Colors.orange),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);

  final String label;
  final Color color;
}


enum IconLabel {
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud('Cloud', Icons.cloud_outlined),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);

  final String label;
  final IconData icon;
}

class DropdownMenuNode2 extends StatefulWidget {
  const DropdownMenuNode2({super.key});

  @override
  State<DropdownMenuNode2> createState() => _DropdownMenuNode2State();
}

class _DropdownMenuNode2State extends State<DropdownMenuNode2> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  ColorLabel? selectedColor;
  IconLabel? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildColorMenu(),
              const SizedBox(height: 16),
              _buildLabelMenu(),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _buildInfo()
      ],
    );
  }

  Widget _buildColorMenu(){
    return DropdownMenu<ColorLabel>(
      initialSelection: ColorLabel.green,
      controller: colorController,
      requestFocusOnTap: true,
      label: const Text('Color'),
      width: 160,
      menuHeight: 150,
      menuStyle: const MenuStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
        surfaceTintColor: MaterialStatePropertyAll<Color>(Colors.white),
        padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 20,horizontal: 8)),
      ),
      onSelected: (ColorLabel? color) {
        setState(() {
          selectedColor = color;
        });
      },
      dropdownMenuEntries: ColorLabel.values.map((ColorLabel color) {
            return DropdownMenuEntry<ColorLabel>(
              value: color,
              label: color.label,
              enabled: color.label != 'Grey',
              style: MenuItemButton.styleFrom(
                foregroundColor: color.color,
              ),
            );
          }
      ).toList(),
    );
  }

  Widget _buildInfo() {
    if (selectedColor != null && selectedIcon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('You selected a ${selectedColor?.label} ${selectedIcon?.label}'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Icon(
              selectedIcon?.icon,
              color: selectedColor?.color,
            ),
          )
        ],
      );
    }
    return const Text('Please select a color and an icon.');
  }

  Widget _buildLabelMenu() {
    return DropdownMenu<IconLabel>(
      controller: iconController,
      enableFilter: false,
      requestFocusOnTap: false,
      width: 160,
      leadingIcon: const Icon(Icons.search),
      label: const Text('Icon'),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
      ),
      onSelected: (IconLabel? icon) {
        setState(() {
          selectedIcon = icon;
        });
      },
      dropdownMenuEntries: IconLabel.values.map((IconLabel icon) {
          return DropdownMenuEntry<IconLabel>(
            value: icon,
            label: icon.label,
            leadingIcon: Icon(icon.icon),
          );
        },
      ).toList(),
    );
  }
}



