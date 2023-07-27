import 'package:easysave/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textContainer(String text, BuildContext context) {
  return Container(
    height: 48.h,
    // margin: const EdgeInsets.symmetric(horizontal: 6),
    width: 300.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10.r)),
      color: CARD_COLOR1,
    ),
    child: Padding(
      padding: EdgeInsets.all(16.r),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    ),
  );
}
