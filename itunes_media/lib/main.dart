import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itunes_media/theme/app_theme.dart';
import 'package:itunes_media/modules/splash/view/splash_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: false,
        child: MaterialApp(
          title: 'I Tunes Media',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.fromIsDarkModeActive(true).theme,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
