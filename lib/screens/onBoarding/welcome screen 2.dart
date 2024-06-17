import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Core/constants/app_colors.dart';
import '../../Core/widgets/custom_elevated_button.dart';
import 'welcome screen 1.dart';
import 'welcome screen 3.dart';

class WelcomeScreen2 extends StatelessWidget {
  const WelcomeScreen2({super.key});

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
                'Start taking control of your skin.',
                style: textTheme.bodyLarge,
              ),
              const Spacer(),
              Image.asset(
                'images/scdetect-favicon-color.png',
              ), // You can replace with your image asset
              // const Spacer(),
              Text(
                  'Melanoma and basal cell carcinoma are two of the most dangerous skin cancers.Recognizing them quickly can save your life and the lives of your loved ones.Have doubts about your birthmarks? Get them checked immediately!',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomElevatedButton(
                    title:  Icon(
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
                            return const WelcomeScreen1();
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 10.w,),
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
                              return const WelcomeScreen3();
                            },
                          ),
                        );
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
                        size: 8,
                        color: index == 1
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
