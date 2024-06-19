import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:toni/Core/constants/app_colors.dart';
import 'package:toni/Core/models/HistoryModel.dart';
import 'package:toni/screens/scan/cubit/cubit.dart';
import 'package:toni/screens/scan/cubit/states.dart';

import '../../Core/services/dateFormat.dart';

class ScanResult extends StatelessWidget {
  const ScanResult({super.key, this.image});

  final File? image;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return BlocConsumer<ScanCubit, ScanState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ScanCubit.get(context);
        HistoryModel? historyScan = cubit.scanResult;
        String formattedDate = "";
        if (historyScan != null && historyScan.timestamp != null) {
          formattedDate =
              MyDatetimeUtilities.formatDateTime(historyScan.timestamp!);
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Scan Result', style: textTheme.bodyLarge),
            elevation: 5,
            shadowColor: Colors.grey.shade100,
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  image == null
                      ? const Text('No Image Picked')
                      : Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 14.h),
                            height: MediaQuery.sizeOf(context).height * 0.4,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                image: FileImage(File(image!.path)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Text('Diagnose : ', style: textTheme.bodyLarge),
                      Text(
                        historyScan?.diagnose ?? "",
                        style: textTheme.bodyLarge
                            ?.copyWith(color: AppColors.primaryColorGreen),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  if (formattedDate
                      .isNotEmpty) // Only show if date is available
                    Text(
                      'Date : $formattedDate',
                      style: textTheme.bodyLarge
                          ?.copyWith(color: AppColors.primaryColorGreen),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
