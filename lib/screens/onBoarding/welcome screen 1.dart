import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toni/Core/constants/app_colors.dart';
import 'package:toni/Core/widgets/custom_elevated_button.dart';
import 'welcome screen 2.dart';

class WelcomeScreen1 extends StatelessWidget {
  const WelcomeScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Hello!',
                style: textTheme.bodyLarge,
              ),
              Text(
                'Glad to have you with us.',
                style: textTheme.bodyMedium,
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Image.asset('images/scdetect-favicon-color.png'),
              ),
              Text(
                'SCDetect is an application for analyzing nevi on the skin. Its task is to evaluate a nevus for its malignancy.',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium,
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      title: Text(
                        "Next",
                        style: TextStyle(color: AppColors.pageColor, fontSize: 16.sp),
                      ),
                      backgroundColor: AppColors.darkColor,
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return WelcomeScreen2();
                          },
                        ));
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    4,
                    (index) => Icon(Icons.circle,
                        size: 10.sp,
                        color: index == 0
                            ? AppColors.primaryColorGreen
                            : AppColors.secondColorGreen)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
