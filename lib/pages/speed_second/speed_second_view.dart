import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_speed/pages/speed_second/speed_Item.dart';
import 'package:styled_widget/styled_widget.dart';

import 'speed_second_logic.dart';

class SpeedSecondPage extends GetView<SpeedSecondLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test record'),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Obx(() {
            return controller.list.value.isEmpty
                ? const Center(
                    child: Text('No data'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: controller.list.value.length,
                    itemBuilder: (_, index) {
                      final entity = controller.list.value[index];
                      return SpeedItem(entity);
                    });
          }),
        )
            .decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(10))
            .marginAll(15),
      ),
    );
  }
}
