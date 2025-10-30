import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';

import '../Constants/app_colors.dart';
import '../Constants/app_images.dart' as app_images;
import '../Models/forgot_password_model.dart';
import '../Widgets/custom_text_widget.dart';
import '../view_model/forgot_password_view_model.dart';



class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.put(
      ForgotPasswordVM(
        ForgotPasswordModel(heroAsset: app_images.app_images.signup_here),
      ),
    );

    // --- responsive sizing ---
    final w = MediaQuery.of(context).size.width;
    final horizontalPad = w >= 1200 ? 32.0 : w >= 840 ? 24.0 : 16.0;
    final cardMaxWidth  = w >= 1200 ? 520.0 : w >= 840 ? 460.0 : 420.0;
    final heroMaxWidth  = cardMaxWidth;

    // White card container
    Widget formCard(Widget child) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x1A000000), blurRadius: 20, offset: Offset(0, 8)),
        ],
      ),
      child: child,
    );

    // Bottom fixed CTA
    Widget bottomBar({
      required String label,
      required VoidCallback onTap,
      bool loading = false,
    }) {
      return SafeArea(
        top: false,
        minimum: EdgeInsets.fromLTRB(horizontalPad, 0, horizontalPad, 22),
        child: SizedBox(
          height: 48,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: loading ? null : onTap,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
            child: loading
                ? const SizedBox(
              width: 20, height: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            )
                : Text(
              label,
              style: const TextStyle(
                fontFamily: kBoldFont,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF7F7F7), Colors.white],
        ),
      ),
      child: Obx(() {
        final sent = vm.isSent.value;

        return Scaffold(
          backgroundColor: Colors.transparent,

          bottomNavigationBar: sent
              ? bottomBar(label: 'Verify', onTap: vm.verify)
              : bottomBar(label: 'Send', onTap: vm.send, loading: vm.isLoading.value),

          body: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(horizontalPad, 16, horizontalPad, 0),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: cardMaxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 6),

                      // Hero
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: heroMaxWidth),
                        child: Image.asset(
                          vm.model.heroAsset,
                          height: 240,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Title
                      headingText(sent ? 'Password Reset' : 'Forgot Password',
                          size: 26, color: AppColors.black, align: TextAlign.center),
                      const SizedBox(height: 16),

                      // Content
                      if (!sent)
                        formCard(
                          Form(
                            key: vm.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                formLabel('Email Address',
                                    size: 12, color: AppColors.black, weight: FontWeight.w400),
                                const SizedBox(height: 6),
                                TextFormField(
                                  controller: vm.emailCtrl,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: vm.validateEmail,
                                  style: const TextStyle(
                                    fontFamily: kFontFamily,
                                    fontSize: 14,
                                    color: AppColors.black,
                                  ),
                                  // ⬇️ use your shared fieldDecoration
                                  decoration: fieldDecoration(
                                    'example@gmail.com',
                                    radius: 4,
                                    fill: const Color(0xFFE9E9EB),
                                    content: const EdgeInsets.fromLTRB(16, 12, 8, 12),
                                    // keep subtle/hidden borders like your previous version:
                                    borderColor: Colors.transparent,
                                    focusedColor: Colors.transparent,
                                    errorColor: const Color(0xFFD32F2F),
                                    // hide default caption (you can show custom rows if needed)
                                    errorStyle: const TextStyle(fontSize: 0, height: 0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              bodyText(
                                'You have submitted a password change request.',
                                size: 14,
                                color: AppColors.black,
                                height: 24 / 14,
                                align: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontFamily: kFontFamily,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    height: 24 / 14,
                                    letterSpacing: 0,
                                    color: AppColors.black,
                                  ),
                                  children: [
                                    const TextSpan(text: 'Please check your '),
                                    const TextSpan(
                                      text: 'email',
                                      style: TextStyle(fontWeight: FontWeight.w700),
                                    ),
                                    const TextSpan(text: ' — the link has\nbeen sent '),
                                    TextSpan(
                                      text: 'Click here',
                                      style: const TextStyle(fontWeight: FontWeight.w700),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // TODO: open mail app or deep-link
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
