import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortunes_app/core/routes/app_routes.dart';
import 'package:fortunes_app/core/services/navigation_service.dart';
import 'package:fortunes_app/views/pages/bottom_tab_screen.dart';
import 'package:get/get.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return GetMaterialApp(
          theme: ThemeData.light(),
          debugShowCheckedModeBanner: false,
          navigatorKey: NavigationService().navigatorKey,
          title: 'Flutter Demo',
          getPages: AppPages.appPages,
          home: const MainBottomNavBarScreen(),
        );
      },
    );
  }
}
