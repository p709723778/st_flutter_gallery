import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:st/app/constants/number_key.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/video_url/video_url_get_req_model.dart';
import 'package:st/app/modules/ministry_mark/dsm_params/dsm_params_set/dsm_params_set_logic.dart';

class DsmParamsSetPage extends StatelessWidget {
  const DsmParamsSetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<DsmParamsSetLogic>();

    return GetBuilder<DsmParamsSetLogic>(
      init: logic,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'DSM参数设置',
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
              children: [
                if (SocketMessageManager.instance.linkType == LinkType.tcp)
                  AspectRatio(
                    aspectRatio: aspectRatio_H,
                    child: IgnorePointer(
                      child: Video(
                        controller: logic.videoController,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      onPressed: logic.done,
                      child: const Text(
                        '开始标定',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      title: Text(logic.dsmParamsInfo),
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
