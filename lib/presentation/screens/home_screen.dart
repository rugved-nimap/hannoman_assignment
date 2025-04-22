import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rugved_assignment/data/constants.dart';
import 'package:rugved_assignment/presentation/controllers/main_controller.dart';
import 'package:rugved_assignment/presentation/reusable_widgets/no_data_found_widget.dart';
import 'package:rugved_assignment/presentation/reusable_widgets/recent_searches_ui.dart';
import 'package:rugved_assignment/presentation/reusable_widgets/user_list_tile.dart';
import 'package:rugved_assignment/presentation/screens/user_profile_detail_screen.dart';
import 'package:rugved_assignment/themes/colors.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (controller) {
      return Scaffold(
        backgroundColor: background,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              "Home",
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.grey.shade400.withValues(alpha: 0.25),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none),
                hintText: "Search User",
                hintStyle: TextStyle(color: Colors.grey),
                counterText: '',
                prefixIcon: Icon(Icons.search, color: Colors.grey, size: 25),
              ),
              cursorColor: blue,
              maxLength: 100,
              minLines: 1,
              controller: controller.searchController,
              onChanged: (value) {
                controller.searchQuery.value = value;
              },
            ),
            Expanded(
              child: getScreen(controller),
            )
          ],
        ).paddingOnly(left: 12, right: 12, top: 20),
      );
    });
  }

  Widget getScreen(MainController controller) {
    if (controller.isLoading == true) {
      return Center(child: Lottie.asset(searchAnimationLottie));
    } else if (controller.isLoading == false && controller.searchQuery.value.isEmpty) {
      return RecentSearchesUi(
        recentSearchList: controller.recentSearchList,
        onAllClear: () {
          controller.databaseService.deleteAllSearchesFromDatabase();
          controller.recentSearchList.clear();
          controller.update();
        },
        onClear: (id, index) {
          controller.databaseService.deleteSearchFromDatabase(id);
          controller.recentSearchList.removeAt(index);
          controller.update();
        },
        onThen: () {
          controller.searchController.clear();
          controller.searchQuery.value = '';
          controller.update();
        },
      );
    } else if (controller.isLoading == false && controller.searchList.isEmpty) {
      return NoDataFoundWidget(text: controller.errorMessage, iconPath: controller.errorIcon);
    } else if (controller.isLoading == false && controller.searchList.isNotEmpty) {
      return ListView.builder(
        itemCount: controller.searchList.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = controller.searchList[index];
          return UserListTile(
            loginName: "${item.login.capitalize}",
            userName: "@${item.login.toLowerCase()}",
            imageUrl: item.avatarUrl,
            onTap: () {
              controller.databaseService.addSearchToDatabase(item.id, jsonEncode(item.toJson()));
              if (!controller.recentSearchList.any((element) => element.id == item.id)) {
                controller.recentSearchList.insert(0, item);
              }

              Get.to(() => UserProfileDetailScreen(user: item), transition: Transition.leftToRight)?.then(
                    (value) {
                  controller.searchController.clear();
                  controller.searchQuery.value = '';
                  controller.update();
                },
              );
            },
          );
        },
      );
    }
    return SizedBox.shrink();
  }
}
