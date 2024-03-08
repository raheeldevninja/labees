import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/images/images.dart';
import 'package:labees/core/util/shared_pref.dart';
import 'package:labees/features/chooese_language/chooese_language_screen.dart';
import 'package:labees/features/home/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';

/*
*  Date 12 - Oct-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: SplashScreen
*/

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.9, curve: Curves.easeOut),
      ),
    );

    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();

    _navigateToChooseLangScreen();

    _requestNotificationsPermission();
  }

  _requestNotificationsPermission() async {
    PermissionStatus status = await Permission.notification.status;
    if (!status.isGranted) {
      Permission.notification.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.bgImage),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                color: const Color(0xFF00354E).withOpacity(0.77),
                width: double.maxFinite,
                height: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeTransition(
                      opacity: _opacityAnimation,
                      child: Hero(
                        tag: 'labeesAr',
                        child: SvgPicture.asset(
                          Images.labeesAr,
                        ),
                      ),
                    ),
                    FadeTransition(
                      opacity: _opacityAnimation,
                      child: Hero(
                        tag: 'labeesEn',
                        child: SvgPicture.asset(
                          Images.labeesEn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _navigateToChooseLangScreen() {
    Future.delayed(const Duration(seconds: 4), () async {
      if (await SharedPref.isChooseLanguageScreenShown()) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ChooseLanguageScreen(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
