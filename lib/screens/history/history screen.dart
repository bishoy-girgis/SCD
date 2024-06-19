import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toni/Core/constants/end_points.dart';
import 'package:toni/Core/services/dateFormat.dart';
import 'package:toni/screens/history/widgets/history_widget.dart';
import 'package:toni/screens/scan/cubit/states.dart';

import '../../Core/models/HistoryModel.dart';
import '../scan/cubit/cubit.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<HistoryModel>? history;

  @override
  void initState() {
    ScanCubit.get(context).getAllHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return BlocConsumer<ScanCubit, ScanState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ScanCubit.get(context);
          history = cubit.allHistory;
          return Scaffold(
            appBar: AppBar(
              title: Text('History', style: textTheme.bodyLarge),
              centerTitle: true,
              elevation: 4,
              shadowColor: Colors.grey,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: history?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 3.h),
                        child: HistoryWidget(
                          historyModel: history![index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
