import 'package:easysave/utils/helpers/design_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/model/slider_model.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key, required this.slider});
  final SliderModel slider;

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Image.asset(widget.slider.imagePath!),
        SizedBox(
          height: 200.h,
          child: Image.asset(widget.slider.imagePath!),
        ),
        addVerticalSpace(100.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 20.h),
          child: SizedBox(
            height: 60.h,
            child: Text(
              widget.slider.description!,
              textAlign: TextAlign.center,
              style: ThemeData().textTheme.bodyMedium,
            ),
          ),
        )
      ],
    );
  }
}
