import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rugved_assignment/data/constants.dart';
import 'package:rugved_assignment/presentation/controllers/main_controller.dart';
import 'package:rugved_assignment/presentation/reusable_widgets/navbar_widgets.dart';
import 'package:rugved_assignment/themes/colors.dart';


class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (controller.navigationHistory.isNotEmpty && controller.navigationHistory.length > 1) {
              controller.navigationHistory.remove(controller.navigationHistory.last);
              controller.selectedIndex = controller.navigationHistory.last;
              controller.update();
            } else if (controller.navigationHistory.isEmpty || controller.navigationHistory.length == 1) {
              Get.defaultDialog(
                title: "Are you sure ? You want to exit !",
                titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                radius: 8,
                backgroundColor: Colors.grey.shade900,
                content: SizedBox.shrink(),
                contentPadding: EdgeInsets.zero,
                barrierDismissible: false,
                cancel: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 3,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.lightGreen,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.not_interested_rounded),
                      ),
                      Text("No", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ).marginOnly(right: 20),
                confirm: InkWell(
                  onTap: () {
                    exit(0);
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 3,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.check_circle_outline_rounded),
                      ),
                      Text("Yes", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ).marginOnly(left: 20),
              );
            }
          },
          child: Scaffold(
            backgroundColor: background,
            body: controller.screens[controller.selectedIndex],
            bottomNavigationBar: Container(
              color: tabBackground,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: NavbarWidgets(
                      filledIconPath: houseFilledIcon,
                      outlinedIconPath: houseOutlinedIcon,
                      text: "Home",
                      isSelected: controller.selectedIndex == 0,
                      onTap: () {
                        controller.changeTab(0);
                      },
                    ),
                  ),
                  Expanded(
                    child: NavbarWidgets(
                      filledIconPath: notificationFilledIcon,
                      outlinedIconPath: notificationOutlinedIcon,
                      text: "Notification",
                      isSelected: controller.selectedIndex == 1,
                      onTap: () {
                        controller.changeTab(1);
                      },
                    ),
                  ),
                  Expanded(
                    child: NavbarWidgets(
                      filledIconPath: exploreFilledIcon,
                      outlinedIconPath: exploreOutlinedIcon,
                      text: "Explore",
                      isSelected: controller.selectedIndex == 2,
                      onTap: () {
                        controller.changeTab(2);
                      },
                    ),
                  ),
                  Expanded(
                    child: NavbarWidgets(
                      filledIconPath: profileFilledIcon,
                      outlinedIconPath: profileOutlinedIcon,
                      text: "Profile",
                      isSelected: controller.selectedIndex == 3,
                      onTap: () {
                        controller.changeTab(3);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
