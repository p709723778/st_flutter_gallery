import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:st/app/components/rectangle/rectangle_painter.dart';
import 'package:st/app/constants/number_key.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/video_url/video_url_get_req_model.dart';
import 'package:st/app/modules/ministry_mark/bsd_params/bsd_params_set/bsd_params_set_logic.dart';
import 'package:st/utils/text_input_formatter/text_input_formatter_util.dart';

class BsdParamsSetPage extends StatelessWidget {
  const BsdParamsSetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<BsdParamsSetLogic>();

    return GetBuilder<BsdParamsSetLogic>(
      init: logic,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'BSD参数设置',
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                if (SocketMessageManager.instance.linkType == LinkType.tcp)
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<int>(
                      isExpanded: true,
                      hint: const Text(
                        '请选择通道',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      iconStyleData: const IconStyleData(
                        iconDisabledColor: Colors.purple,
                        iconEnabledColor: Colors.purple,
                      ),
                      items: logic.featureList
                          .map(
                            (VideoUrlType e) => DropdownMenuItem<int>(
                              value: e.value,
                              child: Text(
                                e.title,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      value: logic.dropdownIndex,
                      onChanged: logic.dropdownChanged,
                      // customButton: const SizedBox(
                      //   width: 120,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       SizedBox(width: 20),
                      //       Text(
                      //         '测试',
                      //         style: TextStyle(
                      //           fontSize: 14,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //       Icon(
                      //         Icons.arrow_drop_down,
                      //         color: Colors.black,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      buttonStyleData: const ButtonStyleData(
                        height: 20,
                        width: 100,
                      ),
                    ),
                  ),
              ],
              centerTitle: true,
            ),
            body: ListView(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              controller: logic.scrollController,
              children: [
                if (SocketMessageManager.instance.linkType == LinkType.tcp)
                  AspectRatio(
                    aspectRatio: aspectRatio_H,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: AspectRatio(
                            aspectRatio: aspectRatio_H,
                            // width: MediaQuery.of(context).size.width,
                            // height: MediaQuery.of(context).size.width * 9.0 / 16.0,
                            // Use [Video] widget to display video output.
                            child: IgnorePointer(
                              child: Video(controller: logic.videoController),
                            ),
                          ),
                        ),
                        if (logic.dropdownIndex == VideoUrlType.bsd.value) ...[
                          if (logic.rectangleA.isNotEmpty)
                            Positioned.fill(
                              child: AspectRatio(
                                aspectRatio: aspectRatio_H,
                                child: ColoredBox(
                                  color: Colors.transparent,
                                  child: CustomPaint(
                                    painter: RectanglePainter(
                                      logic.rectangleA,
                                      color: Colors.red,
                                    ),
                                    // size: const Size(100, 100),
                                  ),
                                ),
                              ),
                            ),
                          if (logic.rectangleB.isNotEmpty)
                            Positioned.fill(
                              child: AspectRatio(
                                aspectRatio: aspectRatio_H,
                                child: ColoredBox(
                                  color: Colors.transparent,
                                  child: CustomPaint(
                                    painter: RectanglePainter(
                                      logic.rectangleB,
                                      color: Colors.yellow,
                                    ),
                                    // size: const Size(100, 100),
                                  ),
                                ),
                              ),
                            ),
                          if (logic.rectangleC.isNotEmpty)
                            Positioned.fill(
                              child: AspectRatio(
                                aspectRatio: aspectRatio_H,
                                child: ColoredBox(
                                  color: Colors.transparent,
                                  child: CustomPaint(
                                    painter: RectanglePainter(
                                      logic.rectangleC,
                                      color: Colors.blue,
                                    ),
                                    // size: const Size(100, 100),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ],
                    ),
                  ),
                // AspectRatio(
                //   aspectRatio: 1,
                //   child: FijkView(
                //     player: logic.player,
                //   ),
                // ),
                const SizedBox(height: 20),
                ListView(
                  shrinkWrap: true,
                  controller: logic.scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                          ),
                          onPressed: logic.done,
                          child: const Text(
                            '开始标定',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                          ),
                          onPressed: logic.openBsdLine,
                          child: const Text(
                            '打开BSD辅助线',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                          ),
                          onPressed: logic.clearBsdLine,
                          child: const Text(
                            '清除辅助线',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: logic.controller1,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [TextInputFormatterUtil.numbers],
                      decoration: const InputDecoration(
                        labelText: '摄像头安装高度(mm)',
                        hintText: "请输入摄像头安装高度(mm)",
                        border: OutlineInputBorder(
                          ///设置边框四个角的弧度
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: logic.controller2,
                      keyboardType: TextInputType.number,
                      inputFormatters: [TextInputFormatterUtil.numbers],
                      decoration: const InputDecoration(
                        labelText: '一级报警距离(mm)',
                        hintText: "请输入一级报警距离(mm)",
                        border: OutlineInputBorder(
                          ///设置边框四个角的弧度
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: logic.controller3,
                      keyboardType: TextInputType.number,
                      inputFormatters: [TextInputFormatterUtil.numbers],
                      decoration: const InputDecoration(
                        labelText: '二级报警距离(mm)',
                        hintText: "请输入二级报警距离(mm)",
                        border: OutlineInputBorder(
                          ///设置边框四个角的弧度
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: logic.controller4,
                      keyboardType: TextInputType.number,
                      inputFormatters: [TextInputFormatterUtil.numbers],
                      decoration: const InputDecoration(
                        labelText: '三级报警距离(mm)',
                        hintText: "请输入三级报警距离(mm)",
                        border: OutlineInputBorder(
                          ///设置边框四个角的弧度
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: logic.controller5,
                      keyboardType: TextInputType.number,
                      inputFormatters: [TextInputFormatterUtil.numbers],
                      decoration: const InputDecoration(
                        labelText: '前方报警距离(mm)',
                        hintText: "请输入前方报警距离(mm)",
                        border: OutlineInputBorder(
                          ///设置边框四个角的弧度
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
