import 'package:billtrack/core/constant/app_colors.dart';
import 'package:billtrack/core/constant/app_pngs.dart';
import 'package:billtrack/core/constant/app_svgs.dart';
import 'package:billtrack/widgets/custom_text_field_widget.dart';
import 'package:billtrack/features/registrationScreen/screen/registration_screen_second_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();

  @override
  void dispose() {
    ownerNameController.dispose();
    phoneController.dispose();
    whatsappController.dispose();
    emailController.dispose();
    pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // Background SVG
          Positioned.fill(
            child: SvgPicture.asset(
              AppSvgs.background,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Image.asset(
                    AppImagesPng.logo,
                    height: 150,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Set Up Your Business',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomTextFieldWidget(
                    controller: ownerNameController,
                    hintText: 'Owner name',
                  ),
                  const CustomTextFieldWidget(
                    hintText: 'GST Number(Optional)',
                    suffixIcon: Icon(Icons.check_circle, color: Colors.green, size: 20),
                  ),
                  CustomTextFieldWidget(
                    controller: whatsappController,
                    hintText: 'Whatsapp number',
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    borderColor: Colors.red,
                    suffixIcon: const Icon(Icons.cancel, color: Colors.red, size: 20),
                  ),
                  CustomTextFieldWidget(
                    controller: emailController,
                    hintText: 'Email address',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const CustomTextFieldWidget(
                    hintText: 'Business type',
                    isDropDown: true,
                    dropDownItems: ['Retail', 'Wholesale', 'Service'],
                  ),
                  const CustomTextFieldWidget(
                    hintText: 'Choose State',
                    isDropDown: true,
                    dropDownItems: ['West Bengal', 'Delhi', 'Mumbai'],
                  ),
                  CustomTextFieldWidget(
                    controller: pinCodeController,
                    hintText: 'Pin code',
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width:150,
                    height: 37,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegistrationScreenSecondStep(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'CONTINUE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
