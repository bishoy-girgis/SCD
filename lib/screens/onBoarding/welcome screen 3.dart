import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Core/constants/app_colors.dart';
import '../../Core/widgets/custom_elevated_button.dart';
import 'welcome screen 2.dart';
import 'welcome screen 4.dart';

class WelcomeScreen3 extends StatelessWidget {
  const WelcomeScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Skin cancer does not choose.',
                style: textTheme.bodyLarge,
              ),
              const Spacer(), // Placeholder for the image
              Image.asset(
                'images/scdetect-favicon-color.png',
              ), // You can replace with your image asset
              Text(
                  'Melanoma develops quietly and painlessly, prompt diagnosis offers the possibility of a full cure. Estimates say that one in five people will develop skin cancer. Keep track of changes on your skin and react when you feel doubt.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomElevatedButton(
                    title: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.pageColor,
                      size: 20.sp,
                    ),
                    backgroundColor: AppColors.darkColor,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const WelcomeScreen2();
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: CustomElevatedButton(
                      width: 180.w,
                      title: Text(
                        "Next",
                        style: TextStyle(
                            color: AppColors.pageColor, fontSize: 16.sp),
                      ),
                      backgroundColor: AppColors.darkColor,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const WelcomeScreen4();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    4,
                    (index) => Icon(Icons.circle,
                        size: 8,
                        color: index == 2
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
