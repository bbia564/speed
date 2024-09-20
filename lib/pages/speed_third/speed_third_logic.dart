import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_speed/db_speed/db_speed.dart';
import 'package:get_speed/pages/speed_second/speed_second_logic.dart';
import 'package:location/location.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpeedThirdLogic extends GetxController {

  DBSpeed dbSpeed = Get.find<DBSpeed>();

  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionStatus;

  var isOpen = false.obs;

  void checkLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? repeat = prefs.getBool('location');
    if (repeat == true) {
      isOpen.value = false;
      await prefs.setBool('location', false);
      return;
    }
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        isOpen.value = false;
        await prefs.setBool('location', false);
        return;
      }
    }
    _permissionStatus = await location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      if (repeat != true) {
        Fluttertoast.showToast(msg: 'This app location permission has been denied, please go to Settings to enable');
      }
      _permissionStatus = await location.requestPermission();
      if (_permissionStatus == PermissionStatus.granted) {
        isOpen.value = true;
        await prefs.setBool('location', true);
      }
      if (_permissionStatus != PermissionStatus.granted) {
        return;
      }
    } else {
      if (_permissionStatus == PermissionStatus.granted) {
        isOpen.value = true;
        await prefs.setBool('location', true);
      }
    }
  }

  cleanSpeedData() async {
    Get.dialog(AlertDialog(
      title: const Text('Warm reminder'),
      content: const Text('Do you want to clean all data?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel',style: TextStyle(color: Colors.black),),
        ),
        TextButton(
          onPressed: () async {
            await dbSpeed.cleanAllData();
            SpeedSecondLogic speedSecondLogic = Get.find<SpeedSecondLogic>();
            speedSecondLogic.getData();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  aboutSpeedPrivacy(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Privacy Policy"),
          ),
          body: const Markdown(data: """
#### Data Collection
Our apps do not collect any personal information or user data. All event logs are executed locally on the device and are not transmitted to any external server.

#### Cookie Usage
Our app does not use any form of cookies or similar technologies to track user behavior or personal information.

#### Data Security
User input data is only used for calculations on the user's device and is not stored or transmitted. We are committed to ensuring the security of user data.

#### Contact Information
If you have any questions or concerns about our privacy policy, please contact us via email.
          """),
        );
      },
    );
  }

  aboutSpeedUS(BuildContext context) async {
    var info = await PackageInfo.fromPlatform();
    showAboutDialog(
      applicationName: info.appName,
      applicationVersion: info.version,
      applicationIcon: Image.asset(
        'assets/launcher.webp',
        width: 78,
        height: 78,
      ),
      children: [
        const Text(
            """We can provide you with instant speed records"""),
      ],
      context: context,
    );
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? repeat = prefs.getBool('location');
    if (repeat == null || repeat == false) {
      prefs.setBool('location', false);
      if (repeat == null) {
        checkLocation();
      }
    } else {
      isOpen.value = repeat;
      prefs.setBool('location', true);
    }
    super.onInit();
  }

}
