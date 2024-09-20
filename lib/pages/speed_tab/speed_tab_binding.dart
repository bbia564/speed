import 'package:get/get.dart';

import '../speed_first/speed_first_logic.dart';
import '../speed_second/speed_second_logic.dart';
import '../speed_third/speed_third_logic.dart';
import 'speed_tab_logic.dart';

class SpeedTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SpeedTabLogic());
    Get.lazyPut(() => SpeedFirstLogic());
    Get.lazyPut(() => SpeedSecondLogic());
    Get.lazyPut(() => SpeedThirdLogic());
  }
}
