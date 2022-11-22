import 'package:bloc/bloc.dart';
import 'package:crud_operations_app/presentation/screens/add_book_screen.dart';
import 'package:crud_operations_app/presentation/screens/edit_book_screen.dart';
import 'package:crud_operations_app/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'helpers/app_routes.dart';
import 'helpers/bloc_observer.dart';
import 'helpers/dio.dart';
import 'helpers/shared_pref.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Crud App',
          initialRoute: AppRoutes.homeScreenRoute,
          routes: {
            AppRoutes.homeScreenRoute: (context) =>  HomeScreen(),
            AppRoutes.editBookScreenRoute: (context) =>  EditBookScreen(),
            AppRoutes.addBookScreenRoute: (context) =>  AddBookScreen(),
          },
        );
      },
    );
  }
}

