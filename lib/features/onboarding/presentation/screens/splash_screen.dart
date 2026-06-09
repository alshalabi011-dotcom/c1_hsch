import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Clean and minimal Entry Splash Screen.
/// Fade animation on app launch, then redirects to onboarding/welcome screen.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();

    // Smooth entry fade animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });

    // Auto-navigate to welcome/intro screen after 1.8 seconds
    _timer = Timer(const Duration(milliseconds: 1800), () {
      if (mounted) {
        context.go('/intro');
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.school,
                      size: 72,
                      color: AppColors.accent,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'C1 Hsch',
                      style: AppTextStyles.headingLarge.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Opacity(
                opacity: 0.5,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    'Academic Standard',
                    style: AppTextStyles.labelSmall.copyWith(
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
