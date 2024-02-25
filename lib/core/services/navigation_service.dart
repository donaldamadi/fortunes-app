import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._privateConstructor();

  static final NavigationService _instance =
      NavigationService._privateConstructor();

  factory NavigationService() {
    return _instance;
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> push<T>({
    required String page,
    T? arguments,
  }) async {
    navigatorKey.currentState?.pushNamed(
      page,
      arguments: arguments,
    );
  }

  Future<void> pushReplacement<T>({
    required String page,
    T? arguments,
  }) async {
    navigatorKey.currentState?.pushReplacementNamed(
      page,
      arguments: arguments,
    );
  }

  Future<void> pushUntil<T>({
    required String page,
    T? arguments,
  }) async {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      page,
      (Route<dynamic> route) => false, // Remove all routes below the new route
      arguments: arguments,
    );
  }

  void pop<T>([T? result]) {
    navigatorKey.currentState?.pop(result);
  }
}
