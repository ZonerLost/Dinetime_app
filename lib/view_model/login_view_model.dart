import 'package:canada/Constants/main_nav_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/login_model.dart';
import '../Routes/app_routes.dart';

class LoginViewModel extends GetxController {
  final LoginModel model;
  LoginViewModel(this.model);

  final formKey = GlobalKey<FormState>();
  late final TextEditingController emailCtrl;
  late final TextEditingController passCtrl;

  final obscurePass = true.obs;
  final isLoading   = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailCtrl = TextEditingController();
    passCtrl  = TextEditingController();
  }

  String? validateEmail(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return 'Email is required';
    final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(s);
    if (!ok) return 'Enter a valid email';
    return null;
  }

  String? validatePassword(String? v) {
    final s = (v ?? '');
    if (s.isEmpty) return 'Password is required';
    if (s.length < 6) return 'Minimum 6 characters';
    return null;
  }

  Future<void> submit() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    isLoading.value = true;
    try {
      // TODO: call your login API
      await Future.delayed(const Duration(milliseconds: 700));
      Get.offAll(() => MainNavView()); // your landing route
    } finally {
      isLoading.value = false;
    }
  }

  void toSignUp() => Get.toNamed(AppRoutes.signUp);
  void toRestaurants() {
    // TODO: route to partner/restaurant flow
    // Get.toNamed(AppRoutes.restaurants);
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.onClose();
  }
}
