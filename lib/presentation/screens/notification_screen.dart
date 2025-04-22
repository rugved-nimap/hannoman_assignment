import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../data/constants.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Notifications",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 25,
              children: [
                SvgPicture.asset(
                  noNotificationFilledIcon,
                  width: 100,
                  height: 100,
                  colorFilter: ColorFilter.mode(Colors.grey.withValues(alpha: 0.4), BlendMode.srcATop),
                ),
                Text(
                  "No Notification Found",
                  style: TextStyle(fontSize: 15, color: Colors.grey.withValues(alpha: 0.4)),
                ),
              ],
            ),
          ),
        ),
      ],
    ).paddingAll(16);
  }
}
