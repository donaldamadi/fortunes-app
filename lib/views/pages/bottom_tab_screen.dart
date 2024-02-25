import 'package:flutter/material.dart';
import 'package:fortunes_app/controllers/bottom_tab_screen_controller.dart';
import 'package:fortunes_app/controllers/fortune_controller.dart';
import 'package:fortunes_app/core/constants/app_assets.dart';
import 'package:fortunes_app/views/pages/create_page.dart';
import 'package:fortunes_app/views/pages/home_page.dart';
import 'package:fortunes_app/views/pages/view_page.dart';
import 'package:fortunes_app/views/widgets/app_bottom_nav_bar.dart';
import 'package:get/get.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  static String path = "/dashboard";

  const MainBottomNavBarScreen({super.key});

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  final BottomTabScreenController controller = Get.put(BottomTabScreenController());
  final FortuneController fortuneController = Get.put(FortuneController());

  @override
  Widget build(BuildContext context) {
    Rx<List<BottomNavItem>> pageParams = Rx([
      BottomNavItem(
          page: HomePage(),
          icon: Obx(
            () {
              return BottomNavIconWidget(
                svgPath: AppAssets.home,
                isSelected: controller.currentIndex.value == 0,
              );
            },
          ),
          iconLabel: 'Home'),
      BottomNavItem(
          page: ViewFortunePage(),
          icon: Obx(
            () {
              return BottomNavIconWidget(
                svgPath: AppAssets.view,
                isSelected: controller.currentIndex.value == 1,
              );
            },
          ),
          iconLabel: 'View Fortune'),
      BottomNavItem(
          page: CreateFortunePage(),
          icon: Obx(
            () {
              return BottomNavIconWidget(
                svgPath: AppAssets.create,
                isSelected: controller.currentIndex.value == 2,
              );
            },
          ),
          iconLabel: 'Create Fortune'),
    ]);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        controller.onWillPop();
      },
      child: Obx(
        () {
          return Scaffold(
            bottomNavigationBar: AppBottomNavBar(
              itemParams: pageParams.value,
              currentIndex: controller.currentIndex.value,
              onchanged: (value) {
                controller.setCurrentIndex = value;
              },
            ),
            body: pageParams.value[controller.currentIndex.value].page,
          );
        },
      ),
    );
  }
}
