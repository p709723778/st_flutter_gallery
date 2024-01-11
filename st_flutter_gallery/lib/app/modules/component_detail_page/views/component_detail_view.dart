import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/components/appbar/custom_appbar.dart';
import 'package:st/app/modules/component_detail_page/controllers/component_detail_page_controller.dart';

class ComponentDetailView extends GetView<ComponentDetailPageController> {
  const ComponentDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'ComponentDetailPageView',
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Column(
            children: [
              Text(
                '容器组件',
                style: TextStyle(fontSize: 20),
              ),
              Center(
                child: Text(
                  'ComponentDetailPageView is working',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (context, int index) {
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
