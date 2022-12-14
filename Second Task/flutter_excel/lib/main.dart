import 'package:flutter/material.dart';
import 'package:flutter_excel/presentation/screens/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'helpers/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Excel',
          initialRoute: AppRoutes.homeScreenRoute,
          routes:  {
            AppRoutes.homeScreenRoute: (context) => HomeScreen(),
          },
        );
      },
    );
  }
}

