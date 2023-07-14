import 'package:flutter/material.dart';


ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(context, content, Color bgColor) {
 return ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
            behavior: SnackBarBehavior.floating,
            // duration: const Duration(days: 0, hours: 0, minutes: 0, seconds: 7),
            content: content,
            showCloseIcon: true,
            closeIconColor: Colors.black,
            backgroundColor: bgColor),
      );
}