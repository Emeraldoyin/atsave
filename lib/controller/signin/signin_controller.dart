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
      ));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
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
          'The password is invalid or the user does not have a password.') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid password. Try again with correct details'),
            backgroundColor: ICON_COLOR5,
            showCloseIcon: true,
          ),
        );
      } else if (state.error ==
          'There is no user record corresponding to this identifier. The user may have been deleted.') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'user login denied due to unrecognised login details. Please sign up to create an account'),
            backgroundColor: ICON_COLOR5,
            showCloseIcon: true,
          ),
        );
      }
    }
  }

  login(formkey) async {
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
