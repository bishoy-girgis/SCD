import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toni/Core/constants/app_colors.dart';
import 'package:toni/screens/help/help%20screen.dart';
import 'package:toni/screens/history/history%20screen.dart';
import 'package:toni/screens/scan/Scan%20Result.dart';
import 'package:toni/screens/home/home_screen.dart';
import 'package:toni/screens/profile/profile%20screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:toni/screens/scan/cubit/cubit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  File? image;
  final ImagePicker picker = ImagePicker();

  Future<void> chooseImage({required bool camera}) async {
    final pickedFile = await picker.pickImage(
      imageQuality: 10,
      source: camera ? ImageSource.camera : ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      if (!mounted) return;
     await ScanCubit.get(context).scan(image: image!);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScanResult(
            image: image!,
          ),
        ),
      );
    } else {
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  void _showPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () => chooseImage(camera: true),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo'),
                onTap: () => chooseImage(camera: false),
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Cancel'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> pages = [
    HomeScreen(),
    HelpScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(
            Icons.home,
            size: 22.sp,
            color: AppColors.pageColor,
          ),
          Icon(
            Icons.help_outline,
            size: 22.sp,
            color: AppColors.pageColor,
          ),
          Icon(
            Icons.history_rounded,
            size: 22.sp,
            color: AppColors.pageColor,
          ),
          Icon(
            CupertinoIcons.profile_circled,
            size: 22.sp,
            color: AppColors.pageColor,
          ),
        ],
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 250),
        height: 50,
        buttonBackgroundColor: AppColors.primaryColorGreen,
        backgroundColor: Colors.transparent,
        color: AppColors.primaryColorGreen,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        index: currentIndex,
      ),
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(
          side: BorderSide(
            color: AppColors.lightGreenColor,
            width: 2,
          ),
        ),
        isExtended: true,
        onPressed: () => _showPopup(context),
        backgroundColor: AppColors.secondColorGreen,
        child: Icon(
          CupertinoIcons.camera_fill,
          size: 22.sp,
          color: AppColors.pageColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
    );
  }
}
