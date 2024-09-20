import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_speed/db_speed/db_speed.dart';
import 'package:get_speed/pages/speed_first/speed_details/speed_details_binding.dart';
import 'package:get_speed/pages/speed_first/speed_details/speed_details_view.dart';
import 'package:get_speed/pages/speed_first/speed_first_binding.dart';
import 'package:get_speed/pages/speed_first/speed_first_view.dart';
import 'package:get_speed/pages/speed_second/speed_second_binding.dart';
import 'package:get_speed/pages/speed_second/speed_second_view.dart';
import 'package:get_speed/pages/speed_tab/speed_tab_binding.dart';
import 'package:get_speed/pages/speed_tab/speed_tab_view.dart';
import 'package:get_speed/pages/speed_tes/speed_tes_binding.dart';
import 'package:get_speed/pages/speed_tes/speed_tes_view.dart';
import 'package:get_speed/pages/speed_third/speed_third_binding.dart';
import 'package:get_speed/pages/speed_third/speed_third_view.dart';

import 'db_speed/speed_item.dart';

Color primaryColor = const Color(0xff007aff);
Color bgColor = const Color(0xfff7f7f7);

final customTitles = ['Running speed test','Bike speed test', 'Motorcycle speed Test','Car speed Test'];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DBSpeed().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: HuiLis,
      initialRoute: '/speedInit',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme:BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> HuiLis = [
  GetPage(name: '/speedInit', page: () => const SpeedTesView(),binding: SpeedTesBinding()),
  GetPage(name: '/speedFirst', page: () => SpeedFirstPage(),binding: SpeedFirstBinding()),
  GetPage(name: '/speedItem', page: () => const SpeedItem()),
  GetPage(name: '/speedSecond', page: () => SpeedSecondPage(),binding: SpeedSecondBinding()),
  GetPage(name: '/speedThird', page: () => SpeedThirdPage(),binding: SpeedThirdBinding()),
  GetPage(name: '/speedTab', page: () => SpeedTabPage(),binding: SpeedTabBinding()),
  GetPage(name: '/speedDetails', page: () => SpeedDetailsPage(),binding: SpeedDetailsBinding()),
];