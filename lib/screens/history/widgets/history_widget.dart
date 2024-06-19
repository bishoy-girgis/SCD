import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:toni/Core/constants/end_points.dart';
import 'package:toni/screens/scan/cubit/cubit.dart';

import '../../../Core/models/HistoryModel.dart';
import '../../../Core/services/dateFormat.dart';

class HistoryWidget extends StatelessWidget {
  HistoryModel historyModel;

  HistoryWidget({
    super.key,
    required this.historyModel,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Slidable(
      endActionPane: ActionPane(
          extentRatio: 0.35,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                ScanCubit.get(context).delete(id: "${historyModel.id}");
              },
              icon: Icons.delete,
              label: "Delete",
              backgroundColor: const Color(0XFFB33030),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
          ]),
      child: Card(
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
                width: 120.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "${EndPoints.baseImage}${historyModel.image}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "Diagnose :${historyModel.diagnose}",
                    style: textTheme.bodySmall,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "Time : ${MyDatetimeUtilities.formatDateTime(historyModel.timestamp ?? "")}",
                    style: textTheme.bodySmall,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
