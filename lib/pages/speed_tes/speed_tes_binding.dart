import 'package:get/get.dart';

import 'speed_tes_logic.dart';

class SpeedTesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
