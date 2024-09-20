import 'package:get/get.dart';

import 'speed_details_logic.dart';

class SpeedDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SpeedDetailsLogic());
  }
}
