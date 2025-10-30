import 'package:canada/Constants/main_nav_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Constants/app_colors.dart';
import '../Constants/app_images.dart';
import '../Models/login_model.dart';
import '../Routes/app_routes.dart';
import '../view_model/login_view_model.dart';
import 'forgot_password_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const _font = 'Helvetica';
  static const _bold = 'Helvetica-Bold';

  // heights are fine to keep fixed
  static const double _ctaH = 48;

  @override
  Widget build(BuildContext context) {
    final vm = Get.put(LoginViewModel(LoginModel(
      logo:          app_images.dit_logo2,
      facebookIcon:  app_images.ic_facebook,
      instagramIcon: app_images.instagram_icon,
    )));

    // ---------- Responsive sizing ----------
    final size = MediaQuery.of(context).size;
    final double w = size.width;

    // gutters & max content width by breakpoint
    final double horizontalPad = w >= 1200 ? 32 : w >= 840 ? 24 : 16;
    final double cardMaxWidth  = w >= 1200 ? 520 : w >= 840 ? 460 : 420;

    // label above each field
    Widget _formLabel(String t) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        t,
        style: const TextStyle(
          fontFamily: _font,
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: AppColors.greyshade1,
        ),
      ),
    );

    // white input with subtle border; keeps red error border without moving layout
    InputDecoration _fieldBox(String hint, {Widget? suffix}) {
      return InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: _font,
          fontSize: 14,
          color: AppColors.gray200,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE6E6E6), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE6E6E6), width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1),
        ),
        errorStyle: const TextStyle(fontSize: 0, height: 0),
        suffixIcon: suffix == null
            ? null
            : Padding(padding: const EdgeInsets.only(right: 8), child: suffix),
        suffixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        constraints: const BoxConstraints(minHeight: 44, maxHeight: 44),
      );
    }

    Widget _orDivider() => Row(
      children: const [
        Expanded(child: Divider(color: Color(0xFFE6E6E6), thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'OR',
            style: TextStyle(
              fontFamily: _bold,
              fontSize: 12,
              color: AppColors.gray500,
            ),
          ),
        ),
        Expanded(child: Divider(color: Color(0xFFE6E6E6), thickness: 1)),
      ],
    );

    // helper: SVG/PNG
    Widget svgOrPng(String path, {double w = 18, double h = 18, Color? color}) {
      if (path.toLowerCase().endsWith('.svg')) {
        return SvgPicture.asset(
          path, width: w, height: h,
          colorFilter: color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
        );
      }
      return Image.asset(path, width: w, height: h, color: color);
    }

    // CTA login (full width inside the constrained card)
    Widget loginButton() => SizedBox(
      height: _ctaH,
      width: double.infinity,
      child: Obx(() => ElevatedButton(
        onPressed: vm.isLoading.value ? null : () => Get.offAll(MainNavView()),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: vm.isLoading.value
            ? const SizedBox(
            width: 20, height: 20,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : const Text('Log In',
            style: TextStyle(fontFamily: _bold, fontWeight: FontWeight.w700, fontSize: 14)),
      )),
    );

    // CTA restaurants
    Widget restaurantsButton() => SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Get.toNamed(AppRoutes.partner),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: const Text(
          'Click here',
          style: TextStyle(fontFamily: _bold, fontWeight: FontWeight.w700, fontSize: 12),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(horizontalPad, 24, horizontalPad, 16),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: cardMaxWidth),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Image.asset(vm.model.logo, height: 180, fit: BoxFit.contain),
                  const SizedBox(height: 12),

                  // card stretches to maxWidth and stays centered
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE6E6E6), width: 1),
                      boxShadow: const [
                        BoxShadow(color: Color(0x14000000), blurRadius: 16, offset: Offset(0, 6)),
                      ],
                    ),
                    child: Form(
                      key: vm.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 6),

                          // Facebook
                          SizedBox(
                            height: 40,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: const Color(0xFF1877F2),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              icon: svgOrPng(vm.model.facebookIcon, w: 18, h: 18, color: Colors.white),
                              label: const Text(
                                'Continue with Facebook',
                                style: TextStyle(fontFamily: _bold, fontWeight: FontWeight.w700, fontSize: 12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Instagram
                          SizedBox(
                            height: 40,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft, end: Alignment.centerRight,
                                  colors: [Color(0xFF833AB4), Color(0xFFF77737)],
                                ),
                                boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 4))],
                              ),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    svgOrPng(vm.model.instagramIcon, w: 18, h: 18, color: Colors.white),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Continue with Instagram',
                                      style: TextStyle(
                                        fontFamily: _bold,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 14),
                          _orDivider(),
                          const SizedBox(height: 14),

                          // Email
                          Align(alignment: Alignment.centerLeft, child: _formLabel('Email')),
                          TextFormField(
                            controller: vm.emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            validator: vm.validateEmail,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            style: const TextStyle(fontFamily: _font, fontSize: 14, color: AppColors.black_text),
                            decoration: _fieldBox('Enter your email'),
                          ),

                          const SizedBox(height: 12),

                          // Password
                          Align(alignment: Alignment.centerLeft, child: _formLabel('Password')),
                          Obx(() => TextFormField(
                            controller: vm.passCtrl,
                            obscureText: vm.obscurePass.value,
                            validator: vm.validatePassword,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            style: const TextStyle(fontFamily: _font, fontSize: 14, color: AppColors.black_text),
                            decoration: _fieldBox(
                              'Enter your password',
                              suffix: IconButton(
                                padding: EdgeInsets.zero,
                                splashRadius: 18,
                                onPressed: vm.obscurePass.toggle,
                                icon: Icon(
                                  vm.obscurePass.value ? Icons.visibility : Icons.visibility_off,
                                  size: 20, color: AppColors.greyshade3,
                                ),
                              ),
                            ),
                          )),

                          const SizedBox(height: 6),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () => Get.to(
                                    () => const ForgotPasswordView(),
                                transition: Transition.cupertino,
                              ),
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(fontFamily: _bold, fontSize: 12, color: AppColors.black),
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          // Log In
                          loginButton(),

                          const SizedBox(height: 12),
                          const Divider(color: Color(0xFFE6E6E6), thickness: 1),

                          // Sign up hint
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account? ",
                                  style: TextStyle(fontFamily: _font, fontSize: 12, color: AppColors.greyshade1),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: vm.toSignUp,
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                                    child: Text(
                                      'Sign up',
                                      style: TextStyle(
                                        fontFamily: _bold,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),

                          const Text(
                            'Restaurants?',
                            style: TextStyle(fontFamily: _font, fontSize: 12, color: AppColors.greyshade1),
                          ),
                          const SizedBox(height: 6),
                          restaurantsButton(),
                        ],
                      ),
                    ),
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
