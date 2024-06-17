import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants/app_colors.dart';
import '../widgets/text_builder.dart';

class GlobalMethods {
  static Future<void> showAlertAddressDialog(BuildContext context,
      {required String title,
      TextEditingController? controller,
      Function()? onPressedButton1,
      Function()? onPressedButton2,
      String? titleButton1,
      String? titleButton2,
      Widget? content}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: TextBuilder(title),
          content: content,
          actions: [
            titleButton1 != null
                ? SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: onPressedButton1,
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.primaryColorGreen,
                      ),
                      child: TextBuilder(
                        titleButton1,
                        color: AppColors.pageColor,
                      ),
                    ),
                  )
                : Container(),
            titleButton2 != null
                ? SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: onPressedButton2,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: TextBuilder(
                        titleButton2,
                        color: AppColors.pageColor,
                      ),
                    ),
                  )
                : Container(),
          ],
        );
      },
    );
  }

  static Future<bool?> buildFlutterToast({
    required String message,
    required ToastStates state,
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity,
        timeInSecForIosWeb: 4,
        backgroundColor: _chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 18.0);
  }

  static Color _chooseToastColor(ToastStates state) {
    Color color;
    switch (state) {
      case ToastStates.SUCCESS:
        color = AppColors.secondColorGreen;
        break;

      case ToastStates.ERROR:
        color = Colors.red;
        break;
      case ToastStates.WARNING:
        color = AppColors.darkColor;
        break;
    }
    return color;
  }



}

enum ToastStates { SUCCESS, ERROR, WARNING }
