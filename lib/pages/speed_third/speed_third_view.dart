import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'speed_third_logic.dart';

class SpeedThirdPage extends GetView<SpeedThirdLogic> {
  Widget _item(int index, BuildContext context) {
    final titles = ['Authorized GPS location','Clear initial record', 'Privacy Agreement','Version'];
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: 40,
        child: <Widget>[
          Expanded(
              child: Text(
            titles[index],
            style: const TextStyle(fontSize: 15, color: Colors.black),
          )),
          index == 0
              ? Obx(() {
                  return Switch(
                      value: controller.isOpen.value,
                      activeTrackColor: Colors.green,
                      onChanged: (value) {
                        controller.checkLocation();
                      });
                })
              : index == 3 ? Text('1.0.0').padding(right: 14) : const Icon(Icons.keyboard_arrow_right,
                  size: 20, color: Colors.grey),
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
      ),
      onTap: () {
        if (index != 0) {
          switch (index) {
            case 1:
              controller.cleanSpeedData();
              break;
            case 2:
              controller.aboutSpeedPrivacy(context);
              break;
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              child: <Widget>[
                _item(0, context),
                _item(1, context),
                _item(2, context),
                _item(3, context),
              ].toColumn(separator: Divider(height: 15,color: Colors.grey.withOpacity(0.3),)),
            ).decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(10))
          ].toColumn(),
        ).marginAll(15)),
      ),
    );
  }
}
