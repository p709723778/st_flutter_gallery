import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/link_mode/bluetooth/bluetooth_scan_classic_server_page/bluetooth_scan_classic_server_page_logic.dart';

class BluetoothScanClassicServerPage extends StatelessWidget {
  const BluetoothScanClassicServerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<BluetoothScanClassicServerPageLogic>();

    return GetBuilder<BluetoothScanClassicServerPageLogic>(
      init: logic,
      builder: (logic) {
        return Scaffold(
          backgroundColor: Colors.blue.withOpacity(0.5),
          appBar: AppBar(
            title: const Text(
              '蓝牙服务器模式',
              style: TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (logic.isConnected || logic.isScanning) {
                    logic.disconnect();
                  } else {
                    logic.scan();
                  }
                },
                child: logic.isConnected
                    ? const Icon(
                        Icons.bluetooth,
                        color: Colors.green,
                      )
                    : logic.isScanning
                        ? const Text(
                            '停止扫描',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          )
                        : const Icon(
                            Icons.bluetooth_disabled,
                            color: Colors.red,
                          ),
              ),
            ],
            centerTitle: true,
          ),
          body: logic.isConnected
              ? Center(child: Text('当前连接的设备为:${logic.connectDeviceName}'))
              : !logic.isScanning
                  ? const Center(
                      child: Text(
                        '请开启蓝牙服务器模式',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : Stack(
                      children: [
                        Positioned.fill(
                          left: 10,
                          right: 10,
                          child: Center(
                            child: Stack(
                              children: [
                                const Positioned.fill(
                                  child: RadarView(),
                                ),
                                Positioned(
                                  child: Center(
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.7),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.white.withOpacity(.5),
                                            blurRadius: 1,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.bluetooth,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
        );
      },
    );
  }
}

class RadarView extends StatefulWidget {
  const RadarView({super.key});

  @override
  RadarViewState createState() => RadarViewState();
}

class RadarViewState extends State<RadarView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _animation = Tween(begin: 0.toDouble(), end: pi * 2.0).animate(_controller);
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: RadarPainter(_animation.value),
        );
      },
    );
  }
}

class RadarPainter extends CustomPainter {
  RadarPainter(this.angle);
  final double angle;

  final Paint _bgPaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;

  final Paint _paint = Paint()..style = PaintingStyle.fill;

  int circleCount = 3;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.width / 2, size.height / 2);

    canvas
      ..drawLine(
        Offset(size.width / 2, size.height / 2 - radius),
        Offset(size.width / 2, size.height / 2 + radius),
        _bgPaint,
      )
      ..drawLine(
        Offset(size.width / 2 - radius, size.height / 2),
        Offset(size.width / 2 + radius, size.height / 2),
        _bgPaint,
      );

    for (var i = 1; i <= circleCount; ++i) {
      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        radius * i / circleCount,
        _bgPaint,
      );
    }

    _paint.shader = ui.Gradient.sweep(
      Offset(size.width / 2, size.height / 2),
      [Colors.white.withOpacity(.01), Colors.white.withOpacity(.5)],
      [.0, 1.0],
      TileMode.clamp,
      0,
      pi / 12,
    );

    canvas.save();
    final r = sqrt(pow(size.width, 2) + pow(size.height, 2));
    final startAngle = atan(size.height / size.width);
    final p0 = Point(r * cos(startAngle), r * sin(startAngle));
    final px = Point(r * cos(angle + startAngle), r * sin(angle + startAngle));
    canvas
      ..translate((p0.x - px.x) / 2, (p0.y - px.y) / 2)
      ..rotate(angle)
      ..drawArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: radius,
        ),
        0,
        pi / 12,
        true,
        _paint,
      )
      ..restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
