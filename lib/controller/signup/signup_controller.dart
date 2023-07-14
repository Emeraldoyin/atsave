import 'package:easysave/consts/app_colors.dart';
import 'package:easysave/controller/signup/success_controller.dart';
import 'package:easysave/view/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc_folder/auth_bloc/authentication_bloc.dart';
import '../../view/widgets/show_dialog.dart';
import '../signin/signin_controller.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  SignUpController createState() => SignUpController();
}

class SignUpController extends State<SignUp> {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  String? email;
  String? password;
  late String uid;
  late String displayName = firstNameController.text;
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  void initState() {
    super.initState();
    obscureText == true;
  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SignUpPage(this);

  void changeVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  listener(state) {
    if (state is AuthLoadingState) {
      CircularProgressIndicator;
    }
    if (state is SignupSuccessState) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('you have been successfully registered'),
          backgroundColor: APPBAR_COLOR1));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const Success(
                  succcessful: true,
                  displayMessage: 'Congratulations!!!',
                  displayImageURL: 'assets/images/success.png',
                  buttonText: 'Go to login',
                  displaySubText:
                      'Your account has been created. \n We\'re happy to have you onboard', destination: SignIn(),)));
    }
    if (state is AuthErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Ooops! Error occurred. Check your network and try again'),
            backgroundColor: ICON_COLOR5),
      );
      
      showAlertDialog(context, 'Invalid Signup Request',
          'Unable to create an account for you. Please ensure that you provided a valid email and at least 8 characters for password', 'close');
    
      // Navigator.pop(context);
    }
  }

  String? validateForEmail(value) {
    if (value.isEmpty) {
      return 'Field cannot be empty';
    } else if (isValidEmail(value)) {
      return 'Please enter a valid email';
    } else {
      return null;
    }
  }

  String? validateForName(value) {
    if (value.isEmpty) {
      return 'Field cannot be empty';
    } else {
      return null;
    }
  }

  String? validateForPassword(value) {
    if (value.isEmpty) {
      return 'Field cannot be empty';
    } else if (value.length < 8) {
      return 'At least 8 characters';
    } else {
      return null;
    }
  }

  saveDisplayName() async {
    final user = FirebaseAuth.instance.currentUser;
    await user!.updateDisplayName(displayName);
  }

  changePasswordView() {
    setState(() {
      obscureText = !obscureText; // toggle the visibility of the text input
    });
  }

  // void showAlertDialog(BuildContext context, String title, String content) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       // return object of type AlertDialog
  //       return AlertDialog(
  //         title: Text(title),
  //         content: Text(content),
  //         actions: <Widget>[
  //           // usually buttons at the bottom of the dialog
  //           TextButton(
  //             child: const Text(
  //               "Close",
  //               style: TextStyle(color: Colors.black),
  //             ),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void signup(signUpFormKey) async {
    if (signUpFormKey.currentState.validate()) {
      context.read<AuthenticationBloc>().add(SignUpEvent(
            createdAt: DateTime.now().toIso8601String(),
            email: emailController.text,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            password: passwordController.text,
          ));
    } 
  }

  void pushSignIn() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const SignIn(),
    ));
  }
}
