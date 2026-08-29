import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// 支持拖拽、缩放及正方形导出的头像裁剪组件。
class AvatarCropView extends StatefulWidget {
  /// 待裁剪图片。
  final ImageProvider image;

  /// 裁剪框最大边长。
  final double cropSize;

  const AvatarCropView({
    super.key,
    required this.image,
    this.cropSize = double.infinity,
  });

  @override
  State<AvatarCropView> createState() => AvatarCropViewState();
}

class AvatarCropViewState extends State<AvatarCropView> {
  /// 当前已解析图片。
  ImageInfo? _imageInfo;

  /// 当前图片流。
  ImageStream? _imageStream;

  /// 图片平移缩放矩阵。
  final TransformationController _controller = TransformationController();

  /// 图片实时绘制区域。
  final _RectNotifier _rectNotifier = _RectNotifier();

  /// 当前裁剪区域。
  Rect _clipZone = Rect.zero;

  /// 当前裁剪框边长。
  double _side = 0;

  /// 组件可用尺寸。
  Size _viewSize = Size.zero;

  /// 图片初始覆盖区域。
  Rect? _initialZone;

  /// 当前手势类型。
  _GestureType? _gestureType;

  /// 手势起始缩放值。
  double? _scaleStart;

  /// 手势起始焦点。
  Offset? _referenceFocalPoint;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolveImage();
  }

  @override
  void didUpdateWidget(AvatarCropView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.image != oldWidget.image) {
      _initialZone = null;
      _controller.value = Matrix4.identity();
      _resolveImage();
    }
  }

  /// 解析图片并监听加载结果。
  void _resolveImage() {
    final ImageStream? oldStream = _imageStream;
    _imageStream = widget.image.resolve(createLocalImageConfiguration(context));
    if (_imageStream!.key == oldStream?.key) return;
    oldStream?.removeListener(ImageStreamListener(_onImageLoaded));
    _imageStream!.addListener(ImageStreamListener(_onImageLoaded));
  }

  void _onImageLoaded(ImageInfo info, bool synchronousCall) {
    if (!mounted) return;
    setState(() {
      _imageInfo?.dispose();
      _imageInfo = info;
    });
  }

  @override
  void dispose() {
    _imageStream?.removeListener(ImageStreamListener(_onImageLoaded));
    _imageInfo?.dispose();
    _controller.dispose();
    _rectNotifier.dispose();
    super.dispose();
  }

  /// 按当前裁剪区域导出 512×512 PNG。
  Future<Uint8List?> exportCroppedBytes() async {
    if (_imageInfo == null || _clipZone.isEmpty) return null;
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    const int outputSize = 512;
    final double scale = outputSize / _clipZone.width;
    _drawCroppedImage(canvas, scale);
    final ui.Image image =
        await recorder.endRecording().toImage(outputSize, outputSize);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    return byteData?.buffer.asUint8List();
  }

  /// 将当前视图坐标换算为源图裁剪矩形。
  void _drawCroppedImage(Canvas canvas, double scale) {
    final double sourceWidth = _imageInfo!.image.width.toDouble();
    final double sourceHeight = _imageInfo!.image.height.toDouble();
    final Rect pictureZone = _rectNotifier.value;
    final Rect source = Rect.fromLTWH(
      (_clipZone.left - pictureZone.left) / pictureZone.width * sourceWidth,
      (_clipZone.top - pictureZone.top) / pictureZone.height * sourceHeight,
      _clipZone.width / pictureZone.width * sourceWidth,
      _clipZone.height / pictureZone.height * sourceHeight,
    );
    final Rect destination =
        Rect.fromLTWH(0, 0, _clipZone.width, _clipZone.height);
    canvas.save();
    canvas.scale(scale);
    canvas.drawRect(destination, Paint()..color = Colors.white);
    canvas.drawImageRect(_imageInfo!.image, source, destination, Paint());
    canvas.restore();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: _onPointerSignal,
      child: GestureDetector(
        onScaleStart: _onScaleStart,
        onScaleUpdate: _onScaleUpdate,
        onScaleEnd: _onScaleEnd,
        child: LayoutBuilder(builder: _buildContent),
      ),
    );
  }

  Widget _buildContent(BuildContext context, BoxConstraints constraints) {
    _viewSize = constraints.biggest;
    _side = math.min(_viewSize.shortestSide * 0.9, widget.cropSize);
    _clipZone = Rect.fromCenter(
      center: Offset(_viewSize.width / 2, _viewSize.height / 2),
      width: _side,
      height: _side,
    );
    _updatePictureZone();
    return SizedBox(
      width: _viewSize.width,
      height: _viewSize.height,
      child: CustomPaint(
        foregroundPainter: const _CropOverlayPainter(),
        painter: _ImagePainter(
          imageInfo: _imageInfo,
          rectNotifier: _rectNotifier,
        ),
      ),
    );
  }

  /// 根据源图比例和当前矩阵计算图片绘制区域。
  Rect _calculatePictureZone() {
    if (_imageInfo == null) return Rect.zero;
    if (_initialZone == null) {
      final double sourceWidth = _imageInfo!.image.width.toDouble();
      final double sourceHeight = _imageInfo!.image.height.toDouble();
      final double ratio = sourceWidth / sourceHeight;
      _initialZone = ratio > 1
          ? Rect.fromCenter(
              center: _clipZone.center,
              width: _side * ratio,
              height: _side,
            )
          : Rect.fromCenter(
              center: _clipZone.center,
              width: _side,
              height: _side / ratio,
            );
    }
    final Path path = Path()..addRect(_initialZone!);
    return path.transform(_controller.value.storage).getBounds();
  }

  void _updatePictureZone() {
    _rectNotifier.value = _calculatePictureZone();
  }

  void _onPointerSignal(PointerSignalEvent event) {
    if (event is! PointerScrollEvent) return;
    final double factor = event.scrollDelta.dy < 0 ? 1.1 : 0.9;
    final Offset focalBefore = _controller.toScene(event.localPosition);
    _controller.value = _matrixScale(_controller.value, factor);
    final Offset focalAfter = _controller.toScene(event.localPosition);
    _controller.value = _matrixTranslate(
      _controller.value,
      focalAfter - focalBefore,
    );
    _updatePictureZone();
  }

  void _onScaleStart(ScaleStartDetails details) {
    _gestureType = null;
    _scaleStart = _controller.value.getMaxScaleOnAxis();
    _referenceFocalPoint = _controller.toScene(details.localFocalPoint);
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    _gestureType = _getGestureType(details);
    if (_gestureType == _GestureType.pan) {
      _handlePan(details);
    } else {
      _handleScale(details);
    }
  }

  void _handlePan(ScaleUpdateDetails details) {
    final Matrix4 matrix = _controller.value.clone()
      ..translateByDouble(
        details.focalPointDelta.dx,
        details.focalPointDelta.dy,
        0,
        1,
      );
    _controller.value = matrix;
    _referenceFocalPoint = _controller.toScene(details.localFocalPoint);
    _updatePictureZone();
  }

  void _handleScale(ScaleUpdateDetails details) {
    final double currentScale = _controller.value.getMaxScaleOnAxis();
    final double desiredScale = _scaleStart! * details.scale;
    _controller.value =
        _matrixScale(_controller.value, desiredScale / currentScale);
    final Offset focalScaled = _controller.toScene(details.localFocalPoint);
    _controller.value = _matrixTranslate(
      _controller.value,
      focalScaled - _referenceFocalPoint!,
    );
    _updatePictureZone();
  }

  void _onScaleEnd(ScaleEndDetails details) {
    _scaleStart = null;
    _gestureType = null;
    _referenceFocalPoint = null;
    final Rect picture = _rectNotifier.value;
    if (picture.width < _clipZone.width || picture.height < _clipZone.height) {
      _controller.value = Matrix4.identity();
      _initialZone = null;
      _updatePictureZone();
      return;
    }
    _snapToBounds();
  }

  /// 将图片吸附回裁剪框，避免裁剪范围出现空白。
  void _snapToBounds() {
    final Rect picture = _rectNotifier.value;
    double dx = 0;
    double dy = 0;
    if (picture.left > _clipZone.left) dx = _clipZone.left - picture.left;
    if (picture.right < _clipZone.right) dx = _clipZone.right - picture.right;
    if (picture.top > _clipZone.top) dy = _clipZone.top - picture.top;
    if (picture.bottom < _clipZone.bottom) {
      dy = _clipZone.bottom - picture.bottom;
    }
    _controller.value = _matrixTranslate(_controller.value, Offset(dx, dy));
    _updatePictureZone();
  }

  _GestureType _getGestureType(ScaleUpdateDetails details) {
    return details.pointerCount > 1 ? _GestureType.scale : _GestureType.pan;
  }

  Matrix4 _matrixTranslate(Matrix4 matrix, Offset translation) {
    return matrix.clone()
      ..translateByDouble(translation.dx, translation.dy, 0, 1);
  }

  Matrix4 _matrixScale(Matrix4 matrix, double scale) {
    final double currentScale = _controller.value.getMaxScaleOnAxis();
    final double totalScale = currentScale * scale;
    final double clampedScale =
        ui.clampDouble(totalScale, 0.8, 4.0) / currentScale;
    return matrix.clone()..scaleByDouble(clampedScale, clampedScale, 1, 1);
  }
}

enum _GestureType { pan, scale }

class _RectNotifier extends ValueNotifier<Rect> {
  _RectNotifier() : super(Rect.zero);
}

class _ImagePainter extends CustomPainter {
  /// 当前图片信息。
  final ImageInfo? imageInfo;

  /// 图片实时绘制区域。
  final _RectNotifier rectNotifier;

  _ImagePainter({required this.imageInfo, required this.rectNotifier})
      : super(repaint: rectNotifier);

  @override
  void paint(Canvas canvas, Size size) {
    if (imageInfo == null) return;
    final ui.Image image = imageInfo!.image;
    final Rect source = Rect.fromLTWH(
      0,
      0,
      image.width.toDouble(),
      image.height.toDouble(),
    );
    final Rect destination = rectNotifier.value;
    final double side = size.shortestSide * 0.9;
    final Rect zone = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: side,
      height: side,
    );
    canvas.drawImageRect(
      image,
      source,
      destination,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.5)
        ..filterQuality = FilterQuality.high,
    );
    canvas.save();
    canvas.clipRect(zone);
    canvas.drawImageRect(
      image,
      source,
      destination,
      Paint()..filterQuality = FilterQuality.high,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ImagePainter oldDelegate) => true;
}

class _CropOverlayPainter extends CustomPainter {
  const _CropOverlayPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double side = size.shortestSide * 0.9;
    final Rect zone = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: side,
      height: side,
    );
    canvas.drawRect(
      zone,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.white
        ..strokeWidth = 1,
    );
    final Paint gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white
      ..strokeWidth = 0.5;
    final Path path = Path()
      ..moveTo(zone.left + side / 3, zone.top)
      ..relativeLineTo(0, side)
      ..moveTo(zone.left + side * 2 / 3, zone.top)
      ..relativeLineTo(0, side)
      ..moveTo(zone.left, zone.top + side / 3)
      ..relativeLineTo(side, 0)
      ..moveTo(zone.left, zone.top + side * 2 / 3)
      ..relativeLineTo(side, 0);
    canvas.drawPath(path, gridPaint);
  }

  @override
  bool shouldRepaint(covariant _CropOverlayPainter oldDelegate) => false;
}
