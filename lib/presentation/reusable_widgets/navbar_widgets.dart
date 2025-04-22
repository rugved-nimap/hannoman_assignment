import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../themes/colors.dart';

class NavbarWidgets extends StatelessWidget {
  const NavbarWidgets({
    super.key,
    required this.filledIconPath,
    required this.outlinedIconPath,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String filledIconPath;
  final String outlinedIconPath;
  final String text;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 5,
        children: [
          SvgPicture.asset(
            isSelected ? filledIconPath : outlinedIconPath,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(isSelected ? blue : grey, BlendMode.srcATop),
          ),
          if (isSelected)
            Text(
              text,
              style: TextStyle(color: isSelected ? blue : grey, fontSize: 12),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
        ],
      ),
    );
  }
}
