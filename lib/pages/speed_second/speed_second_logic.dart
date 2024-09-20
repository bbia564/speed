import 'package:get/get.dart';
import 'package:get_speed/db_speed/db_speed.dart';

import '../../db_speed/speed_entity.dart';

class SpeedSecondLogic extends GetxController {

  DBSpeed dbSpeed = Get.find<DBSpeed>();

  var list = <SpeedEntity>[].obs;

  void getData() async {
    list.value = await dbSpeed.getAllData();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

}
