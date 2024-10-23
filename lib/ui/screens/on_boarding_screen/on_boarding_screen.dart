import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salah/local_database/prefs_manager.dart';
import 'package:salah/ui/screens/auth_screen/signup_screen.dart';
import 'package:salah/ui/screens/on_boarding_screen/components/animated_slider.dart';
import 'package:salah/ui/screens/on_boarding_screen/components/prayer_screen.dart';
import 'package:salah/ui/screens/on_boarding_screen/components/tasbih_screen.dart';
import 'package:salah/ui/screens/on_boarding_screen/components/welcome_screen.dart';
import 'package:salah/utils/constant.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PrefsManager prefsManager = PrefsManager.instance;

  StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool _isCheckLocationCalled = false;
  Position? locationPosition;
  int _checkLocationCounter = 0;

  @override
  void initState() {
    super.initState();

    _serviceStatusStreamSubscription =
        Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      if (status == ServiceStatus.enabled) {
        _checkLocation();
      }
    });

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });

      if (_currentPage == 1 && !_isCheckLocationCalled) {
        _checkLocation();
        _isCheckLocationCalled = true;
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _checkLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      _showLocationSnackBar(
        text: 'Location Service Disabled',
        action: SnackBarAction(
          label: 'Turn On',
          textColor: Theme.of(context).colorScheme.surface,
          onPressed: () {
            Geolocator.openLocationSettings();
          },
        ),
      );
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showLocationSnackBar(
          text: 'Location permissions are denied',
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showLocationSnackBar(
        text:
            'Location permissions are permanently denied, we cannot request permissions',
      );
      return;
    }

    Geolocator.getCurrentPosition().then((Position position) {
      locationPosition = position;
    }).catchError((e) {
      _showLocationSnackBar(text: 'Something went wrong');
      locationPosition = null;
    });

    _checkLocationCounter++;
  }

  void _showLocationSnackBar({required String text, SnackBarAction? action,}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        duration: const Duration(seconds: 2),
        action: action,
        margin: const EdgeInsets.all(16),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _onWelcomeScreenClick(){
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  void _onPrayerScreenClick() {
    if (_isCheckLocationCalled && _checkLocationCounter == 1) {
      prefsManager.saveLatLong(
        latitude: locationPosition == null
            ? Constant.DEFAULT_LATITUDE
            : locationPosition!.latitude,
        longitude: locationPosition == null
            ? Constant.DEFAULT_LONGITUDE
            : locationPosition!.longitude,
      );
      _checkLocationCounter--;
    }

    _pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  void _onTasbihScreenClick() {
    prefsManager.saveIsUserNew(false);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _currentPage != 0
            ? AnimatedSlider(
                isShow: _currentPage != 0, isAnimate: _currentPage == 1)
            : null,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: PageView(
              controller: _pageController,
              children: [
                WelcomeScreen(
                  onButtonClick: _onWelcomeScreenClick,
                ),
                PrayerScreen(
                  onButtonClick: _onPrayerScreenClick,
                ),
                TasbihScreen(
                  onButtonClick: _onTasbihScreenClick,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
