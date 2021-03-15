import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/src/devices/mockup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PreviewRenderView extends RenderView {
  PreviewRenderView({
    RenderBox? child,
    required ViewConfiguration configuration,
    required ui.FlutterView window,
  }) : super(
          child: child,
          configuration: configuration,
          window: window,
        );

  DeviceMockupRenderer? _mockupRenderer;

  Device? _device;
  Device? get device => _device;
  set device(Device? value) {
    if (_device?.id != value?.id) {
      _device = value;
      markNeedsPaint();
      value?.createRenderer(value.id).then((value) {
        _mockupRenderer = value;
        markNeedsPaint();
      });
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.drawColor(Colors.white, BlendMode.color);

    if (_mockupRenderer != null) {
      _mockupRenderer!.paintFrame(
        context: context,
        offset: offset,
        needsCompositing: needsCompositing,
        paintApp: super.paint,
      );
    }
  }
}