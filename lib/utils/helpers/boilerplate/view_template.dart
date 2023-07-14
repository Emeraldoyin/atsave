import 'package:easysave/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'controller_template.dart';
import 'stateless_view.dart';

class BlankView extends StatelessView<Blank, BlankController> {
  const BlankView(BlankController controller, {Key? key}) : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
        body: body(context)
        );
  }
  Widget body(context) {
    return const SizedBox();
  }
}
 