import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fdzone_helper/core/utils/fdzone_icons_icons.dart';
import '../../../data/service/storage_service.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find<DashboardController>();
  int currentScreen = 0;
  final appSettings = StorageService.appSettings;
  final bottomNavBarItems = GetPlatform.isIOS
      ? const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house_fill), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(FdZoneIcons.tag), label: 'Helper'),
          BottomNavigationBarItem(
              icon: Icon(FdZoneIcons.users), label: 'Customers'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.add), label: 'More'),
        ]
      : const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house_fill), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.tag), label: 'Helper'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Customers'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ];

  void onTap(int index) {
    currentScreen = index;
    update();
  }
}
