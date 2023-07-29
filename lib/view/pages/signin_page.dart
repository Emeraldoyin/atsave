import 'package:easysave/bloc_folder/auth_bloc/authentication_bloc.dart';
import 'package:easysave/consts/app_colors.dart';
import 'package:easysave/consts/app_images.dart';
import 'package:easysave/utils/helpers/design_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';

import '/utils/helpers/boilerplate/stateless_view.dart';
import '../../controller/signin/signin_controller.dart';

class SignInPage extends StatelessView<SignIn, SignInController> {
  const SignInPage(SignInController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        controller.listener(state);
      },
      child: Scaffold(
        backgroundColor: ONBOARD_COLOR,
        body: Container(
          height: double.infinity.h,
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 33.w),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [ONBOARD_COLOR, BACKGROUND_COLOR1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 86.h),
                    child: Center(
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: 30.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  addVerticalSpace(16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email',
                            style: Theme.of(context).textTheme.bodySmall),
                        addVerticalSpace(5),
                        TextFormField(
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  size: 16.r,
                                ),
                                onPressed: () {
                                  controller.txtController!.clear();
                                }),
                            alignLabelWithHint: false,
                            floatingLabelStyle:
                                const TextStyle(color: BUTTON_COLOR1),
                            hintText: 'Enter your email',
                          ),
                          controller: controller.txtController,
                          keyboardType: TextInputType.text,
                          onSaved: (value) => controller.email = value,
                          validator:
                              ValidationBuilder().email().required().build(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Password',
                            style: Theme.of(context).textTheme.bodySmall),
                        addVerticalSpace(5),
                        TextFormField(
                          onSaved: (value) => controller.password = value,
                          validator: ValidationBuilder()
                              .required('password field cannot be empty')
                              .minLength(6,
                                  'provide a valid password of at least 6 characters')
                              .build(),
                          obscureText: controller.obscureText,
                          controller: controller.passwordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(
                                  controller.obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 16.r,
                                ),
                                onPressed: controller.changePasswordView),
                            hintText: 'Enter password',
                          ),
                        ),
                      ],
                    ),
                  ),
                  addVerticalSpace(32.h),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll<Size>(
                                Size(318.w, 48.h))),
                        onPressed: () {
                          controller.login(controller.formKey);
                        },
                        child: state is AuthLoadingState
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Sign in',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                      );
                    },
                  ),
                  addVerticalSpace(54.h),
                  Container(
                    padding: EdgeInsets.all(5.h),
                    child: Center(
                      child: Text(
                        'Or sign up using',
                        style: TextStyle(
                            color: HINT_TEXT_COLOR,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp),
                      ),
                    ),
                  ),
                  addVerticalSpace(8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 22.r,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          image24,
                          fit: BoxFit.scaleDown,
                          scale: 5,
                        ),
                      ),
                      addHorizontalSpace(24.w),
                      CircleAvatar(
                        radius: 22.r,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          image25,
                          fit: BoxFit.scaleDown,
                          scale: 5,
                        ),
                      ),
                      addHorizontalSpace(24.w),
                      CircleAvatar(
                        radius: 22.r,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          image26,
                          fit: BoxFit.scaleDown,
                          scale: 5,
                        ),
                      )
                    ],
                  ),
                  addVerticalSpace(60.h),
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'Don\'t have an account yet?',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        addVerticalSpace(10),
                        InkWell(
                          onTap: () => controller.pushSignUp(),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                color: BUTTON_COLOR1,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
