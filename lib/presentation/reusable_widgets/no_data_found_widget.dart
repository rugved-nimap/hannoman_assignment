import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rugved_assignment/data/constants.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({
    super.key,
    this.iconPath = noFoundIcon,
    this.text = "Not Found",
  });

  final String iconPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 150,
            height: 150,
            colorFilter: ColorFilter.mode(Colors.grey.withValues(alpha: 0.5), BlendMode.srcATop),
          ),
          Text(text, style: TextStyle(color: Colors.grey.withValues(alpha: 0.5), fontSize: 15)),
        ],
      ),
    );
  }
}
