import 'package:flutter/material.dart';
import 'package:salah/local_database/prefs_manager.dart';
import 'package:salah/services/auth_service.dart';
import 'package:salah/ui/screens/auth_screen/login_screen.dart';
import 'package:salah/ui/screens/main_screen.dart';
import 'package:salah/ui/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:salah/ui/theme/theme.dart';
import 'package:salah/utils/constant.dart';

class SalahApp extends StatelessWidget {
  SalahApp({super.key});

  final prefsManager = PrefsManager.instance;
  final authService = AuthService.instance;

  @override
  MaterialApp build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constant.APP_NAME,
      theme: lightTheme,
      // Light Theme
      darkTheme: darkTheme,
      // Dark Theme
      home: FutureBuilder<bool>(
        future: prefsManager.getIsUserNew(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final isUserNew = snapshot.data!;
            return isUserNew
                ? const OnBoardingScreen()
                : (authService.isUserLoggedIn()
                ? const MainScreen()
                : const LoginScreen(isLoggedOut: true));
          }

          return const Center(child: Text(Constant.TRY_AGAIN_MESSAGE));
        },
      ),
    );
  }
}
