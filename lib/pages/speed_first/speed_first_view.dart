import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_speed/main.dart';
import 'package:styled_widget/styled_widget.dart';

import 'speed_first_logic.dart';

class SpeedFirstPage extends GetView<SpeedFirstLogic> {
  Widget _item(int index) {
    return GestureDetector(
      child: Container(
        padding:const EdgeInsets.symmetric(horizontal: 15),
        height: 70,
        child: <Widget>[
          <Widget>[
            Image.asset(
              'assets/image$index.webp',
              width: 27,
              height: 27,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(customTitles[index])
          ].toRow(),
          const Icon(
            Icons.keyboard_arrow_right,
            size: 20,
            color: Colors.black,
          )
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
      ).decorated(color: Colors.white, borderRadius: BorderRadius.circular(12)).marginOnly(bottom: 10),
      onTap: () {
        Get.toNamed('/speedDetails',arguments: index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            Image.asset(
              'assets/homeTapLogo.webp',
              width: 104,
              height: 104,
            ),
            const Text(
              'Speed detection tool',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            _item(0),
            _item(1),
            _item(2),
            _item(3),
          ].toColumn(),
        ).marginAll(15)),
      ),
    );
  }
}
