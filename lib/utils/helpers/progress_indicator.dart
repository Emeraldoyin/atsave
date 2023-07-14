import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/options/cancel.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

progressIndicator(context, String message) async {
  /// Creating progress dialog
  ProgressDialog pd = ProgressDialog(context: context);

  /// Seting options: Max and msg
  pd.show(
    max: 100,
    msg: message,
    progressBgColor: Colors.transparent,
    cancel: Cancel(
      cancelClicked: () {
        Navigator.pop(context);
      },
    ),
  );
  for (int i = 0; i <= 100; i++) {
    /// You don't need to update state, just pass the value.
    /// Only value required
    pd.update(value: i);
    i++;
  }
}
