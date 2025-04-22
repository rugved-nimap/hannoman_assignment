import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rugved_assignment/presentation/reusable_widgets/icon_label.dart';
import 'package:rugved_assignment/presentation/reusable_widgets/stack_images_widgets.dart';
import 'package:rugved_assignment/themes/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileUrl = "https://avatars.githubusercontent.com/u/${Random().nextInt(8)}?v=4";

    return Column(
      spacing: 12,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Text(
              "Profile",
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            Row(
              spacing: 10,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.indigo.shade400,
                  backgroundImage: NetworkImage(profileUrl),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Rugved Apraj", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("@rugved.apraj", style: TextStyle(color: grey, fontSize: 14)),
                  ],
                )
              ],
            ).marginOnly(bottom: 15),
            SizedBox(
              width: double.maxFinite,
              child: Wrap(
                spacing: 15,
                runSpacing: 8,
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  IconLabel(labelText: "@github", icon: Icons.apartment_rounded, textColor: Colors.white),
                  IconLabel(labelText: "Mumbai", icon: Icons.location_on_outlined, textColor: grey),
                  IconLabel(labelText: "@github.blog", icon: Icons.link, textColor: Colors.white),
                  IconLabel(labelText: "rugved.apraj@nimapinfotech.com", icon: Icons.email_outlined, textColor: Colors.white),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8,
                    children: [
                      Icon(Icons.group, color: grey),
                      Text("10K", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("followers", style: TextStyle(color: grey, fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("2K", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("following", style: TextStyle(color: grey, fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            StackImagesWidgets(size: 25),
            IconLabel(labelText: "Popular", icon: Icons.star_rounded, textColor: Colors.white).marginOnly(top: 20),
          ],
        ).paddingAll(16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 4,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                width: 300,
                decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.all(18),
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 5,
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.indigo.shade400,
                          backgroundImage: NetworkImage(profileUrl),
                        ),
                        Text(
                          "@rugved.apraj",
                          style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Spoon-Knife',
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        'This repo is for demonstration purposes only',
                        style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                        maxLines: 8,
                      ),
                    ),
                    Row(
                      spacing: 15,
                      children: [
                        IconLabel(labelText: "12932", icon: Icons.star_border_rounded, textColor: grey),
                        Row(
                          spacing: 10,
                          children: [
                            Container(height: 8, width: 8, decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(30))),
                            Text('HTML', style: TextStyle(color: Colors.grey.shade300, fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
