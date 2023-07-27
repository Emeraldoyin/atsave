import 'package:easysave/view/pages/success_page.dart';
import 'package:flutter/material.dart';

class Success extends StatefulWidget {

  const Success(
      {Key? key,
      required this.succcessful,
      required this.displayMessage,
      required this.displayImageURL,
      required this.buttonText,
      required this.displaySubText,
      required this.destination})
      : super(key: key);
  final bool succcessful;
  final String displayMessage;
  final String displayImageURL;
  final String buttonText;
  final String displaySubText;
  final Widget destination;

  @override
  SuccessController createState() => SuccessController();
}

class SuccessController extends State<Success> {
  //... //Initialization code, state vars etc, all go here
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SuccessPage(
        this,
        buttonText: widget.buttonText,
        displayImageURL: widget.displayImageURL,
        displayMessage: widget.displayMessage,
        displaySubText: widget.displaySubText,
        succcessful: widget.succcessful,
        destination: widget.destination,
      );
}
