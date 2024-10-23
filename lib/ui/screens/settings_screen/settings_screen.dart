import 'package:flutter/material.dart';
import 'package:salah/local_database/prefs_manager.dart';
import 'package:salah/services/auth_service.dart';
import 'package:salah/ui/components/s_button.dart';
import 'package:salah/ui/screens/auth_screen/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.onBackPressed});

  final VoidCallback onBackPressed;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final authService = AuthService.instance;
  final prefsManager = PrefsManager.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
            onPressed: widget.onBackPressed,
            icon: const Icon(Icons.arrow_back_rounded)),
        title: const Text('Settings Screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SButton(
            text: 'Log Out',
            onButtonClick: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen(isLoggedOut : true)),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ),
      ),
    );
  }
}
