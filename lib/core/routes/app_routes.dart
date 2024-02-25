import 'package:fortunes_app/views/pages/create_page.dart';
import 'package:fortunes_app/views/pages/home_page.dart';
import 'package:fortunes_app/views/pages/view_page.dart';
import 'package:get/get.dart';

class AppPages {
  static List<GetPage> appPages = [
    GetPage(name: HomePage.path, page: () => HomePage()),
    GetPage(name: ViewFortunePage.path, page: () => ViewFortunePage()),
    GetPage(name: CreateFortunePage.path, page: () => CreateFortunePage()),
  ];
}
