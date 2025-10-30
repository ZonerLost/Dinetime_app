import 'package:canada/Routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/sign_up_model.dart';

class SignUpViewModel extends GetxController {
  final SignUpModel model;
  SignUpViewModel(this.model);

  // Form
  final formKey = GlobalKey<FormState>();

  // Controllers
  late final TextEditingController emailCtrl;
  late final TextEditingController passCtrl;
  late final TextEditingController confirmCtrl;

  // UI state
  final obscurePass = true.obs;
  final obscureConfirm = true.obs;
  final isLoading = false.obs;

  // Reactive error lines (for the compact row under each field)
  final emailError   = ''.obs;
  final passError    = ''.obs;
  final confirmError = ''.obs;

  // ---------------- Validators (return a message so the red outline shows) ---
  String? validateEmail(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return _setAndReturn(emailError, 'Email is required');
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(s);
    if (!ok) return _setAndReturn(emailError, 'Enter a valid email');
    return _clearAndReturnNull(emailError);
  }

  String? validatePassword(String? v) {
    final s = (v ?? '');
    if (s.isEmpty) return _setAndReturn(passError, 'Password is required');
    if (s.length < 8) return _setAndReturn(passError, 'At least 8 characters');
    return _clearAndReturnNull(passError);
  }

  String? validateConfirm(String? v) {
    final s = (v ?? '');
    if (s.isEmpty) return _setAndReturn(confirmError, 'Confirm your password');
    if (s != passCtrl.text) return _setAndReturn(confirmError, 'Passwords do not match');
    return _clearAndReturnNull(confirmError);
  }

  // ---------------- Actions ---------------------------------------------------
  Future<void> submit() async {
    FocusManager.instance.primaryFocus?.unfocus();

    // Force validation so borders + error rows update together
    final ok = formKey.currentState?.validate() ?? false;
    if (!ok) return;

    isLoading.value = true;
    try {
      // // emailCtrl.text, passCtrl.text
      // await Future.delayed(const Duration(milliseconds: 600));
      Get.offAllNamed(AppRoutes.setupProfile);
    } finally {
      isLoading.value = false;
    }
  }

  void goToSignIn() {
    // Implement navigation however you prefer; two common options:
    // Get.to(() => const LoginView(), transition: Transition.cupertino);
    // or with routes:
    // Get.toNamed(AppRoutes.login);
  }

  // ---------------- Lifecycle -------------------------------------------------
  @override
  void onInit() {
    super.onInit();
    emailCtrl   = TextEditingController();
    passCtrl    = TextEditingController();
    confirmCtrl = TextEditingController();

    // Live-validate and mirror messages into RxStrings (keeps UI in sync)
    emailCtrl.addListener(() {
      final _ = validateEmail(emailCtrl.text); // return used to set Rx error
      // No-op with `_` – side-effect updates emailError
    });

    passCtrl.addListener(() {
      final _ = validatePassword(passCtrl.text);
      // Also re-check confirm when password changes
      final __ = validateConfirm(confirmCtrl.text);
    });

    confirmCtrl.addListener(() {
      final _ = validateConfirm(confirmCtrl.text);
    });
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    confirmCtrl.dispose();
    super.onClose();
  }

  // ---------------- Helpers ---------------------------------------------------
  String _setAndReturn(RxString holder, String msg) {
    holder.value = msg;
    return msg;
  }

  String? _clearAndReturnNull(RxString holder) {
    holder.value = '';
    return null;
  }
}
