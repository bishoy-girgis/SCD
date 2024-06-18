import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toni/Core/constants/app_colors.dart';

class HelpScreen extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      'question': 'How to perform scanning correctly?',
      'answer':
      'To ensure proper scan analysis, remember a few simple rules. The object being scanned, i.e. the birthmark on the skin, should be at a distance from the camera of no less than 8 cm and no more than 15 cm. It is important that the entire birthmark be visible in the camera frame, which is always in the center. Remember to perform scans of only one nevus at a time.Try to keep the camera as still as possible while scanning. For optimum image quality, make sure the birthmark is photographed sharply. Touch the screen where the birthmark is located to focus the camera on it.Make sure, there is a good light (whether the scan photo isn\'t overexposed or too dark). For taking photo the best is natural daylight. If there is too little light turn on the flashlight, to highlight the scanned object.'
    },
    {
      'question': 'How to get more scans?',
      'answer':
      'If you don’t have scans, you can get additional packages for free or for points. To do this, just click on settings and then in spy on concerning a topping up your scanner counter. There are several tried and popular methods of topping up to choose.'
    },
    {
      'question': 'Why appeared an information, that I can\'t make a scan?',
      'answer':
      'There is a few causes, that can explain why this information appears, such as:scanned object doesn\'t take place on the skin,scanned object is overexpose or poorly lot,photo is blurred,scanned birthmark is too small (or the object-lens is too far), to subject it of the analysis,no connection to the Internet.'
    },
    {
      'question':
      'Do my photos or other data, that can identify me, are keeping on the Medic Scanner Server?',
      'answer':
      'Scanning is absolutely anonymous. After analysis, the photo is deleted from the Medic Scanner Server.Photos of the scans are keeping on your device, and no one can watch them, unless you authorize someone. The encoded photo shall be sent to Medic Scanner server, analyzed and deleted. All connections with the Medic Scanner servers are enciphered. Photos kept on your device are also encoded.'
    },
    {
      'question': 'Does the result of scanning is a diagnosis?',
      'answer':
      'No, it doesn\'t. It is an analytical result, based on comparison of sent photo with photos located in application base, concerning recognized cases. If the result is worrying for you, you have to go to the specialist physician, to make sure. Your health and life are the most important thing. Remember, if you feel, that something is wrong, don\'t wait.'
    },
    // Add more FAQ entries as needed
  ];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Help', style: textTheme.bodyLarge),
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
            decoration: BoxDecoration(
              color: AppColors.primaryColorGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ExpansionTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              iconColor: Colors.white, // Color of the expanded icon
              collapsedIconColor: Colors.white, // Color of the collapsed icon
              title: Text(
                faqs[index]['question']!,
                style: textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
              children: <Widget>[
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(15.sp),
                  child: Text(
                    faqs[index]['answer']!,
                    style: textTheme.bodySmall?.copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
