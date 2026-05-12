import 'package:billtrack/core/constant/app_colors.dart';
import 'package:billtrack/core/constant/app_pngs.dart';
import 'package:billtrack/core/constant/app_strings.dart';
import 'package:billtrack/features/loginScreen/screen/otp_screen.dart';
import 'package:billtrack/features/loginScreen/widgets/login_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Stack(
    children: [
      Positioned(top: -50, right: -50, child: _buildCircle()),
      Positioned(bottom: -30, left: -80, child: _buildCircle()),
      SafeArea(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              // Top Illustration
              // Assuming billTrackLogo or a specific illustration exists.
              // If not, using a placeholder image for the illustration.
              Center(
                child: Image.asset(
                  AppImagesPng.billTrackLogo, // Replace with actual illustration asset if named differently
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 30),

              // Heading
              const Text(
                AppStrings.loginHeading,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 12),

              // Subheading
              const Text(
                AppStrings.loginSubHeading,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 40),

              // Phone Number Label
              const Align(
                alignment: Alignment.center,
                child: Text(
                  AppStrings.phoneNumberLabel,
                  style: TextStyle(
                    color: AppColors.orange,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Custom Text Field Widget
              LoginTextField(controller: _phoneController),

              const SizedBox(height: 30),

              // GET OTP Button
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtpScreen(
                          phoneNumber: _phoneController.text,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    AppStrings.getOtp,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ],
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
