import 'package:get/get.dart';

import 'speed_first_logic.dart';

class SpeedFirstBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SpeedFirstLogic());
  }
}
