import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim_names/consts/app_colors.dart';
import 'package:page_transition/page_transition.dart';
import '../Home Screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AnimatedSplashScreen(
          backgroundColor: AppColors.mainColor,
          splashIconSize: 200,
          pageTransitionType: PageTransitionType.bottomToTop,
          duration: 1600,
          splash: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Muslim's Name",
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w800,
                  color: CupertinoColors.white,
                  fontSize: 26,
                ),
              ),
            ],
          ),
          nextScreen: const HomeScreen(),
      ),
    );
  }
}
