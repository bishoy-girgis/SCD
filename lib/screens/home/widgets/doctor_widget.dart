import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Core/constants/app_colors.dart';

class DoctorWidget extends StatelessWidget {
  String name;
  String type;
  String rate;
  String time;

  DoctorWidget({
    super.key,
    required this.name,
    required this.type,
    required this.rate,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 6.w),
        width: double.infinity,
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 120.h,
              width: 130.w,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/doctor.jpg"),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  "DR. $name",
                  style: textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  type,
                  style: textTheme.bodySmall?.copyWith(
                      color: AppColors.primaryColorGreen.withOpacity(0.7)),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  children: [
                    ImageIcon(const AssetImage("images/star.png"),
                        size: 17.sp, color: const Color(0XFFFDD835)),
                    SizedBox(
                      width: 12.w,
                    ),
                    Text(
                      rate,
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.clock_fill,
                      color: AppColors.primaryColorGreen,
                      size: 17.sp,
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Text(
                      time,
                      style: textTheme.bodySmall,
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
