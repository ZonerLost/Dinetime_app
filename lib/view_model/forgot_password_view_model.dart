import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/forgot_password_model.dart';

class ForgotPasswordVM extends GetxController {
  final ForgotPasswordModel model;
  ForgotPasswordVM(this.model);

  final emailCtrl = TextEditingController();

  final isLoading = false.obs;
  final isSent = false
      .obs; // false = "Forgot Password" form, true = "Password Reset" confirmation

  String? validateEmail(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return 'Email is required';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(s);
    if (!ok) return 'Enter a valid email';
    return null;
  }

  Future<void> send(FormState? form) async {
    if (!(form?.validate() ?? false)) return;
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 500)); // mock request
    isLoading.value = false;
    isSent.value = true; // flip to "Password Reset" state
  }

  // on the "Verify" button—stub for your next step
  void verify() {
    // TODO: deep link handler / open mail app / navigate
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    super.onClose();
  }
}
