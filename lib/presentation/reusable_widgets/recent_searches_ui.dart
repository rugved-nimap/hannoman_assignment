import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rugved_assignment/data/models/user_model.dart';
import 'package:rugved_assignment/presentation/reusable_widgets/no_data_found_widget.dart';
import 'package:rugved_assignment/presentation/reusable_widgets/user_list_tile.dart';
import 'package:rugved_assignment/presentation/screens/user_profile_detail_screen.dart';
import 'package:rugved_assignment/themes/colors.dart';

class RecentSearchesUi extends StatelessWidget {
  const RecentSearchesUi({
    super.key,
    required this.recentSearchList,
    this.onAllClear,
    this.onClear,
    this.onThen,
  });

  final List<UserModel> recentSearchList;
  final Function()? onAllClear;
  final Function(dynamic id, dynamic index)? onClear;
  final VoidCallback? onThen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Searches",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ).marginOnly(top: 10),
            if (recentSearchList.isNotEmpty)
              InkWell(
                onTap: onAllClear,
                child: Text(
                  "Clear",
                  style: TextStyle(fontSize: 16, color: blue, fontWeight: FontWeight.w600),
                ).marginOnly(top: 10),
              )
          ],
        ),
        Visibility(
            visible: recentSearchList.isNotEmpty,
            replacement: Expanded(child: NoDataFoundWidget(text: "No Search Found")),
            child: Expanded(
              child: ListView.builder(
                itemCount: recentSearchList.length,
                itemBuilder: (context, index) {
                  final item = recentSearchList[index];
                  return UserListTile(
                    loginName: "${item.login.capitalize}",
                    userName: "@${item.login.toLowerCase()}",
                    imageUrl: item.avatarUrl,
                    onTap: () {
                      Get.to(() => UserProfileDetailScreen(user: item), transition: Transition.fadeIn)?.then((value) {
                        if (onThen != null) onThen!();
                      });
                    },
                    isClearVisible: true,
                    clear: () {
                      if (onClear != null) onClear!(item.id, index);
                    },
                  );
                },
              ),
            ))
      ],
    );
  }
}
