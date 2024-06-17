import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:toni/screens/home/main%20screen.dart';
import 'package:toni/screens/onBoarding/welcome%20screen%201.dart';
import 'package:toni/screens/signup/widgets/already_have_acc_widget.dart';

import '../../Core/constants/app_colors.dart';
import '../../Core/widgets/custom_elevated_button.dart';
import '../../Core/widgets/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = true;

  Future<void> register() async {
    var url = Uri.parse('https://scd.skin/mobile_api/registration/');
    try {
      final response = await http.post(url, headers: {}, body: {
        'name': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'phone': _phoneController.text,
        'birthday': '2001-03-23',
        'gender': 'M'
      });
      // final responseData = json.decode(response.body);
      // print(responseData);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);
        // Assuming the API returns some form of verification token or success response
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return const WelcomeScreen1();
        }));
      } else {
        _showErrorDialog('Registration failed: ${response.body}');
      }
    } catch (e) {
      _showErrorDialog('Network error: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
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
                        labelText: "Name",
                        controller: _nameController,
                        hintText: "Ahmed Sayed Ali"),
                    SizedBox(height: 10.h),
                    CustomTextFormField(
                        labelText: "Email",
                        controller: _emailController,
                        hintText: "example@gmail.com"),
                    SizedBox(height: 10.h),
                    CustomTextFormField(
                        labelText: "Phone No.",
                        controller: _phoneController,
                        hintText: "01234567890"),
                    SizedBox(height: 10.h),
                    CustomTextFormField(
                        labelText: "Password",
                        controller: _passwordController,
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
                    SizedBox(height: 20.sp),
                    CustomElevatedButton(
                      width: 300.w,
                      title: Text(
                        "SignUp",
                        style: TextStyle(
                            color: AppColors.pageColor, fontSize: 16.sp),
                      ),
                      backgroundColor: AppColors.darkColor,
                      onPressed: () async {
                        await register();
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
    );
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
