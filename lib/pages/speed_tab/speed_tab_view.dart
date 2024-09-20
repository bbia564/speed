import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_speed/main.dart';
import 'package:get_speed/pages/speed_first/speed_first_view.dart';
import 'package:get_speed/pages/speed_second/speed_second_view.dart';
import 'package:get_speed/pages/speed_third/speed_third_view.dart';

import '../speed_second/speed_second_logic.dart';
import 'speed_tab_logic.dart';

class SpeedTabPage extends GetView<SpeedTabLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          SpeedFirstPage(),
          SpeedSecondPage(),
          SpeedThirdPage()
        ],
      ),
      bottomNavigationBar: Obx(()=>_navSpeedBars()),
    );
  }

  Widget _navSpeedBars() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home,color: Colors.grey.withOpacity(0.6)),
          activeIcon:Icon(Icons.home,color: primaryColor),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment,color: Colors.grey.withOpacity(0.6)),
          activeIcon:Icon(Icons.assignment,color: primaryColor),
          label: 'Records',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings,color: Colors.grey.withOpacity(0.6)),
          activeIcon:Icon(Icons.settings,color: primaryColor),
          label: 'Setting',
        ),
      ],
      currentIndex: controller.currentIndex.value,
      onTap: (index) {
        controller.currentIndex.value = index;
        controller.pageController.jumpToPage(index);
        if (index == 1) {
          SpeedSecondLogic speedSecondLogic = Get.find<SpeedSecondLogic>();
          speedSecondLogic.getData();
        }
      },
    );
  }
}
