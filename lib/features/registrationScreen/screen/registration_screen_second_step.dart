import 'dart:io';

import 'package:billtrack/core/constant/app_colors.dart';
import 'package:billtrack/core/constant/app_pngs.dart';
import 'package:billtrack/core/constant/app_svgs.dart';
import 'package:billtrack/widgets/custom_bottom_navigationbar.dart';
import 'package:billtrack/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class RegistrationScreenSecondStep extends StatefulWidget {
  const RegistrationScreenSecondStep({super.key});

  @override
  State<RegistrationScreenSecondStep> createState() => _RegistrationScreenSecondStepState();
}

class _RegistrationScreenSecondStepState extends State<RegistrationScreenSecondStep> {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController gstNumberController = TextEditingController();
  final TextEditingController businessAddressController = TextEditingController();
  File? _image;
  // final ImagePicker _picker = ImagePicker();

  // Future<void> _pickImage() async {
  //   final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });
  //   }
  // }

  @override
  void dispose() {
    businessNameController.dispose();
    gstNumberController.dispose();
    businessAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  const SizedBox(height: 20),
                  // Logo Preview Circle
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.orange, width: 1),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: ClipOval(
                      child: _image != null
                          ? Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              AppImagesPng.logo, // Default logo instead of missing placeholder
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.business, size: 50, color: Colors.grey),
                            ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Upload Logo Button
                  SizedBox(
                    height: 35,
                    child: OutlinedButton.icon(
                       onPressed: (){},
                      //  onPressed: _pickImage,
                      icon: const Icon(Icons.file_upload_outlined, size: 18, color: AppColors.orange),
                      label: const Text(
                        'Upload Logo',
                        style: TextStyle(color: AppColors.orange, fontSize: 14),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.orange.withOpacity(0.1),
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomTextFieldWidget(
                    controller: businessNameController,
                    hintText: 'Business name',
                    borderColor: AppColors.orange,
                    suffixIcon: const Icon(Icons.check_circle, color: AppColors.orange, size: 20),
                  ),
                  CustomTextFieldWidget(
                    controller: gstNumberController,
                    hintText: 'GST number',
                  ),
                  CustomTextFieldWidget(
                    controller: businessAddressController,
                    hintText: 'Business address',
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 135,
                    height: 37,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CustomBottomNavigationBar(),
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
                        'PROCEED',
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
