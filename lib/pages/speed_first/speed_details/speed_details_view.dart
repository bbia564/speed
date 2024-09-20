import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_speed/main.dart';
import 'package:styled_widget/styled_widget.dart';

import 'speed_details_logic.dart';

class SpeedDetailsPage extends GetView<SpeedDetailsLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: GetBuilder<SpeedDetailsLogic>(init: SpeedDetailsLogic(),builder: (_) {
          return SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: <Widget>[
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 410,
                      padding: const EdgeInsets.all(15),
                      child: <Widget>[
                        Text(
                          customTitles[controller.index],
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ).marginOnly(top: 45),
                        Obx(() {
                          return Text(
                            controller.timeString.value
                                ,
                            style: TextStyle(
                                color: controller.isStart ? primaryColor : Colors
                                    .grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          );
                        }),
                        Divider(
                          height: 30,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 134,
                          child: <Widget>[
                            Text(
                              controller.subTitles[controller.index],
                              style: TextStyle(fontSize: 16,
                                  color: controller.isStart
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            Obx(() {
                              return Text(
                                controller.speedString.value,
                                style: TextStyle(
                                    fontSize: 28,
                                    color: controller.isStart
                                        ? Colors.white
                                        : Colors.grey,
                                    fontWeight: FontWeight.bold),
                              );
                            })
                          ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
                        ).decorated(
                            color: controller.isStart ? Colors.orange : Colors.grey.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(67)),
                        const SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            child: Text(
                              controller.isStart ? 'Stop and record' : 'Start',
                              style: TextStyle(
                                  color: controller.isStart ? const Color(
                                      0xff606060) : Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ).decorated(
                              color: controller.isStart ? Colors.grey.withOpacity(
                                  0.5) : primaryColor,
                              borderRadius: BorderRadius.circular(12)),
                          onTap: () {
                            if (controller.isStart) {
                              controller.saveData();
                            } else {
                              controller.checkLocation();
                            }
                          },
                        )
                      ].toColumn(),
                    )
                        .decorated(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12))
                        .marginOnly(top: 44),
                    Container(
                      width: 88,
                      height: 88,
                      child: Image.asset(
                        'assets/image${controller.index}.webp',
                        width: 54,
                        height: 54,
                      ),
                    ).decorated(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 6,
                              offset: const Offset(0, 3))
                        ],
                        borderRadius: BorderRadius.circular(44))
                  ],
                )
              ].toColumn(),
            ),
          );
        }).marginAll(12),
      ),
    );
  }
}
