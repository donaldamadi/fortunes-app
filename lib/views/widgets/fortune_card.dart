import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortunes_app/controllers/fortune_controller.dart';
import 'package:fortunes_app/core/services/helper_services.dart';
import 'package:fortunes_app/models/fortune_model.dart';
import 'package:get/get.dart';

class FortuneCard extends StatelessWidget {
  final FortuneModel fortune;
  FortuneCard({super.key, required this.fortune});
  final controller = Get.find<FortuneController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.viewSelectedFortune(fortune),
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Color(fortune.color),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    fortune.fortune,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
                    formatDateTime(fortune.date),
                  ),
                ),
              ],
            ),
            Positioned(
              right: -5,
              top: -2,
              child: GestureDetector(
                onTap: () {
                  controller.deleteFortune(fortune);
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
