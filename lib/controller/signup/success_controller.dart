import 'package:easysave/view/pages/success_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc_folder/db_connectivity/connectivity_bloc.dart';

class Success extends StatefulWidget {
  const Success(
      {Key? key,
      required this.succcessful,
      required this.displayMessage,
      required this.displayImageURL,
      required this.buttonText,
      required this.displaySubText,
      this.amount,
      required this.destination})
      : super(key: key);
  final bool succcessful;
  final String displayMessage;
  final String displayImageURL;
  final String buttonText;
  final String displaySubText;
  final Widget destination;
  final String? amount;

  @override
  SuccessController createState() => SuccessController();
}

class SuccessController extends State<Success> {
  //... //Initialization code, state vars etc, all go here
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
     context.read<ConnectivityBloc>().add(RetrieveDataEvent(uid: user!.uid));
    super.deactivate();
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
