import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toni/screens/home/main%20screen.dart';
import '../../Core/constants/app_colors.dart';
import '../../Core/widgets/custom_elevated_button.dart';
import 'welcome screen 3.dart';
import '../splash/splash screen.dart';

class WelcomeScreen4 extends StatelessWidget {
  const WelcomeScreen4({super.key});

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
                'See how easy it is!',
                style: textTheme.bodyLarge,
              ),
              const Spacer(), // Placeholder for the image
              Image.asset(
                'images/scdetect-favicon-color.png',
              ),
              const Spacer(),
              Text(
                'Perform a nevus analysis - right now!',
                style: textTheme.bodyLarge,
              ),
              SizedBox(height: 25.h),
              Text(
                'Remember that the application does not make a diagnosis, and any worrying result requires consultation with a doctor.',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium,
              ),
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
                            return const WelcomeScreen3();
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
                              return  MainScreen();
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
                        color: index == 3
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
