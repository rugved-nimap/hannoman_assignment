
import 'package:flutter/material.dart';
import 'package:rugved_assignment/themes/colors.dart';

class StackImagesWidgets extends StatelessWidget {
  const StackImagesWidgets({
    super.key,
    required this.size,
    this.one = 1,
    this.two = 2,
    this.three = 3,
  });

  final double size;
  final int one;
  final int two;
  final int three;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Icon(Icons.star_border_rounded, color: grey),
        SizedBox(
          height: 30,
          width: 200,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                    border: Border.all(color: Colors.white, width: 1.5, strokeAlign: BorderSide.strokeAlignCenter),
                    image: DecorationImage(image: NetworkImage("https://avatars.githubusercontent.com/u/$one?v=4")),
                  ),
                ),
              ),
              Positioned(
                left: 15,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    border: Border.all(color: Colors.white, width: 1.5, strokeAlign: BorderSide.strokeAlignCenter),
                    image: DecorationImage(image: NetworkImage("https://avatars.githubusercontent.com/u/$two?v=4")),
                  ),
                ),
              ),
              Positioned(
                left: 30,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellow,
                    border: Border.all(color: Colors.white, width: 1.5, strokeAlign: BorderSide.strokeAlignCenter),
                    image: DecorationImage(image: NetworkImage("https://avatars.githubusercontent.com/u/$three?v=4")),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
