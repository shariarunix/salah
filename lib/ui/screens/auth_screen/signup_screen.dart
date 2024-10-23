import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salah/services/auth_service.dart';
import 'package:salah/ui/components/s_button.dart';
import 'package:salah/ui/components/s_text_field.dart';
import 'package:salah/ui/screens/auth_screen/login_screen.dart';
import 'package:salah/ui/screens/home_screen/home_screen.dart';
import 'package:salah/ui/screens/main_screen.dart';
import 'package:salah/utils/constant.dart';
import 'package:salah/validators/email_validator.dart';
import 'package:salah/validators/password_validator.dart';

import '../../../utils/result_utils.dart';
import '../../components/s_divider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({
    super.key,
    this.isFromLogin = false,
  });

  final bool isFromLogin;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final authService = AuthService.instance;

  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();

  IconData _passShowHideIcon = Icons.visibility_off_rounded;
  bool _isPasswordShown = false;

  String? _emailErrorText;
  String? _passWordErrorText;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_emailControllerListener);
    _passWordController.addListener(_passWordControllerListener);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.removeListener(_emailControllerListener);
    _passWordController.removeListener(_passWordControllerListener);
    _emailController.dispose();
    _passWordController.dispose();
  }

  void _emailControllerListener() {
    setState(() {
      _emailErrorText = EmailValidator.execute(_emailController.text);
    });
  }

  void _passWordControllerListener() {
    setState(() {
      _passWordErrorText = PasswordValidator.execute(_passWordController.text);
    });
  }

  void _togglePassVisibility() {
    setState(() {
      _isPasswordShown = !_isPasswordShown;
      _passShowHideIcon = _isPasswordShown
          ? Icons.visibility_rounded
          : Icons.visibility_off_rounded;
    });
  }

  void _onLoginClick() {
    if (widget.isFromLogin) {
      Navigator.pop(context);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  Future<void> _onSignUpClick() async {
    // After Log Click Re Validate EMAIL & PASSWORD
    _emailControllerListener();
    _passWordControllerListener();

    // If there is error in EMAIL & PASSWORD return;
    if (_emailErrorText != null || _passWordErrorText != null) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    Result<User?> signInResult = await authService.signIn(
      _emailController.text.trim(),
      _passWordController.text.trim(),
    );

    if (signInResult is Success<User?> && signInResult.result != null) {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (Route<dynamic> route) => false,
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(signInResult is Failure
              ? signInResult.message
              : Constant.TRY_AGAIN_MESSAGE),
          backgroundColor: Theme.of(context).colorScheme.onSurface,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.all(16),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Text(
                'Sign Up',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign up to track, reflect, and elevate your spiritual journey.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SDivider(
                margin: EdgeInsets.symmetric(vertical: 16),
              ),

              // Email Section
              STextField(
                controller: _emailController,
                hintText: 'e.g. example@gmail.com',
                errorText: _emailErrorText,
                prefixIcon: Icons.email_rounded,
                maxLines: 1,
                keyBoardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 12),

              // Password Section
              STextField(
                controller: _passWordController,
                hintText: 'e.g. Your Password',
                errorText: _passWordErrorText,
                prefixIcon: Icons.password_rounded,
                suffixIcon: _passShowHideIcon,
                onTapSuffixIcon: _togglePassVisibility,
                maxLines: 1,
                keyBoardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                obscureText: !_isPasswordShown,
                obscuringCharacter: '*',
              ),

              const SizedBox(height: 56),

              // Sign Up Button
              SButton(
                text: 'Sign Up',
                isLoading: _isLoading,
                onButtonClick: _onSignUpClick,
              ),

              // Goto Login Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: _onLoginClick,
                    child: const Text('Log In'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
