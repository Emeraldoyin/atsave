import 'package:easysave/bloc_folder/auth_bloc/authentication_bloc.dart';
import 'package:easysave/consts/app_colors.dart';
import 'package:easysave/utils/helpers/design_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';

import '/utils/helpers/boilerplate/stateless_view.dart';
import '../../controller/signin/signin_controller.dart';
import '../../controller/signup/signup_controller.dart';

class SignUpPage extends StatelessView<SignUp, SignUpController> {
  const SignUpPage(SignUpController controller, {Key? key})
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
          height: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 33.w),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [ONBOARD_COLOR, BACKGROUND_COLOR1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            child: Form(
              key: controller.signUpFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 86.h),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 30.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  addVerticalSpace(50.h),
                  Column(
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
                                controller.emailController.clear();
                              }),
                          alignLabelWithHint: false,
                          floatingLabelStyle:
                              const TextStyle(color: BUTTON_COLOR1),
                          hintText: 'Enter your email',
                        ),
                        controller: controller.emailController,
                        keyboardType: TextInputType.text,
                        onSaved: (value) => controller.email = value,
                        validator:
                            ValidationBuilder().email().required().build(),
                      ),
                    ],
                  ),
                  addVerticalSpace(20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('First Name',
                              style: Theme.of(context).textTheme.bodySmall),
                          addVerticalSpace(5.h),
                          TextFormField(
                            onSaved: (value) => controller.password = value,
                            validator: ValidationBuilder()
                                .required('password field cannot be empty')
                                .minLength(6,
                                    'provide a valid password of at least 6 characters')
                                .build(),
                            controller: controller.firstNameController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.clear,
                                    size: 16.r,
                                  ),
                                  onPressed: () {
                                    controller.firstNameController.clear();
                                  }),
                              constraints: BoxConstraints.expand(
                                  width: 140.w, height: 40.h),
                              hintText: 'Andy',
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('LastName',
                              style: Theme.of(context).textTheme.bodySmall),
                          addVerticalSpace(5.h),
                          TextFormField(
                            onSaved: (value) => controller.password = value,
                            validator: ValidationBuilder()
                                .required('this field is required')
                                .build(),
                            controller: controller.lastNameController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.clear,
                                    size: 16.r,
                                  ),
                                  onPressed: () {
                                    controller.lastNameController.clear();
                                  }),
                              constraints: BoxConstraints.expand(
                                  width: 140.w, height: 40.h),
                              hintText: 'Anderson',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  addVerticalSpace(30.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Password',
                          style: Theme.of(context).textTheme.bodySmall),
                      addVerticalSpace(5.h),
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
                          hintText: 'Enter preffered password',
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpace(50.h),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll<Size>(
                                Size(318.w, 48.h))),
                        onPressed: () {
                          controller.signup(controller.signUpFormKey);
                        },
                        child: state is AuthLoadingState
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Create Account',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                      );
                    },
                  ),
                  addVerticalSpace(60.h),
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'Already a member?',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        addVerticalSpace(5),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (content) => const SignIn())),
                          child: const Text(
                            'Sign In',
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
