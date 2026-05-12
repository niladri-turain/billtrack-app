import 'package:billtrack/core/constant/app_colors.dart';
import 'package:billtrack/core/constant/app_pngs.dart';
import 'package:billtrack/features/loginScreen/screen/login_screen.dart';
import 'package:flutter/material.dart';

import '../registrationScreen/screen/registration_screen_first_step.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _firstLogoController;
  late AnimationController _secondLogoController;

  late Animation<Offset> _firstLogoEntry;
  late Animation<Offset> _firstLogoShift;
  late Animation<Offset> _secondLogoEntry;
  late Animation<double> _secondLogoOpacity;

  bool _showOrangeScreen = false;

  @override
  void initState() {
    super.initState();

    // Slower animation duration: 1600ms
    _firstLogoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _secondLogoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    // 1. B falls from top exactly to the center
    _firstLogoEntry = Tween<Offset>(
      begin: const Offset(0, -10),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _firstLogoController,
      curve: Curves.easeOutBack,
    ));

    // 2. B shifts left to balance the full logo in center
    _firstLogoShift = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.2, 0), // Shifted to make the group centered
    ).animate(CurvedAnimation(
      parent: _secondLogoController,
      curve: Curves.easeInOutQuart,
    ));

    // 3. illTrack rises from bottom to its position (right side of center)
    _secondLogoEntry = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: const Offset(0.3, 0), // Adjusted to keep the full logo visually centered
    ).animate(CurvedAnimation(
      parent: _secondLogoController,
      curve: Curves.easeOutBack,
    ));

    _secondLogoOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _secondLogoController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeInCubic),
    ));

    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 600));

    // 1. B falls to center
    if (mounted) _firstLogoController.forward();
    await Future.delayed(const Duration(milliseconds: 2000));

    // 2. illTrack rises and B shifts left
    if (mounted) _secondLogoController.forward();
    await Future.delayed(const Duration(milliseconds: 3000));

    // 3. Switch to orange screen
    if (mounted) {
      setState(() {
        _showOrangeScreen = true;
      });
    }

    // 4. Navigate to Registration
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _firstLogoController.dispose();
    _secondLogoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _showOrangeScreen ? AppColors.orange : Colors.white,
      body: Center(
        child: _showOrangeScreen
            ? const SizedBox()
            : Stack(
                alignment: Alignment.center,
                children: [
                  // First Logo (B) - Center Entry then Left Shift
                  SlideTransition(
                    position: _firstLogoEntry,
                    child: SlideTransition(
                      position: _firstLogoShift,
                      child: Image.asset(
                        AppImagesPng.firstLogo,
                        width: 40,
                      ),
                    ),
                  ),
                 
                  // Second Logo (illTrack) - Bottom Entry to balanced right position
                  FadeTransition(
                    opacity: _secondLogoOpacity,
                    child: SlideTransition(
                      position: _secondLogoEntry,
                      child: Image.asset(
                        AppImagesPng.secondLogo,
                        height: 25,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
