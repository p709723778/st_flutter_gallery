import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/components/custom_appbar.dart';
import 'package:st/app/modules/jobs/replenishment_job/controllers/replenishment_job_controller.dart';

class ReplenishmentJobView extends GetView<ReplenishmentJobController> {
  const ReplenishmentJobView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      appBar: const CustomAppbar(
        title: '作业补录',
      ),
      body: const Center(
        child: Text(
          'ReplenishmentJobView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
