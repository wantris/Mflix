import 'package:flutter/material.dart';
import 'widgets/app_bar.dart';
import 'pages/home_screen.dart';
import 'pages/favourite_screen.dart';
import 'pages/profile_screen.dart';

class MainScreen extends StatefulWidget {

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: UpperAppBar(appBar: AppBar()),
        bottomNavigationBar: BaseBottomNavBar(
          pageController: _pageController,
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
            });
          },
          children: const [
            HomeScreen(),
            FavouriteScreen(),
            ProfileScreen(),
          ],
        ),
      );
  }
}