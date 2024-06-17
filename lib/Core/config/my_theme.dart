import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

final appTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.pageColor,
    textTheme: const TextTheme(
  bodySmall: TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  bodyMedium: TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  ),
  bodyLarge:TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  ),
  headlineMedium: TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.w600,
  ),
));
