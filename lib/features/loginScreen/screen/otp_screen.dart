import 'dart:async';
import 'package:billtrack/core/constant/app_colors.dart';
import 'package:billtrack/core/constant/app_pngs.dart';
import 'package:billtrack/core/constant/app_strings.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _otpControllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  
  int _secondsRemaining = 60; // 2:58
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _secondsRemaining = 60; // Reset timer to 2:58
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
        setState(() {}); // Rebuild to show Resend Code button
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Stack(
        children: [
          // Background decorative circles
          Positioned(top: -50, right: -50, child: _buildCircle()),
          Positioned(bottom: 150, left: -80, child: _buildCircle()),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Image.asset(AppImagesPng.billTrackLogo, height: 220),
                  const SizedBox(height: 30),

                  const Text(
                    AppStrings.otpHeading,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Enter the OTP sent to +91 ${widget.phoneNumber} to verify and access your account securely.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, color: Colors.black54, height: 1.5),
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    AppStrings.enterOtpLabel,
                    style: TextStyle(color: AppColors.orange, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),

                  // OTP Input Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) => _buildOtpBox(index)),
                  ),

                  const SizedBox(height: 30),

                  // Resend Section
                  Text(
                    AppStrings.resendText,
                    style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.7)),
                  ),
                  const SizedBox(height: 8),
                  _secondsRemaining > 0
                      ? Text(
                          "${AppStrings.resendTimerPrefix}${_formatTime(_secondsRemaining)}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.orange,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      : InkWell(
                          onTap: _startTimer,
                          child: const Text(
                            "Resend Code",
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.orange,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),

                  const SizedBox(height: 40),

                  // Verify Button
                  SizedBox(
                    width: 220,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        // Logic after verification
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: const Text(
                        AppStrings.verifyOtp,
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.orange.withOpacity(0.5)),
      ),
      child: Center(
        child: TextField(
          controller: _otpControllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.orange),
          decoration: const InputDecoration(
            counterText: "",
            border: InputBorder.none,
          ),
          onChanged: (value) {
            if (value.isNotEmpty && index < 3) {
              _focusNodes[index + 1].requestFocus();
            } else if (value.isEmpty && index > 0) {
              _focusNodes[index - 1].requestFocus();
            }
          },
        ),
      ),
    );
  }

  Widget _buildCircle() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.orange.withOpacity(0.06),
        shape: BoxShape.circle,
      ),
    );
  }
}
