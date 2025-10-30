import 'package:canada/Widgets/custom_text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Constants/app_colors.dart';
import '../Constants/app_images.dart' as app_images;
import '../Models/sign_up_model.dart';
import '../view_model/sign_up_view_model.dart';
import 'login_view.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  static const _font = 'Helvetica';
  static const _bold = 'Helvetica-Bold';

  @override
  Widget build(BuildContext context) {
    final vm = Get.put(SignUpViewModel(SignUpModel(
      heroAsset:  app_images.app_images.signup_here,
      googleIcon: app_images.app_images.ic_google,
      appleIcon:  app_images.app_images.ic_apple,
      facebookIcon: app_images.app_images.ic_facebook,
      eyeOnIcon:  app_images.app_images.ic_eye_on,
    )));

    Widget iconAsset(String path, {double w = 23, double h = 23, Color? color}) {
      if (path.toLowerCase().endsWith('.svg')) {
        return SvgPicture.asset(
          path, width: w, height: h,
          colorFilter: color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
        );
      }
      return Image.asset(path, width: w, height: h, color: color);
    }



    // ✅ Decoration used for all three fields (email/password/confirm)
    //    Supports suffix icons and the custom error outline + hidden caption.
    InputDecoration fieldBoxExact(String hint, {Widget? suffix}) {
      return InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: _font,
          fontSize: 14,
          color: AppColors.gray200,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        filled: true,
        fillColor: const Color(0xFFE9E9EB), // exact grey fill
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1),
        ),
        errorStyle: const TextStyle(fontSize: 0, height: 0), // hide default caption
        suffixIcon: suffix == null ? null : Padding(
          padding: const EdgeInsets.only(right: 8),
          child: suffix,
        ),
        suffixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        constraints: const BoxConstraints(minHeight: 44, maxHeight: 44),
      );
    }

    Widget title(String t) => Text(
      t,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: _bold,
        fontWeight: FontWeight.w700,
        fontSize: 26,
        color: AppColors.black,
      ),
    );

    Widget formLabel(String t) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        t,
        style: const TextStyle(
          fontFamily: _font,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: AppColors.black,
        ),
      ),
    );

    Widget social(String path) => Container(
      width: 55, height: 55,
      decoration: const BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Color(0x1A000000), blurRadius: 16, offset: Offset(0, 8))],
      ),
      child: Center(child: iconAsset(path)),
    );

    // Small red error row under fields (driven by vm.*Error)
    Widget errorRow(String msg) => Padding(
      padding: const EdgeInsets.only(top: 6, left: 2),
      child: Row(
        children: [
          const Icon(Icons.error_outline, size: 16, color: Color(0xFFD32F2F)),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              msg,
              style: const TextStyle(
                fontFamily: _font,
                fontSize: 12,
                height: 1.2,
                color: Color(0xFFD32F2F),
              ),
            ),
          ),
        ],
      ),
    );

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [Color(0xFFF7F7F7), AppColors.white],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              children: [
                const SizedBox(height: 6),
                Image.asset(vm.model.heroAsset, height: 240, fit: BoxFit.contain),
                title('Sign Up'),
                const SizedBox(height: 18),


                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(color: Color(0x1A000000), blurRadius: 22, offset: Offset(0, 10)),
                    ],
                  ),
                    child: Form(
                      key: vm.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Email
                          formLabel('Email Address'),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextInputWidget(
                                  controller: vm.emailCtrl,
                                  validator: (vv) {
                                    if (vv == null || vv.isEmpty) return "Enter Required field";
                                    return null;
                                  },
                                  hintText: 'example@gmail.com',
                                  // rounded, NO visible border (matches screenshot)
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide.none,
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                Obx(() => vm.emailError.value.isEmpty
                                    ? const SizedBox.shrink()
                                    : errorRow(vm.emailError.value)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Password
                          formLabel('Password'),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => CustomTextInputWidget(
                                  controller: vm.passCtrl,
                                  validator: vm.validatePassword,
                                  obscureText: vm.obscurePass.value,
                                  hintText: '********',
                                  suffixIcon: IconButton(
                                    padding: EdgeInsets.zero,
                                    splashRadius: 18,
                                    onPressed: vm.obscurePass.toggle,
                                    icon: Icon(
                                      vm.obscurePass.value ? Icons.visibility : Icons.visibility_off,
                                      size: 20,
                                      color: AppColors.greyshade3,
                                    ),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide.none,
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide.none,
                                  ),
                                )),
                                Obx(() => vm.passError.value.isEmpty
                                    ? const SizedBox.shrink()
                                    : errorRow(vm.passError.value)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Confirm Password
                          formLabel('Confirm Password'),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => CustomTextInputWidget(
                                  controller: vm.confirmCtrl,
                                  validator: vm.validateConfirm,
                                  obscureText: vm.obscureConfirm.value,
                                  hintText: '********',
                                  suffixIcon: IconButton(
                                    padding: EdgeInsets.zero,
                                    splashRadius: 18,
                                    onPressed: vm.obscureConfirm.toggle,
                                    icon: Icon(
                                      vm.obscureConfirm.value ? Icons.visibility : Icons.visibility_off,
                                      size: 20,
                                      color: AppColors.greyshade3,
                                    ),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide.none,
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide.none,
                                  ),
                                )),
                                Obx(() => vm.confirmError.value.isEmpty
                                    ? const SizedBox.shrink()
                                    : errorRow(vm.confirmError.value)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )


                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontFamily: _font,
                        fontSize: 12,
                        color: AppColors.black,
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Get.to(() => const LoginView(), transition: Transition.cupertino);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                        child: Text(
                          'Sign in here',
                          style: TextStyle(
                            fontFamily: 'Helvetica-Bold',
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    social(vm.model.googleIcon),
                    const SizedBox(width: 18),
                    social(vm.model.appleIcon),
                    const SizedBox(width: 18),
                    social(vm.model.facebookIcon),
                  ],
                ),

                const SizedBox(height: 20),
                SafeArea(
                  top: false,
                  minimum: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                  child: SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: Obx(() => ElevatedButton(
                      onPressed: vm.isLoading.value ? null : vm.submit,
                      style: ButtonStyle(
                        backgroundColor: const WidgetStatePropertyAll(AppColors.black),
                        foregroundColor: const WidgetStatePropertyAll(Colors.white),
                        elevation: const WidgetStatePropertyAll(0),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
                      child: vm.isLoading.value
                          ? const SizedBox(
                        width: 20, height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                          : const Text(
                        'Sign up',
                        style: TextStyle(fontFamily: _bold, fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
