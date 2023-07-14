import 'package:easysave/consts/app_colors.dart';
import 'package:flutter/material.dart';

Widget dotContainer(index, context, currentIndex) {
  return Container(
    height: 10,
    margin: const EdgeInsets.symmetric(horizontal: 6),
    width: 10,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: currentIndex == index ? APPBAR_COLOR2 : SUBTEXT_COLOR,
    ),
  );
}
