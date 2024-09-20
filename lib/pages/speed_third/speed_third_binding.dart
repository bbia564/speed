import 'package:get/get.dart';

import 'speed_third_logic.dart';

class SpeedThirdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SpeedThirdLogic());
  }
}
