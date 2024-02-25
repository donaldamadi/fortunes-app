import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortunes_app/controllers/fortune_controller.dart';
import 'package:fortunes_app/core/services/helper_services.dart';
import 'package:get/get.dart';

class ViewFortunePage extends StatelessWidget {
  static String path = "/view";
  ViewFortunePage({super.key});

  final controller = Get.find<FortuneController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Color(controller.selectedFortune.value.color),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    controller.selectedFortune.value.fortune,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ).paddingSymmetric(horizontal: 14),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
                child: Text(
                  formatDateTime(controller.selectedFortune.value.date),
                ),
              ).paddingOnly(bottom: 20.h),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.refreshSelectedFortune();
          },
          child: const Icon(Icons.refresh),
        ),
      );
    });
  }
}
