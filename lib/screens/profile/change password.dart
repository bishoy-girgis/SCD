import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toni/Core/constants/app_colors.dart';

import '../../Core/widgets/custom_text_form_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ChangePasswordScreenState createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password', style: textTheme.bodyLarge),
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.sp),
          children: <Widget>[
            CustomTextFormField(
              labelText: "Old Password",
              controller: oldPassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please enter your old Password";
                }
                return null;
              },
            ),
            CustomTextFormField(
              labelText: "New Password",
              controller: newPassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please enter your new Password";
                }
                return null;
              },
            ),
            CustomTextFormField(
              labelText: "Confirm Password",
              controller: confirmPassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please confirm your new password";
                } else if (value != newPassword.text) {
                  return "Passwords do not match";
                }
                return null;
              },
            ),
            SizedBox(height: 20.sp),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print("VAlid");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkColor,
              ),
              child: Text(
                'Done',
                style:
                    textTheme.bodySmall?.copyWith(color: AppColors.pageColor),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.pop(context);
                }
              },
              child: Text(
                'cancel',
                style: textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
