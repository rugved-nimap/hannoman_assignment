import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rugved_assignment/data/constants.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Explore",
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
              // spacing: 25,
              children: [
                SvgPicture.asset(
                  noRepositoryFound,
                  width: 170,
                  height: 170,
                  colorFilter: ColorFilter.mode(Colors.grey.shade800, BlendMode.srcATop),
                ),
                Text(
                  "No Repository Found",
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
