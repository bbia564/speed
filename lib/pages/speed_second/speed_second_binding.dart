import 'package:get/get.dart';

import 'speed_second_logic.dart';

class SpeedSecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SpeedSecondLogic());
  }
}
