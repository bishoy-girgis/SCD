import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toni/Core/config/my_theme.dart';
import 'package:toni/screens/splash/splash%20screen.dart';
import 'package:toni/screens/splash/splash_view.dart';
import 'Core/services/bloc_observer.dart';
import 'Core/services/cache_helper.dart';
import 'screens/onBoarding/welcome screen 1.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await SharedPref.init();

  runApp(const SCDetect());
}

class SCDetect extends StatelessWidget {
  const SCDetect({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SCDetect',
        builder: EasyLoading.init(),
        theme: appTheme,
        home: SplashView(),
      ),
    );
  }
}
