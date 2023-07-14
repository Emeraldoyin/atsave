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
                        validator: (value) {
                          ValidationBuilder().email().required().build();
                          return null;
                        },
                        //style:
                        // decoration: InputDecoration(
                        //     border: const OutlineInputBorder(),
                        //     //filled: true,
                        //     hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                        //     hintText: 'Enter your email',
                        //     enabledBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide: const BorderSide(color: Colors.white),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide:
                        //             const BorderSide(width: 1, color: Colors.grey)),
                        //     suffixIcon: IconButton(
                        //       icon: const Icon(Icons.clear),
                        //       onPressed: () {},
                        //       color: Colors.red,
                        //     )),
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
                            validator: (value) {
                              controller.validateForName(value);
                              return null;
                            },

                            controller: controller.firstNameController,
                            // style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              constraints: BoxConstraints.expand(
                                  width: 140.w, height: 40.h),
                              // border: const OutlineInputBorder(),
                              // labelText: 'password',
                              hintText: 'Andy',
                              // hintStyle: const TextStyle(
                              //   color: Colors.grey,
                              // ),
                              //counterStyle: const TextStyle(color: Colors.red),
                              // enabledBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(10),
                              //     borderSide:
                              //         const BorderSide(width: 1, color: Colors.grey)),
                              // focusedBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(10),
                              //     borderSide:
                              //         const BorderSide(width: 1, color: Colors.grey))
                            ),
                          ),
                        ],
                      ),
                      //addHorizontalSpace(30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('LastName',
                              style: Theme.of(context).textTheme.bodySmall),
                          addVerticalSpace(5.h),
                          TextFormField(
                            onSaved: (value) => controller.password = value,
                            validator: (value) {
                              controller.validateForName(value);
                              return null;
                            },

                            controller: controller.lastNameController,
                            // style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              constraints: BoxConstraints.expand(
                                  width: 140.w, height: 40.h),
                              // border: const OutlineInputBorder(),
                              // labelText: 'password',

                              //labelStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                              hintText: 'Anderson',
                              // hintStyle: const TextStyle(
                              //   color: Colors.grey,
                              // ),
                              //counterStyle: const TextStyle(color: Colors.red),
                              // enabledBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(10),
                              //     borderSide:
                              //         const BorderSide(width: 1, color: Colors.grey)),
                              // focusedBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(10),
                              //     borderSide:
                              //         const BorderSide(width: 1, color: Colors.grey))
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
                        validator: (value) {
                          controller.validateForPassword(value);
                          return null;
                        },
                        obscureText: controller.obscureText,
                        controller: controller.passwordController,
                        // style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          // border: const OutlineInputBorder(),
                          // labelText: 'password',
                          suffixIcon: IconButton(
                              icon: Icon(
                                controller.obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 16.r,
                              ),
                              onPressed: controller.changePasswordView),
                          //labelStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                          hintText: 'Enter preffered password',
                          // hintStyle: const TextStyle(
                          //   color: Colors.grey,
                          // ),
                          //counterStyle: const TextStyle(color: Colors.red),
                          // enabledBorder: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(10),
                          //     borderSide:
                          //         const BorderSide(width: 1, color: Colors.grey)),
                          // focusedBorder: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(10),
                          //     borderSide:
                          //         const BorderSide(width: 1, color: Colors.grey))
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
