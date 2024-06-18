import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toni/Core/constants/app_colors.dart';
import 'package:toni/Core/widgets/custom_text_form_field.dart';
import 'package:toni/screens/profile/change%20password.dart';
import 'package:toni/screens/splash/splash%20screen.dart';

import '../../Core/services/global_methods.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late DateTime selectedDate;
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    selectedDate = DateTime.now();
    // Fetch initial profile data
    ProfileCubit.get(context).getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: textTheme.bodyText1),
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoadingState) {
            EasyLoading.show();
          } else if (state is ProfileSuccessState) {
            EasyLoading.dismiss();
            _nameController.text = state.userData.name!;
            _emailController.text = state.userData.email!;
            _phoneController.text = state.userData.phone!;
            selectedDate = DateTime.parse(state.userData.birthday!);
            // Set selected gender from API data
            selectedGender = state.userData.gender == 'M' ? 'Male' : 'Female';
          } else if (state is ProfileErrorState) {
            EasyLoading.dismiss();
            GlobalMethods.buildFlutterToast(
              message: state.failure.message ?? "Error Occurred",
              state: ToastStates.ERROR,
            );
          } else if (state is ProfileUpdateSuccessState) {
            EasyLoading.dismiss();
            GlobalMethods.buildFlutterToast(
              message: "Data Updated Successfully",
              state: ToastStates.SUCCESS,
            );
            _nameController.text = state.userData.name!;
            _emailController.text = state.userData.email!;
            _phoneController.text = state.userData.phone!;
            selectedDate = DateTime.parse(state.userData.birthday!);
            // Update selected gender after successful update
            selectedGender = state.userData.gender == 'M' ? 'Male' : 'Female';
          } else if(state is ProfileDeleteSuccessState){
            EasyLoading.dismiss();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SplashScreen()),
                  (route) => false,
            );
            GlobalMethods.buildFlutterToast(
              message: "Account Deleted Successfully",
              state: ToastStates.SUCCESS,
            );
          }
        },
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            var cubit = ProfileCubit.get(context);
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                children: <Widget>[
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  CustomTextFormField(
                    labelText: "Full Name",
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    labelText: "Your Email",
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Email";
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    labelText: "Phone No.",
                    controller: _phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your phone no";
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.h),
                        child: Text(
                          "Select BirthDate :",
                          textAlign: TextAlign.start,
                          style: textTheme.bodyText2,
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            showBottomDatePicker();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10.sp),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.darkColor,
                                  width: 4,
                                ),
                              ),
                              padding: EdgeInsets.all(12.sp),
                              child: Text(
                                selectedDate.toString().substring(0, 10),
                                style: textTheme.bodyText2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedGender,
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      labelStyle: textTheme.bodyText2,
                    ),
                    items: ['Male', 'Female'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: textTheme.bodyText2),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your gender';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        cubit.updateProfileData(
                          name: _nameController.text,
                          email: _emailController.text,
                          phone: _phoneController.text,
                          birthDate: selectedDate.toString().substring(0, 10),
                          gender: selectedGender == 'Male' ? 'M' : 'F',
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColorGreen,
                    ),
                    child: Text(
                      'Update Information',
                      style: textTheme.bodyText2
                          ?.copyWith(color: AppColors.pageColor),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePasswordScreen(),
                        ),
                      );
                    }, // Handle change password
                    child: Text(
                      'Change Password',
                      style: textTheme.bodyText2,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showSignOutConfirmation(context);
                    },
                    // Call the sign out confirmation dialog// Handle sign out
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkColor,
                    ),
                    child: Text(
                      'Log Out',
                      style: textTheme.bodyText2
                          ?.copyWith(color: AppColors.pageColor),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {_showDeleteConfirmation(context);},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      'Delete Account',
                      style: textTheme.bodyText2
                          ?.copyWith(color: AppColors.pageColor),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void showBottomDatePicker() async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(2030),
    );
    if (chosenDate == null) return;
    setState(() {
      selectedDate = chosenDate;
    });
  }

  void _showSignOutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('Are You sure, You want to sign out',
              style: Theme.of(context).textTheme.bodyMedium),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SplashScreen()),
                  (route) => false,
                );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('Are You sure, You want to Delete Account',
              style: Theme.of(context).textTheme.bodyMedium),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ProfileCubit.get(context).deleteAccount();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

}
