import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toni/Core/constants/app_colors.dart';
import 'package:toni/screens/home/main%20screen.dart';
import 'package:toni/screens/profile/cubit/cubit.dart';
import 'package:toni/screens/profile/cubit/states.dart';

import '../../Core/services/global_methods.dart';
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
    return BlocConsumer<ProfileCubit, ProfileState>(listener: (context, state) {
      if (state is ProfileLoadingState) {
        EasyLoading.show();
      } else if (state is ProfileChangePasswordSuccessState) {
        EasyLoading.dismiss();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const MainScreen();
            },
          ),
        );
        GlobalMethods.buildFlutterToast(
          message:"Password Changed Successfully",
          state: ToastStates.SUCCESS,
        );
      } else if (state is ProfileErrorState) {
        EasyLoading.dismiss();
        GlobalMethods.buildFlutterToast(
          message: state.failure.message ?? "Error Occurred",
          state: ToastStates.ERROR,
        );
      }
    }, builder: (context, state) {
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
                    ProfileCubit.get(context).updatePassword(
                      newPassword: newPassword.text,
                      oldPassword: oldPassword.text,
                    );
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
    });
  }
}
