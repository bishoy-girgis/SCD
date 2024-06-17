import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:toni/Core/services/cache_helper.dart';
import 'package:toni/Core/widgets/custom_text_form_field.dart';
import 'package:toni/screens/home/main%20screen.dart';
import 'package:toni/screens/splash/widgets/dont_have_acc_widget.dart';
import '../../Core/constants/app_colors.dart';
import '../../Core/widgets/custom_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = true;

  Future<void> performLogin() async {
    var url = Uri.parse('https://scd.skin/mobile_api/login')
        .replace(queryParameters: {
      'email': _emailController.text,
      'password': _passwordController.text,
    });
    try {
      final response = await http.get(
        url,
        headers: {
          // 'Content-Type': 'application/json',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        // If server returns an OK response, parse the token or proceed further
        final responseData = json.decode(response.body);
        // Assuming 'token' is a part of the response for successful login
        print(responseData['token']);
        if (responseData['token'] != null) {
          SharedPref.set(key: "accessToken", value: (responseData['token']));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return MainScreen();
          }));
          // Navigator.pushReplacementNamed(
          //     context, 'mainScreen'); // Ensure the route is defined
        } else {
          _showErrorDialog('Invalid login credentials');
        }
      } else {
        // If response is not OK, show error message
        _showErrorDialog('Login failed: ${response.reasonPhrase}');
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
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(
                  height:h  * 0.15,
                ),
                Image.asset(
                  'images/logo-no-background.png',
                ),
                SizedBox(
                  height:h  * 0.2,
                ),
                Column(
                  children: [
                    CustomTextFormField(
                        labelText: "Email",
                        controller: _emailController,
                        hintText: "example@gmail.com"),
                    SizedBox(height: 15.sp),
                    CustomTextFormField(
                        labelText: "Password",
                        controller: _passwordController,
                        isSecure:isPasswordVisible,
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
                          style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.primaryColorGreen,
                            fontSize: 11.sp,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryColorGreen,
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
                      onPressed: () {
                        performLogin();
                      },
                    ),
                    SizedBox(
                      height: h*0.15 ,
                    ),
                    const DoNotHaveAccountWidget()
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
// import 'package:toni/screens/main%20screen.dart';
// import 'signup_screen.dart'; // You'll need to add the flutter_svg package to your pubspec.yaml file.

// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           // Allows the screen to be scrollable, it helps with different device sizes and keyboard pop up.
//           child: Column(
//             children: [
//               SizedBox(height: 100),
//               Image.asset(
//                 'D:/projects/toni/images/logo-no-background.png',
//                 height: 75,
//               ), // Adjust the size as needed
//               SizedBox(height: 220),

//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 24),
//                 child: Column(
//                   children: [
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: 'Your email',
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
//                         Navigator.pushReplacement(context,
//                             MaterialPageRoute(builder: (context) {
//                               return MainScreen();
//                             })); // TODO: Implement login logic
//                       },
//                       child: Text(
//                         'Log In',
//                         textAlign: TextAlign.center,
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: Colors.blue,
//                         shape: StadiumBorder(),
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 150.0, vertical: 16.0),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         // TODO: Navigate to forgot password screen
//                       },
//                       child: Text(
//                         'Forgot your password?',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 90,
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                               return Signup1();
//                             })); // TODO: Navigate to create account screen
//                       },
//                       child: Text(
//                         'Don’t have an account? Create account',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(color: Colors.black),
//                       ),
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
