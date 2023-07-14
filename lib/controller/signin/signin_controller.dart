import 'package:easysave/controller/home/home_controller.dart';
import 'package:easysave/controller/signup/signup_controller.dart';
import 'package:easysave/view/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc_folder/auth_bloc/authentication_bloc.dart';
import '../../consts/app_colors.dart';
import '../../utils/helpers/session_manager.dart';

class SignIn extends StatefulWidget {
  //static const routeName = Strings.SCREEN_BLANK;

  const SignIn({Key? key}) : super(key: key);

  @override
  SignInController createState() => SignInController();
}

class SignInController extends State<SignIn> {
  //... //Initialization code, state vars etc, all go here
  final TextEditingController? txtController = TextEditingController();
  final TextEditingController? passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  final bool isChecked = false;
  String? email;
  String? password;

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  clearContent() {
    setState(() {
      txtController!.clear();
    });
  }

  changePasswordView() {
    setState(() {
      obscureText = !obscureText; // toggle the visibility of the text input
    });
  }

  checked() {
    setState(() {
      // isChecked = value;
    });
  }

  void pushSignUp() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const SignUp(),
    ));
  }

  listener(state) {
    if (state is AuthLoadingState) {
      const CircularProgressIndicator();
    }
    if (state is LoginSuccessState) {
       WidgetsBinding.instance.addPostFrameCallback((_) async {
            SessionManager manager = SessionManager();
            manager.loggedIn(true);
          });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('you have been successfully logged in'),
          backgroundColor: APPBAR_COLOR1));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    }
    if (state is AuthErrorState) {
      // showAlertDialog(
      //     context,
      //     'Login Failure',
      //     'An error occured and we were unable to sign you in.\n Please ensure you\'re connected to internet and providing correct details.\n Kindly try again. ',
      //     'Okay');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Login Error. Kindly try again.'),
            backgroundColor: ICON_COLOR5),
      );
    }
  }

  login(state) async {
    if (formKey.currentState!.validate()) {
      context.read<AuthenticationBloc>().add(SignInEvent(
          email: txtController!.text, password: passwordController!.text));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    txtController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) => SignInPage(this);
}
