import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'controllers/main_controller.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainController controller = Get.put(MainController());

    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'News App',
        themeMode: ThemeMode.light,
        theme: ThemeData(
            fontFamily: 'Montserrat',
            textTheme: TextTheme(
              headline1: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 13.sp,
              ),
              headline2: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 13.sp,
              ),
              bodyText1: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 13.sp,
              ),
              bodyText2: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 13.sp,
              ),
              subtitle1: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 13.sp,
              ),
            ),
            colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: Color(0xFF1565C0),
                secondary: Color(0xFF171717),
                onSecondary: Color(0xFFFF4040),
                secondaryContainer: Color(0xFF546A7B),
                onSecondaryContainer: Color(0xFFFFC107),
                secondaryVariant: Color(0xFF009688),
                background: Color(0xFF171717),
                onBackground: Color(0xFF1C1C1C),
                brightness: Brightness.light),
            brightness: Brightness.light,
            scaffoldBackgroundColor: Color(0xFFEDEDED)),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      );
    });
  }
}
