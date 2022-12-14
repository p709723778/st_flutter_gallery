import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/components/custom_appbar.dart';
import 'package:st/app/modules/query_work_face/controllers/query_work_face_controller.dart';

class QueryWorkFaceView extends GetView<QueryWorkFaceController> {
  const QueryWorkFaceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      appBar: const CustomAppbar(
        title: '工作面',
      ),
      body: GetBuilder<QueryWorkFaceController>(
        builder: (logic) {
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              final model = controller.list[index];
              return ListTile(
                onTap: () {
                  Get.back(result: model);
                },
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                title: Text(
                  model.key!,
                  style: Get.theme.textTheme.bodyText2,
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 1,
                color: Get.theme.dividerColor,
                indent: 16,
              );
            },
            itemCount: controller.list.length,
          );
        },
      ),
    );
  }
}
