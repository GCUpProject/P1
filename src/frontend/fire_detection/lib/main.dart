import 'package:flutter/material.dart';
import './pages/LandingPage.dart';

class AppColors {
  // Community Background
  static const Color communityBackgroundRadialStart = Color(0xFF89AAFF);
  static const Color communityBackgroundRadialEnd = Color(0xFFFFCEE6);
  static const Color communityBackground = Color(0xFFF5FAFF);

  // Primary Color
  static const Color primaryColor = Color(0xFFFE554A);
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFF9881F), Color(0xFFFE554A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Accent
  static const Color accentColor = Color(0xFF0B735F);

  // Shades
  static const Color shade01 = Color(0xFF2A3037);
  static const Color shade02 = Color(0xFFAAACAE);
  static const Color shade03 = Color(0xFFDFE2E5);
  static const Color shade04 = Color(0xFFFCFCFC);
}

// 테마 생성
final ThemeData appTheme = ThemeData(
  // 다른 테마 설정은 여기에 추가할 수 있습니다.
  primaryColor: AppColors.primaryColor,
  hintColor: AppColors.accentColor,
  backgroundColor: AppColors.communityBackground,
  scaffoldBackgroundColor: AppColors.communityBackground,
  appBarTheme: AppBarTheme(
    color: AppColors.primaryColor,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: AppColors.primaryColor,
    textTheme: ButtonTextTheme.primary,
  ),
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fire Detection',
      home: LandingPage(), // LandingPage로 변경
    );
  }
}
