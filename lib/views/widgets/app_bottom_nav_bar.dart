import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fortunes_app/controllers/bottom_tab_screen_controller.dart';
import 'package:get/get.dart';

/// Customizable bottom navigation bar with an indicator for each item.
///
/// This widget provides a customizable bottom navigation bar with an indicator
/// for each item. It allows you to specify the initial selected item, handle
/// item changes through a callback, and customize the appearance of each item.
///
/// Example usage:
/// ```dart
/// AppBottomNavBar(
///   currentIndex: 0,
///   onchanged: (index) {
///     // Handle item change
///   },
///   itemParams: [
///     BottomNavItem(page: Page1(), icon: Icon(Icons.home), iconLabel: 'Home'),
///     BottomNavItem(page: Page2(), icon: Icon(Icons.favorite), iconLabel: 'Favorites'),
///     // Add more items as needed
///   ],
/// )
/// ```
/// Example with custom icons when usign Svgs as image icons using `BottomNavIconWidget`:
/// ```dart
/// AppBottomNavBar(
///   currentIndex: 0,
///   onchanged: (index) {
///     // Handle item change
///   },
///   itemParams: [
///     BottomNavItem(page: Page1(), icon: BottomNavIconWidget(isSelected: false, svgPath: 'assets/home.svg')),
///     BottomNavItem(page: Page2(), icon: BottomNavIconWidget(isSelected: false, svgPath: 'assets/favorite.svg')),
///     // Add more items as needed
///   ],
/// )
/// ```
class AppBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int>? onchanged;
  final List<BottomNavItem> itemParams;
  const AppBottomNavBar({super.key, this.currentIndex = 0, this.onchanged, required this.itemParams});

  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar> {
  final controller = Get.find<BottomTabScreenController>();


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Container(
        height: Platform.isIOS ? 97 : 68,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: widget.itemParams.length == 3
              ? null
              : const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
          border: widget.itemParams.length == 3
              ? const Border(
                  left: BorderSide(color: Colors.yellow, width: 0),
                  top: BorderSide(
                    width: 1,
                    color: Colors.yellow,
                  ),
                  right: BorderSide(color: Colors.yellow, width: 0),
                  bottom: BorderSide(color: Colors.yellow, width: 0),
                )
              : null,
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 4,
              offset: Offset(0, -1),
              spreadRadius: 0,
            )
          ],
        ),
        child: Container(
          height: Platform.isIOS ? 93 : 64,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    widget.itemParams.length,
                    (index) => IndicatorWidget(
                      isSelected: controller.currentIndex.value == index,
                      length: widget.itemParams.length,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: BottomNavigationBar(
                    currentIndex: controller.currentIndex.value,
                    onTap: (index) => controller.setCurrentIndex = index,
                      // currentIndex: _currentIndex,
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.yellow,
                      unselectedItemColor: Colors.grey,
                      showSelectedLabels: true,
                      iconSize: 24,
                      selectedLabelStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: widget.itemParams.length > 3 ? 'Gotham' : 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: widget.itemParams.length > 3 ? 'Gotham' : 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                      unselectedFontSize: 12,
                      selectedFontSize: 12,
                      backgroundColor: Colors.white,
                      showUnselectedLabels: true,
                      items: List.generate(
                        widget.itemParams.length,
                        (index) => BottomNavigationBarItem(
                          icon: widget.itemParams[index]
                              .icon, // if using default icons, there is no need to change the state of it, it would change authomatically
                          label: widget.itemParams[index].iconLabel,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IndicatorWidget extends StatelessWidget {
  const IndicatorWidget({
    super.key,
    required bool isSelected,
    required int length,
  })  : _isSelected = isSelected,
        _length = length;

  final bool _isSelected;
  final int _length;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: _length == 3
                ? 22.33
                : _length == 5
                    ? 21.40
                    : 35.75,
            // width: 21.40,
            height: 4,
            decoration: ShapeDecoration(
              color: _isSelected ? const Color(0xFFF1C72F) : null,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavItem {
  final Widget page;

  /// If you prefer to use an SVG image as an icon, consider using `BottomNavIconWidget`.
  /// Otherwise, you can directly use the icon without any modifications.
  final Widget icon;
  final String iconLabel;

  BottomNavItem({required this.page, required this.icon, required this.iconLabel});
}

class BottomNavIconWidget extends StatelessWidget {
  const BottomNavIconWidget({
    super.key,
    this.isSelected = false,
    required this.svgPath,
  });
  final bool isSelected;
  final String svgPath;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svgPath,
      height: 24,
      width: 24,
      colorFilter: isSelected
          ? const ColorFilter.mode(Colors.yellow, BlendMode.srcIn)
          : const ColorFilter.mode(
              Colors.grey,
              BlendMode.srcIn,
            ),
    );
  }
}
