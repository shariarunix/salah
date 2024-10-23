import 'package:flutter/material.dart';
import 'package:salah/ui/screens/books_screen/books_screen.dart';
import 'package:salah/ui/screens/home_screen/home_screen.dart';
import 'package:salah/ui/screens/settings_screen/settings_screen.dart';
import 'package:salah/ui/screens/search_screen/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final bottomNavList = [
    {'icon': Icons.home_filled, 'label': 'Home'},
    {'icon': Icons.search_rounded, 'label': 'Search'},
    {'icon': Icons.import_contacts_rounded, 'label': 'Books'},
    {'icon': Icons.settings, 'label': 'Settings'},
  ];

  final screenList = <Widget>[
    const HomeScreen(),
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    screenList.addAll([
      SearchScreen(onBackPressed: _goBackToHomeScreen,),
      BooksScreen(onBackPressed: _goBackToHomeScreen,),
      SettingsScreen(onBackPressed: _goBackToHomeScreen,),
    ]);
  }

  void _goBackToHomeScreen() {
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            IndexedStack(
              index: _currentIndex,
              children: screenList,
            ),

            // Bottom Nav Section
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: const Offset(0, 5),
                        ),
                    ]
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          for (int index = 0; index < 4; index++)
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        bottomNavList[index]['icon'] as IconData?,
                                        color: _currentIndex == index
                                            ? Theme.of(context).colorScheme.onPrimary
                                            : Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                                      ),
                                      Text(
                                        bottomNavList[index]['label'] as String,
                                        style: Theme.of(context).textTheme.bodyLarge
                                            ?.copyWith(
                                              color: _currentIndex == index
                                                  ? Theme.of(context).colorScheme.onPrimary
                                                  : Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                                            ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
