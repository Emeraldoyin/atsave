import 'package:easysave/consts/app_colors.dart';
import 'package:easysave/consts/app_images.dart';
import 'package:easysave/controller/signup/success_controller.dart';
import 'package:easysave/view/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc_folder/auth_bloc/authentication_bloc.dart';
import '../signin/signin_controller.dart';

//controller for signup page
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  SignUpController createState() => SignUpController();
}

class SignUpController extends State<SignUp> {

  ///stating all state variables
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


  ///validates email
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  void initState() {
    super.initState();
    obscureText == true; ///ensuring password is hidden until user clicks the button to unhide it
  }

///disposes controllers
  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }


///listeners for states emitted
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
                  displayImageURL: image17,
                  buttonText: 'Go to login',
                  displaySubText:
                      'Your account has been created. \n We\'re happy to have you onboard', destination: SignIn(),)));
    }
    if (state is AuthErrorState) {
      if (state.error ==
          'Network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Network error has occurred. Check your connection and try again'),
            backgroundColor: ICON_COLOR5,
            showCloseIcon: true,
          ),
        );
      } else if (state.error ==
          'Password should be at leadt 6 characters') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to sign you up. Please provide all details required'),
            backgroundColor: ICON_COLOR5,
            showCloseIcon: true,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred'),
            backgroundColor: ICON_COLOR5,
            showCloseIcon: true,
          ),
        );
      }
    }
  }


 ///validates email
  validateForEmail(value) {
    if (value.isEmpty) {
      return 'Field cannot be empty';
    } else if (isValidEmail(value)) {
      return 'Please enter a valid email';
    } else {
      return null;
    }
  }

//ensures field is not left empty
  validateForName(value) {
    if (value.isEmpty) {
      return 'Field cannot be empty';
    } else {
      return null;
    }
  }

//ensuring password field is not empty
  validateForPassword(value) {
    if (value.isEmpty) {
      return 'Field cannot be empty';
    } else if (value.length < 8) {
      return 'At least 8 characters';
    } else {
      return null;
    }
  }

//saving name for user in firebase auth as display name
  saveDisplayName() async {
    final user = FirebaseAuth.instance.currentUser;
    await user!.updateDisplayName(displayName);
  }


///obsure and reveals password
  changePasswordView() {
    setState(() {
      obscureText = !obscureText; // toggle the visibility of the text input
    });
  }

///acts on sign up
  void signup(signUpFormKey) async {
    if (signUpFormKey.currentState.validate()) {
      context.read<AuthenticationBloc>().add(SignUpEvent( //calling bloc event for signup
            createdAt: DateTime.now().toIso8601String(),
            email: emailController.text,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            password: passwordController.text,
          ));
    } 
  }

///navigates to signin page
  void pushSignIn() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const SignIn(),
    ));
  }

  @override
  Widget build(BuildContext context) => SignUpPage(this);
}
