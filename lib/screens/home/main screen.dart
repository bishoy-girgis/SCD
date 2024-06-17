import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toni/Core/constants/app_colors.dart';
import 'package:toni/screens/help screen.dart';
import 'package:toni/screens/history screen.dart';
import 'package:toni/screens/Scan%20Result.dart';
import 'package:toni/screens/home/home_screen.dart';
import 'package:toni/screens/profile screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

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
                onTap: ()  {
                   takeImage();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScanResult(
                          image: image,
                        ),
                      ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo'),
                onTap: ()  {
                   getImage();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScanResult(
                          image: image,
                        ),
                      ));
                },
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

  File? image;
  final Picker = ImagePicker();

  Future getImage() async {
    final pickedImage = await Picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
      } else {
        print("No image is picked");
      }
    });
  }

  File? pic;
  final taker = ImagePicker();

  Future takeImage() async {
    final takedImage = await Picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (takedImage != null) {
        image = File(takedImage.path);
      } else {
        print("No image is picked");
      }
    });
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
