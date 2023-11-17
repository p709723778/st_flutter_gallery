import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/models/algorithm_mark_model/algorithm_mark_set_req_model.dart';
import 'package:st/app/modules/ministry_mark/algorithm_mark/controllers/algorithm_mark_set_logic.dart';

class AlgorithmMarkSetPage extends StatelessWidget {
  const AlgorithmMarkSetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<AlgorithmMarkSetLogic>();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '算法标定设置',
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
        ),
        body: GridView.count(
          padding: const EdgeInsets.all(20),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          childAspectRatio: 2,
          children: logic.featureList.map((e) {
            return item(e, logic);
          }).toList(),
        ),
      ),
    );
  }

  Widget item(AlgorithmMarkType item, AlgorithmMarkSetLogic logic) {
    return GestureDetector(
      onTap: () {
        logic.onTapItem(item);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Text(
          item.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
