import 'package:flutter/material.dart';
import 'package:st/app/components/rectangle/dotted_rectangle_painter.dart';
import 'package:st/app/components/rectangle/rectangle_painter.dart';
import 'package:st/app/constants/number_key.dart';

class VideoMarkPageView extends StatefulWidget {
  const VideoMarkPageView({super.key});

  @override
  State<VideoMarkPageView> createState() => _VideoMarkPageViewState();
}

class _VideoMarkPageViewState extends State<VideoMarkPageView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final points = [
      Offset.zero, // 左上角
      const Offset(100, 0), // 右上角
      const Offset(100, 100), // 右下角
      const Offset(0, 100), // 左下角
    ];

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '视频标定',
            style: TextStyle(fontSize: 16),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 0),
              AspectRatio(
                aspectRatio: aspectRatio_H,
                child: ColoredBox(
                  color: Colors.transparent,
                  child: CustomPaint(
                    painter: DottedRectanglePainter(points),
                    // size: const Size(100, 100),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              AspectRatio(
                aspectRatio: aspectRatio_H,
                child: ColoredBox(
                  color: Colors.transparent,
                  child: CustomPaint(
                    painter: RectanglePainter(points),
                    // size: const Size(100, 100),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
