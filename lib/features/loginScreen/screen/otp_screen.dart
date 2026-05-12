import 'dart:async';
import 'dart:math'; // Added for random OTP
import 'package:billtrack/core/constant/app_colors.dart';
import 'package:billtrack/core/constant/app_pngs.dart';
import 'package:billtrack/core/constant/app_strings.dart';
import 'package:billtrack/features/registrationScreen/screen/registration_screen_first_step.dart';
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
  
  int _secondsRemaining = 60; 
  Timer? _timer;
  String _currentOtp = ""; // Changed to dynamic

  @override
  void initState() {
    super.initState();
    _startTimer();
    _simulateOtpReceive(); // Auto-fill simulation on start
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _secondsRemaining = 60;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
        setState(() {}); 
      }
    });
  }

  // Simulate OTP receiving and auto-filling with a dynamic number
  void _simulateOtpReceive() {
    // Clear previous OTP first
    for (var controller in _otpControllers) {
      controller.clear();
    }
    
    // Generate a random 4-digit OTP
    _currentOtp = (Random().nextInt(9000) + 1000).toString();
    
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        for (int i = 0; i < 4; i++) {
          _otpControllers[i].text = _currentOtp[i];
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("OTP sent to +91 ${widget.phoneNumber} and auto-filled: $_currentOtp"),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  void _verifyOtp() {
    String enteredOtp = _otpControllers.map((e) => e.text).join();
    if (enteredOtp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter full 4-digit OTP"),
          backgroundColor: Colors.red,
        ),
      );
    } else if (enteredOtp == _currentOtp) {
      // Success - Navigate to Registration
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const RegistrationScreen()),
        (route) => false,
      );
    } else {
      // Wrong OTP
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid OTP! Please try again."),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                          style: const TextStyle(fontSize: 14, color: AppColors.orange, fontWeight: FontWeight.bold),
                        )
                      : InkWell(
                          onTap: () {
                            _startTimer();
                            _simulateOtpReceive();
                          },
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
                      onPressed: _verifyOtp,
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
