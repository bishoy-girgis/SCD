import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toni/screens/splash/widgets/dont_have_acc_widget.dart';
import '../../Core/constants/app_colors.dart';
import '../../Core/widgets/custom_elevated_button.dart';
import '../login/loginscreen.dart';
import '../signup/signup_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 14.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                'images/logo-no-background.png',
                height: 70,
              ),
              const Spacer(),
              Text(
                "Welcome To \n SCDetect",
                style: textTheme.bodyLarge
                    ?.copyWith(fontSize: 28.sp, fontWeight: FontWeight.bold),
              ),
              const Spacer(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Text(
                      'SCDetect is an application for analyzing nevi on the skin. Its task is to evaluate a nevus for its malignancy.',
                      textAlign: TextAlign.center,
                      style: textTheme.bodySmall
                          ?.copyWith(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Melanoma and basal cell carcinoma are two of the most dangerous skin cancers.Recognizing them quickly can save your life and the lives of your loved ones.Have doubts about your birthmarks? Get them checked immediately!',
                      textAlign: TextAlign.center,
                      style: textTheme.bodySmall
                          ?.copyWith(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CustomElevatedButton(
                width: 300.w,
                title: Text(
                  "LogIn",
                  style: TextStyle(
                      color: AppColors.pageColor, fontSize: 16.sp),
                ),
                backgroundColor: AppColors.darkColor,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return  const LoginScreen();
                      },
                    ),
                  );
                },
              ),
              const DoNotHaveAccountWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
