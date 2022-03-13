import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nba/styles/app_colors.dart';
import 'package:nba/styles/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _finalTimer;
  double _nbaLogo = 0;
  double _appLogo = 0;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      setState(() {
        _nbaLogo = 1;
      });
    });
  }

  @override
  void dispose() {
    _finalTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Stack(
          children: [
            AnimatedOpacity(
              opacity: _nbaLogo,
              duration: const Duration(seconds: 1),
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/pt/b/b6/NBALogo.svg.png',
              ),
              onEnd: () {
                setState(() {
                  _nbaLogo = 0;
                  Timer(const Duration(seconds: 1), () {
                    setState(() {
                      _appLogo = 1;
                    });
                  });
                });
              },
            ),
            AnimatedOpacity(
              opacity: _appLogo,
              duration: const Duration(seconds: 1),
              child: Image.asset(
                AppImages.logo1,
                width: 100,
              ),
              onEnd: () {
                setState(() {
                  _appLogo = 0;
                });

                _finalTimer = Timer(const Duration(milliseconds: 1500), () {
                  Navigator.pushReplacementNamed(context, '/login');
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
