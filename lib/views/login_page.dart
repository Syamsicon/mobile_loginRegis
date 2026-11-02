import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Form(
              key: controller.loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Judul
                  Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.title,
                  ),
                  const SizedBox(height: 32),

                  // Field Nama
                  CustomTextField(
                    label: 'Nama',
                    hintText: 'Nama',
                    controller: controller.loginNameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Field Password
                  Obx(
                    () => CustomTextField(
                      label: 'Password',
                      hintText: 'Password',
                      controller: controller.loginPasswordController,
                      obscureText: controller.isPasswordHidden.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordHidden.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 20,
                          color: AppColors.textSecondary,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Tombol Login (Pill radius 50)
                  Obx(
                    () => CustomButton(
                      text: 'Login',
                      borderRadius: 50,
                      isLoading: controller.isLoading.value,
                      onPressed: controller.login,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Tombol Keluar (Pill radius 50)
                  CustomButton(
                    text: 'Keluar',
                    borderRadius: 50,
                    isOutlined: true,
                    onPressed: () => SystemNavigator.pop(),
                  ),
                  const SizedBox(height: 24),

                  // Link Daftar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Belum punya akun? ',
                        style: AppTextStyles.link.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.register),
                        child: Text(
                          'Daftar',
                          style: AppTextStyles.link.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

