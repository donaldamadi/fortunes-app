import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortunes_app/controllers/fortune_controller.dart';
import 'package:get/get.dart';

class CreateFortunePage extends StatelessWidget {
  static String path = "/create";
  CreateFortunePage({super.key});

  final controller = Get.put(FortuneController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(controller.generateRandomColor()),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: controller.fortuneController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Start Writing...",
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 20,
                  ),
                ),
              ).paddingSymmetric(horizontal: 14),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 80.w,
                height: 35.h,
                child: ElevatedButton(
                    onPressed: () {
                      controller.addFortune();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Done",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ).paddingSymmetric(horizontal: 20, vertical: 20),
          ],
        ),
      ),
    );
  }
}
