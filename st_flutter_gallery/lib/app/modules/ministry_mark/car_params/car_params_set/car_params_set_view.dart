import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/models/car_params/area_city_model.dart';
import 'package:st/app/modules/ministry_mark/car_params/car_params_set/car_params_set_logic.dart';

class CarParamsSetPage extends StatelessWidget {
  const CarParamsSetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<CarParamsSetLogic>();

    return GetBuilder<CarParamsSetLogic>(
      init: logic,
      builder: (logic) {
        if (logic.provinceList.isEmpty) return const SizedBox();
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                '车辆参数信息设置',
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: logic.done,
                  child: const Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                ),
              ],
              centerTitle: true,
            ),
            body: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ListTile(
                    title: Text(
                      '省份'.tr,
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: DropdownButtonHideUnderline(
                      child: DropdownButton2<AreaCityModel>(
                        isExpanded: true,
                        hint: const Text(
                          '请选择省份',
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
                        items: logic.provinceList
                            .map(
                              (AreaCityModel e) =>
                                  DropdownMenuItem<AreaCityModel>(
                                value: e,
                                child: Text(
                                  '${e.name}(${e.adcode})',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        value: logic.selectedAreaCityModel,
                        onChanged: logic.dropdownProvinceChanged,
                        buttonStyleData: const ButtonStyleData(
                          height: 50,
                          width: 200,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ListTile(
                    title: Text(
                      '城市'.tr,
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: DropdownButtonHideUnderline(
                      child: DropdownButton2<Districts>(
                        isExpanded: true,
                        hint: const Text(
                          '请选择城市',
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
                        items: logic.cityList
                            .map(
                              (Districts e) => DropdownMenuItem<Districts>(
                                value: e,
                                child: Text(
                                  '${e.name}(${e.adcode})',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        value: logic.selectedDistricts,
                        onChanged: logic.dropdownCityChanged,
                        buttonStyleData: const ButtonStyleData(
                          height: 50,
                          width: 200,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: logic.controllerManufacturerId,
                  decoration: const InputDecoration(
                    labelText: '制造商ID',
                    hintText: "请输入制造商ID(行政区划代码和制造商 ID 组成)",
                    hintStyle: TextStyle(fontSize: 12),
                    labelStyle: TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: logic.controllerTerminalMode,
                  decoration: const InputDecoration(
                    labelText: '终端型号',
                    hintText: "请输入终端型号",
                    hintStyle: TextStyle(fontSize: 12),
                    labelStyle: TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: logic.controllerTerminalId,
                  decoration: const InputDecoration(
                    labelText: '终端ID',
                    hintText: "请输入终端ID",
                    hintStyle: TextStyle(fontSize: 12),
                    labelStyle: TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ListTile(
                    title: Text(
                      '车牌颜色'.tr,
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: DropdownButtonHideUnderline(
                      child: DropdownButton2<CarNumberColor>(
                        isExpanded: true,
                        hint: const Text(
                          '请选择车牌颜色',
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
                        items: CarNumberColor.values
                            .map(
                              (CarNumberColor e) =>
                                  DropdownMenuItem<CarNumberColor>(
                                value: e,
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
                        value: logic.selectedCarNumberColor,
                        onChanged: logic.dropdownColorChanged,
                        buttonStyleData: const ButtonStyleData(
                          height: 50,
                          width: 100,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: logic.controllerCarNumber,
                  decoration: const InputDecoration(
                    labelText: '车牌号',
                    hintText: "请输入车牌号(如果未上牌则填车架号)",
                    hintStyle: TextStyle(fontSize: 12),
                    labelStyle: TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                // const SizedBox(height: 10),
                // TextField(
                //   controller: logic.controllerImpulseCoefficient,
                //   keyboardType: const TextInputType.numberWithOptions(
                //     decimal: true,
                //   ),
                //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                //   decoration: const InputDecoration(
                //     labelText: '脉冲系数',
                //     hintText: "请输入脉冲系数",
                //     hintStyle: TextStyle(fontSize: 12),
                //     labelStyle: TextStyle(fontSize: 12),
                //     border: OutlineInputBorder(
                //       ///设置边框四个角的弧度
                //       borderRadius: BorderRadius.all(Radius.circular(10)),
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 10),
                // DecoratedBox(
                //   decoration: BoxDecoration(
                //     border: Border.all(color: Colors.grey),
                //     borderRadius: const BorderRadius.all(Radius.circular(10)),
                //   ),
                //   child: ListTile(
                //     title: Text(
                //       '省份'.tr,
                //       style: const TextStyle(fontSize: 14),
                //     ),
                //     trailing: DropdownButtonHideUnderline(
                //       child: DropdownButton2<int>(
                //         isExpanded: true,
                //         hint: const Text(
                //           '请选择省份',
                //           style: TextStyle(
                //             fontSize: 14,
                //             color: Colors.white,
                //           ),
                //         ),
                //         style: const TextStyle(
                //           fontSize: 14,
                //           color: Colors.white,
                //         ),
                //         iconStyleData: const IconStyleData(
                //           iconDisabledColor: Colors.purple,
                //           iconEnabledColor: Colors.purple,
                //         ),
                //         items: logic.featureList
                //             .map(
                //               (VideoUrlType e) => DropdownMenuItem<int>(
                //                 value: e.value,
                //                 child: Text(
                //                   e.title,
                //                   style: const TextStyle(
                //                     fontSize: 14,
                //                     color: Colors.purple,
                //                   ),
                //                 ),
                //               ),
                //             )
                //             .toList(),
                //         value: logic.dropdownIndex,
                //         onChanged: logic.dropdownChanged,
                //         // customButton: const SizedBox(
                //         //   width: 120,
                //         //   child: Row(
                //         //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         //     children: [
                //         //       SizedBox(width: 20),
                //         //       Text(
                //         //         '测试',
                //         //         style: TextStyle(
                //         //           fontSize: 14,
                //         //           color: Colors.white,
                //         //         ),
                //         //       ),
                //         //       Icon(
                //         //         Icons.arrow_drop_down,
                //         //         color: Colors.black,
                //         //       ),
                //         //     ],
                //         //   ),
                //         // ),
                //         buttonStyleData: const ButtonStyleData(
                //           height: 20,
                //           width: 100,
                //         ),
                //       ),
                //     ),
                //     onTap: () async {},
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
