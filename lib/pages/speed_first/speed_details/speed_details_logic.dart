import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_speed/db_speed/db_speed.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpeedDetailsLogic extends GetxController {

  DBSpeed dbSpeed = Get.find<DBSpeed>();

  final index = Get.arguments;
  final subTitles = ['Current running speed','Current bike speed', 'Current motorcycle speed','Current car speed'];
  var speedString = '- M/s'.obs;

  late LocationData _locationData;
  var timeString = 'Not yet started'.obs;
  var isStart = false;
  int speedNum = 0;

  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionStatus;

  var isOpen = false;

  Timer? _timer;

  void checkLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? repeat = prefs.getBool('location');
    if (repeat == true) {
      isOpen = true;
      isStart = true;
      startTimer();
      return;
    }
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        isOpen = false;
        await prefs.setBool('location', false);
        return;
      }
    }
    _permissionStatus = await location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      if (repeat != true) {
        Fluttertoast.showToast(
            msg:
                'This app location permission has been denied, please go to Settings to enable');
      }
      _permissionStatus = await location.requestPermission();
      if (_permissionStatus == PermissionStatus.granted) {
        isOpen = true;
        await prefs.setBool('location', true);
        isStart = true;
        startTimer();
      }
      if (_permissionStatus != PermissionStatus.granted) {
        return;
      }
    } else {
      if (_permissionStatus == PermissionStatus.granted) {
        isOpen = true;
        await prefs.setBool('location', true);
        isStart = true;
        startTimer();
      }
    }
  }

  void startTimer() {
    final now = DateTime.now();
    timeString.value = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    update();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final now = DateTime.now();
      timeString.value = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
      _locationData = await location.getLocation();
      final speed = _locationData.speed;
      if (speed != null) {
        speedNum = (speed * 3.6).toInt();
        speedString.value = '$speedNum M/s';
        if (!isStart) {
          speedString.value = '- M/s';
        }
      } else {
        speedString.value = '- M/s';
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void saveData() async {
    stopTimer();
    isStart = false;
    update();
    speedString.value = '- M/s';
    timeString.value = 'Not yet started';
    await dbSpeed.dbBase.insert('speed', {
      'created_time': DateTime.now().toIso8601String(),
      'type': index,
      'speed': speedNum,
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    update();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    stopTimer();
    super.onClose();
  }
}
