import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toni/Core/constants/app_colors.dart';
import 'package:toni/screens/home/widgets/doctor_widget.dart';

import '../../Core/models/doctor_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<Widget> slidesImages = [
    Image.asset("images/cancer1.jpg"),
    Image.asset("images/cancer2.png"),
    Image.asset("images/cancer3.jpg"),
    Image.asset("images/cancer4.png"),
    Image.asset("images/cancer5.png"),
    Image.asset("images/cancer6.jpg"),
  ];
  List<DoctorModel> doctors = [
    DoctorModel(
        name: "Ahmed Sayed Ali",
        type: "General Pulmonologist",
        rate: "4.6",
        time: "1:00 - 4:00 PM"),
    DoctorModel(
        name: "Magdy Saeed ",
        type: "Pulmonary Oncologist",
        rate: "4.8",
        time: "6:00 - 9:00 PM"),
    DoctorModel(
        name: "Hossam Adel",
        type: "Immunologist",
        rate: "4.2",
        time: "3:00 - 7:00 PM"),
    DoctorModel(
        name: "Hany Mohsen",
        type: "Thoracic Surgeon",
        rate: "4.0",
        time: "4:00 - 8:00 PM"),
    DoctorModel(
        name: "Ali Gameel",
        type: "Thoracic Surgeon",
        rate: "4.1",
        time: "5:00 - 8:00 PM"),
  ];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
      appBar: AppBar(
          title: Image.asset(
            'images/logo-no-background.png',
            height: 24.sp,
          ),
          elevation: 5,
          shadowColor: Colors.grey.shade100,
          centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome ...',
                style:
                textTheme.bodyLarge?.copyWith(color: AppColors.darkColor),
              ),
              SizedBox(
                height: 14.h,
              ),
              Text(
                'Treatment Suggestions',
                style: textTheme.bodyMedium?.copyWith(color: Colors.black),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                child: ImageSlideshow(
                  width: double.infinity,
                  height: 160.h,
                  initialPage: 0,
                  indicatorColor: AppColors.primaryColorGreen,
                  indicatorBackgroundColor: AppColors.lightGreenColor,
                  indicatorPadding: 8,
                  indicatorBottomPadding: 0,
                  indicatorRadius: 3,
                  autoPlayInterval: 6000,
                  isLoop: true,
                  children: slidesImages,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommended Doctors',
                    style: textTheme.bodyMedium?.copyWith(color: Colors.black),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "view all",
                        style:
                        textTheme.bodySmall?.copyWith(color: Colors.grey),
                      ),
                      Icon(
                        Icons.arrow_right,
                        size: 14.sp,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(itemBuilder: (context, index) {
                  return Padding(
                    padding:  EdgeInsets.all(4.sp),
                    child: DoctorWidget(name: doctors[index].name,
                        type: doctors[index].type,
                        rate: doctors[index].rate,
                        time: doctors[index].time),
                  );
                },
                scrollDirection: Axis.vertical,itemCount: doctors.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
