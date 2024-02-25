import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fortunes_app/controllers/bottom_tab_screen_controller.dart';
import 'package:fortunes_app/controllers/datasources/fortune_database_helper.dart';
import 'package:fortunes_app/core/constants/app_colors.dart';
import 'package:fortunes_app/models/fortune_model.dart';
import 'package:get/get.dart';

/// Controls the operations related to fortunes in the application, including
/// creating, deleting, and displaying fortunes, as well as managing the selected fortune.
class FortuneController extends GetxController {
  // Observable list of fortunes to be displayed in the UI.
  RxList<FortuneModel> fortunesList = <FortuneModel>[].obs;

  // Controller for the text field input for new fortunes.
  TextEditingController fortuneController = TextEditingController();
  // Database helper instance for interacting with the database.
  DatabaseHelper? dbHelper;
  // Observable current color value for the fortune background.
  RxInt currentColor = 0.obs;
  // Observable for the currently selected fortune.
  Rx<FortuneModel> selectedFortune = FortuneModel.empty().obs;
  // Controller for managing scrolling behavior.
  ScrollController scrollController = ScrollController();
  // Controller for managing the bottom tab navigation.
  late final BottomTabScreenController bottomTabController;

  /// Constructor that optionally accepts a `DatabaseHelper` instance for dependency injection.
  /// It retrieves or initializes the `BottomTabScreenController`.
  FortuneController({this.dbHelper}) {
    bottomTabController = Get.find<BottomTabScreenController>();
    dbHelper ??= DatabaseHelper.instance;
  }

  /// Refreshes the list of fortunes from the database.
  Future<void> refreshFortunes() async {
    List<FortuneModel> fortunes = await dbHelper!.getAllFortunes();
    fortunesList.assignAll(fortunes);
  }

  /// Generates a random color from a predefined list and sets it as the current color.
  /// Returns the generated color.
  int generateRandomColor() {
    final generatedColor = noteColors[Random().nextInt(noteColors.length)];
    currentColor.value = generatedColor;
    return generatedColor;
  }

  /// Sets the current color to a specific value.
  set setCurrentColor(int color) {
    currentColor.value = color;
  }

  @override
  void onInit() async {
    await refreshFortunes();
    pickRandomFortune();
    super.onInit();
  }

  /// Adds a new fortune to the database and refreshes the list of fortunes.
  /// Displays a toast message upon addition.
  void addFortune() async {
    if (fortuneController.text.isEmpty) return;

    FortuneModel fortune = FortuneModel(
      id: null,
      fortune: fortuneController.text,
      date: DateTime.now(),
      color: currentColor.value,
    );

    await dbHelper!.createFortune(fortune);
    fortuneController.clear();
    Fluttertoast.showToast(msg: 'Fortune added');

    await refreshFortunes();

    bottomTabController.setCurrentIndex = 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeIn,
        );
      }
    });
  }

  /// Deletes a specified fortune from the database and refreshes the list of fortunes.
  /// Displays a toast message upon deletion.
  void deleteFortune(FortuneModel fortune) async {
    await dbHelper!.deleteFortune(fortune.id.toString());
    await refreshFortunes();
    pickRandomFortune();
    Fluttertoast.showToast(msg: 'Fortune deleted');
  }

  /// Randomly selects a fortune from the list of fortunes.
  /// Displays a toast message if no fortunes are available.
  void pickRandomFortune() {
    if (fortunesList.isEmpty) {
      Fluttertoast.showToast(msg: 'No fortunes available');
      return;
    }
    final randomIndex = Random().nextInt(fortunesList.length);
    selectedFortune.value = fortunesList[randomIndex];
  }

  /// Sets a specific fortune as the selected fortune and navigates to its detail view.
  void viewSelectedFortune(FortuneModel fortune) {
    selectedFortune.value = fortune;
    bottomTabController.setCurrentIndex = 1;
  }

  /// Clears the selected fortune and randomly selects another one.
  void refreshSelectedFortune() {
    selectedFortune.value = FortuneModel.empty();
    pickRandomFortune();
  }
}
