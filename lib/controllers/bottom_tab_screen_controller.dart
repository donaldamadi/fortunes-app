import 'dart:io';

import 'package:fortunes_app/core/services/navigation_service.dart';
import 'package:fortunes_app/views/widgets/info_alert_dialog.dart';
import 'package:get/get.dart';

class BottomTabScreenController extends GetxController with GetSingleTickerProviderStateMixin {

  RxInt currentIndex = 0.obs;

  set setCurrentIndex(int index) {
    currentIndex.value = index;
  }


  Future<bool> onWillPop() {
    showInfoAlertDialog(
      Get.context!,
      message: 'Are you sure you want to exit the App!',
      label: 'No',
      secondLabel: 'Yes',
      action: () => NavigationService().pop(),
      secondAction: signOutAction,
    );
    return Future.value(false);
  }

  signOutAction() => exit(0);
}
