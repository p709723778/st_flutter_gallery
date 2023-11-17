import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:st/app/constants/number_key.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/video_url/video_url_get_req_model.dart';
import 'package:st/app/modules/ministry_mark/adas_params/adas_params_set/adas_params_set_logic.dart';
import 'package:st/utils/text_input_formatter/text_input_formatter_util.dart';

class AdasParamsSetPage extends StatelessWidget {
  const AdasParamsSetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<AdasParamsSetLogic>();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetBuilder<AdasParamsSetLogic>(
        init: logic,
        builder: (logic) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'ADAS参数设置',
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
              controller: logic.scrollController,
              padding: const EdgeInsets.only(bottom: 20),
              children: [
                if (SocketMessageManager.instance.linkType == LinkType.tcp)
                  AspectRatio(
                    aspectRatio: aspectRatio_H,
                    child: IgnorePointer(
                      child: Video(controller: logic.videoController),
                    ),
                  ),
                ListView(
                  shrinkWrap: true,
                  controller: logic.scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    const SizedBox(height: 20),
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
                          onPressed: logic.openAdasLine,
                          child: const Text(
                            '打开ADAS辅助线',
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
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [TextInputFormatterUtil.numbers],
                      decoration: const InputDecoration(
                        labelText: '车宽（mm）',
                        hintText: "请输入车宽（mm）",
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
                        labelText: '相机与车辆中心之间的距离(从驾驶室往外看，左正右负)（mm）',
                        hintText: "请输入相机与车辆中心之间的距离(从驾驶室往外看，左正右负)（mm）",
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
                        labelText: '相机到前保险杠距离（mm）',
                        hintText: "请输入相机到前保险杠距离（mm）",
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
                        labelText: '镜头和前轮胎之间距离(镜头前方为正)（mm）',
                        hintText: "请输入镜头和前轮胎之间距离(镜头前方为正)（mm）",
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
                        labelText: '相机距离地面高度（mm）',
                        hintText: "请输入相机距离地面高度（mm）",
                        border: OutlineInputBorder(
                          ///设置边框四个角的弧度
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: logic.controller6,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '相机焦距（mm）',
                        hintText: "请输入相机焦距（mm）",
                        border: OutlineInputBorder(
                          ///设置边框四个角的弧度
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: logic.controller7,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'sensor尺寸（mm/像素）',
                        hintText: "请输入sensor尺寸（mm/像素）",
                        border: OutlineInputBorder(
                          ///设置边框四个角的弧度
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: logic.controller8,
                      keyboardType: TextInputType.number,
                      inputFormatters: [TextInputFormatterUtil.numbers],
                      decoration: const InputDecoration(
                        labelText: '车长（mm）',
                        hintText: "请输入车长（mm）",
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
          );
        },
      ),
    );
  }
}
