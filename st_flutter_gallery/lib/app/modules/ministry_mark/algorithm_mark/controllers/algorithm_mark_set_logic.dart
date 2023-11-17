import 'package:get/get.dart';
import 'package:st/app/models/algorithm_mark_model/algorithm_mark_set_req_model.dart';

class AlgorithmMarkSetLogic extends GetxController {
  final List<AlgorithmMarkType> featureList = [];

  @override
  void onInit() {
    featureList.addAll(AlgorithmMarkType.values);

    super.onInit();
  }

  /// 发送命令
  void onTapItem(AlgorithmMarkType type) {
    AlgorithmMarkSetReqModel.sendCommand(type);

    // final reqModel = AlgorithmMarkSetReqModel(dataBytes: [model.type.value]);
    // SocketMessageManager.instance.sendMessage(reqModel.commandFrame);
  }
}
