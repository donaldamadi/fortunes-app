import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fortunes_app/controllers/bottom_tab_screen_controller.dart';
import 'package:fortunes_app/controllers/fortune_controller.dart';
import 'package:fortunes_app/views/widgets/fortune_card.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  static String path = "/home";
  HomePage({super.key});
  final controller = Get.put(FortuneController(), permanent: true);
  final bottomTabController = Get.find<BottomTabScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "My Fortunes",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ).paddingOnly(left: 14, bottom: 14),
            Expanded(
              child: Obx(
                () {
                  if (controller.fortunesList.isEmpty) {
                    return const Center(
                      child: Text("No Fortunes Yet"),
                    ).paddingSymmetric(horizontal: 14, vertical: 20);
                  }
                  return Scrollbar(
                    controller: controller.scrollController,
                    child: GridView.custom(
                      controller: controller.scrollController,
                      gridDelegate: SliverStairedGridDelegate(
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        startCrossAxisDirectionReversed: false,
                        tileBottomSpace: controller.fortunesList.length % 2 == 0 ? 0 : 14,
                        pattern: [
                          const StairedGridTile(1.0, 10 / 4),
                          const StairedGridTile(0.5, 0.8),
                          const StairedGridTile(0.5, 0.8),
                          const StairedGridTile(0.5, 0.8),
                          const StairedGridTile(0.5, 0.8),
                        ],
                      ),
                      childrenDelegate: SliverChildBuilderDelegate(
                        (context, index) => FortuneCard(
                          fortune: controller.fortunesList[index],
                        ),
                        childCount: controller.fortunesList.length,
                      ),
                    ).paddingSymmetric(horizontal: 14),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Create Fortune",
        onPressed: () {
          bottomTabController.setCurrentIndex = 2;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
