import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:toni/screens/home/main%20screen.dart';
import 'package:toni/screens/login/cubit/cubit.dart';
import 'package:toni/screens/login/cubit/states.dart';
import 'package:toni/screens/onBoarding/welcome%20screen%201.dart';
import 'package:toni/screens/signup/widgets/already_have_acc_widget.dart';

import '../../Core/constants/app_colors.dart';
import '../../Core/services/global_methods.dart';
import '../../Core/widgets/custom_elevated_button.dart';
import '../../Core/widgets/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isPasswordVisible = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = RegisterCubit.get(context);
    var textTheme = Theme.of(context).textTheme;
    var h = MediaQuery.of(context).size.height;
    return BlocConsumer<RegisterCubit, LoginState>(listener: (context, state) {
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
            message: state.failure.message ?? " ", state: ToastStates.ERROR);
      } else {
        EasyLoading.dismiss();
      }
    }, builder: (context, state) {
      return Form(
        key: _formKey,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 30.w),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Create an account',
                          style: textTheme.bodyLarge,
                        ),
                        Text(
                          'Fill your information below ',
                          style: textTheme.bodySmall,
                        ),
                        // Adjust the size as needed
                        SizedBox(height: h * 0.12),
                      ],
                    ),
                    Column(
                      children: [
                        CustomTextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your Name";
                              }
                              return null;
                            },
                            labelText: "Name",
                            controller: cubit.nameController,
                            hintText: "Ahmed Sayed Ali"),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your Email";
                              }
                              return null;
                            },
                            labelText: "Email",
                            controller: cubit.emailController,
                            hintText: "example@gmail.com"),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your phone no";
                              }
                              return null;
                            },
                            labelText: "Phone No.",
                            controller: cubit.phoneController,
                            hintText: "01234567890"),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                            labelText: "Password",
                            controller: cubit.passwordController,
                            isSecure: isPasswordVisible,
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
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.h),
                              child: Text(
                                "Select BirthDate :",
                                textAlign: TextAlign.start,
                                style: textTheme.bodyText2,
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  showBottomDatePicker();
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(10.sp),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: AppColors.darkColor,
                                        width: 4,
                                      ),
                                    ),
                                    padding: EdgeInsets.all(12.sp),
                                    child: Text(
                                      cubit.selectedDate
                                          .toString()
                                          .substring(0, 10),
                                      style: textTheme.bodyMedium,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        DropdownButtonFormField<String>(
                          value: cubit.selectedGender,
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            labelStyle: textTheme.bodyText2,
                          ),
                          items: ['Male', 'Female'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: textTheme.bodyText2),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              cubit.selectedGender = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select your gender';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.sp),
                        CustomElevatedButton(
                          width: 300.w,
                          title: Text(
                            "SignUp",
                            style: TextStyle(
                                color: AppColors.pageColor, fontSize: 16.sp),
                          ),
                          backgroundColor: AppColors.darkColor,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.userSignUp();
                            }
                          },
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        const AlreadyHaveAccountWidget(),
                        SizedBox(
                          height: h * 0.2,
                        ),
                        Text(
                          'I accept App’s Terms of User and Privacy Policy.',
                          style: textTheme.bodySmall?.copyWith(fontSize: 11.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  void showBottomDatePicker() async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      initialDate: RegisterCubit.get(context).selectedDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(2030),
    );
    if (chosenDate == null) return;
    setState(() {
      RegisterCubit.get(context).selectedDate = chosenDate;
    });
  }
}

// import 'package:flutter/material.dart';
// import 'VerifyOTPScreen.dart';
// // You'll need to add the flutter_svg package to your pubspec.yaml file.

// class signup1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           // Adjust color as needed
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           // Allows the screen to be scrollable, it helps with different device sizes and keyboard pop up.
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: 25,
//                   ),
//                   Column(
//                     children: [
//                       Text(
//                         'Create Account',
//                         style: TextStyle(
//                             fontSize: 32, fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         'Fill your information below ',
//                         style: TextStyle(fontSize: 18, color: Colors.grey),
//                       ),
//                       // SizedBox(
//                       //   width: 35,
//                       // ),
//                       // Adjust the size as needed
//                       SizedBox(height: 100),
//                     ],
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 24),
//                 child: Column(
//                   children: [
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: 'Your Name',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: 'Your email',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: 'phone no.',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     TextField(
//                       obscureText: true, // Hides the password
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 24),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return VerifyOTPScreen();
//                         })); // TODO: Implement login logic
//                       },
//                       child: Text(
//                         'Next',
//                         textAlign: TextAlign.center,
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: Colors.blue,
//                         shape: StadiumBorder(),
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 180.0, vertical: 16.0),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 300,
//                     ),
//                     Text(
//                       'I accept App’s Terms of User and Privacy Policy.',
//                       style: TextStyle(fontSize: 10),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
