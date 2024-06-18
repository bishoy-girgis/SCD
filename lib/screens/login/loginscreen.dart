import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:toni/Core/services/cache_helper.dart';
import 'package:toni/Core/services/web_service.dart';
import 'package:toni/Core/widgets/custom_text_form_field.dart';
import 'package:toni/screens/home/main%20screen.dart';
import 'package:toni/screens/login/cubit/cubit.dart';
import 'package:toni/screens/splash/widgets/dont_have_acc_widget.dart';
import '../../Core/constants/app_colors.dart';
import '../../Core/services/global_methods.dart';
import '../../Core/widgets/custom_elevated_button.dart';
import 'cubit/states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = LoginCubit.get(context);
    var h = MediaQuery.of(context).size.height;
    return BlocConsumer<LoginCubit,LoginState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          EasyLoading.show();
        } else if (state is LoginSuccessState) {
          EasyLoading.dismiss();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const MainScreen();
              },
            ),
          );
          GlobalMethods.buildFlutterToast(
            message: "Welcome to SCDetect App",
            state: ToastStates.SUCCESS,
          );
        } else if (state is LoginErrorState) {
          EasyLoading.dismiss();
          debugPrint("🎐🎐🎐🎐🎐🎐${state.failure.statusCode}");
          debugPrint("🎐🎐${state.failure.message ?? " "}");
          GlobalMethods.buildFlutterToast(
              message: state.failure.message ?? " ",
              state: ToastStates.ERROR);
        } else {
          EasyLoading.dismiss();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Form(
            key: _formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 40.h, horizontal: 24.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: h * 0.15,
                      ),
                      Image.asset(
                        'images/logo-no-background.png',
                      ),
                      SizedBox(
                        height: h * 0.2,
                      ),
                      Column(
                        children: [
                          CustomTextFormField(
                              labelText: "Email",
                              controller: cubit.userNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "please Enter your Email";
                                }
                                return null;
                              },
                              hintText: "example@gmail.com"),
                          SizedBox(height: 15.sp),
                          CustomTextFormField(
                              labelText: "Password",
                              controller: cubit.passwordController,
                              isSecure: isPasswordVisible,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "please enter you password";
                                }
                                return null;
                              },
                              suffixIcon: isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              suffixPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              hintText: "P@ssw0rd"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Forgot your password?',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AppColors.primaryColorGreen,
                                      fontSize: 11.sp,
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          AppColors.primaryColorGreen,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.sp),
                          CustomElevatedButton(
                            width: 300.w,
                            title: Text(
                              "LogIn",
                              style: TextStyle(
                                  color: AppColors.pageColor, fontSize: 16.sp),
                            ),
                            backgroundColor: AppColors.darkColor,
                            onPressed: ()  {
                              if (_formKey.currentState!.validate()) {
                                 cubit.userLogin();
                              }
                            }
                          ),
                          SizedBox(
                            height: h * 0.15,
                          ),
                          const DoNotHaveAccountWidget()
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}