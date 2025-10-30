import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/partner_model.dart';

class PartnerWithDineTimeVM extends GetxController {
  final PartnerWithDineTimeModel model;

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();
  final RxBool isSubmitting = false.obs;

  PartnerWithDineTimeVM(this.model);

  String? validateEmail(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return 'Please enter your email';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(s);
    if (!ok) return 'Enter a valid email';
    return null;
  }

  Future<void> submit() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    isSubmitting.value = true;
    await Future.delayed(const Duration(milliseconds: 900));
    isSubmitting.value = false;

    Get.snackbar(
      'Inquiry sent',
      'We’ll contact ${emailCtrl.text.trim()} about partnership opportunities.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    super.onClose();
  }
}
