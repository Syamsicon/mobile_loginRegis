import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  // Form Keys
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  // Login Controllers (Field: Nama dan Password)
  final loginNameController = TextEditingController();
  final loginPasswordController = TextEditingController();

  // Getter for backwards compatibility if needed
  TextEditingController get loginEmailController => loginNameController;

  // Register Controllers
  final registerNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();

  // Observables
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  void login() async {
    if (loginFormKey.currentState?.validate() ?? false) {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 500));
      isLoading.value = false;
      Get.snackbar(
        'Login',
        'Berhasil masuk sebagai ${loginNameController.text}',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
    }
  }

  void register() async {
    if (registerFormKey.currentState?.validate() ?? false) {
      if (registerPasswordController.text != registerConfirmPasswordController.text) {
        Get.snackbar(
          'Error',
          'Konfirmasi password tidak cocok',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
        );
        return;
      }

      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 500));
      isLoading.value = false;
      Get.snackbar(
        'Registrasi',
        'Akun berhasil dibuat',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      Get.offNamed(AppRoutes.login);
    }
  }

  void exitApp() {
    SystemNavigator.pop();
  }

  void goToRegister() {
    Get.toNamed(AppRoutes.register);
  }

  void goToLogin() {
    Get.back();
  }

  @override
  void onClose() {
    loginNameController.dispose();
    loginPasswordController.dispose();
    registerNameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    super.onClose();
  }
}

