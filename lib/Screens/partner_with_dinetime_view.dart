// lib/Views/partner_with_dinetime_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constants/app_colors.dart';
import '../Models/partner_model.dart';
import '../view_model/partner_with_dinetime_view_model.dart';

class PartnerWithDineTimeView extends StatelessWidget {
  PartnerWithDineTimeView({super.key});

  final _formKey = GlobalKey<FormState>();

  static const _font = 'Helvetica';
  static const _bold = 'Helvetica-Bold';


  // ---- atoms

  Widget _iconChip(IconData icon) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE6E6E6)),
      ),
      child: Icon(icon, size: 16, color: AppColors.black),
    );
  }

  Widget _innerCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE6E6E6)),
        boxShadow: const [
          BoxShadow(color: Color(0x08000000), blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: child,
    );
  }

  Widget _benefit(PartnerCard c) {
    return _innerCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _iconChip(c.icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.title,
                  style: const TextStyle(
                    fontFamily: _bold,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    letterSpacing: 0.2,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  c.subtitle,
                  style: const TextStyle(
                    fontFamily: _font,
                    fontSize: 12.5,
                    height: 1.35,
                    color: AppColors.greyshade1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _emailBox() => const InputDecoration(
    hintText: 'restaurant@example.com',
    hintStyle: TextStyle(fontFamily: _font, fontSize: 14, color: AppColors.gray200),
    isDense: true,
    contentPadding: EdgeInsets.fromLTRB(16, 12, 12, 12),
    filled: true,
    fillColor: Color(0xFFF2F2F2),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Color(0xFFE6E6E6)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Color(0xFFE6E6E6)),
    ),
    constraints: BoxConstraints(minHeight: 44, maxHeight: 44),
  );

  @override
  Widget build(BuildContext context) {
    final vm = Get.put(PartnerWithDineTimeVM(PartnerWithDineTimeModel.builtins()));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
           
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              // ===== OUTER SHEET =====
              padding: const EdgeInsets.symmetric(horizontal:  14, vertical: 14, ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE6E6E6)),
                boxShadow: const [
                  BoxShadow(color: Color(0x14000000), 
                  blurRadius: 12, offset: Offset(0, 6)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header inside the sheet
                  const Text(
                    'PARTNER WITH DINETIME',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: _bold,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: AppColors.black,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Join our platform and connect with thousands of diners seeking their next dining experience.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: _font,
                      fontSize: 12,
                      height: 1.35,
                      color: AppColors.greyshade1,
                    ),
                  ),
          
                  const SizedBox(height: 12),
          
                  // ===== INNER CARDS =====
                  ...vm.model.cards.map((c) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _benefit(c),
                  )),
          
                  const SizedBox(height: 4),
          
                  // GET STARTED (also an inner card)
                  _innerCard(
                      child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Center(
                            child: Text(
                              'GET STARTED',
                              style: TextStyle(
                                fontFamily: _bold,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Center(
                            child: Text(
                              "Submit your email and we'll reach out to discuss partnership opportunities.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: _font,
                                fontSize: 12.5,
                                height: 1.35,
                                color: AppColors.greyshade1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            'RESTAURANT EMAIL',
                            style: TextStyle(
                              fontFamily: _bold,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: AppColors.black,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: vm.emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            validator: vm.validateEmail,
                            style: const TextStyle(
                              fontFamily: _font,
                              fontSize: 14,
                              color: AppColors.black,
                            ),
                            decoration: _emailBox(),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 44,
                            child: Obx(
                                  () => ElevatedButton(
                                onPressed: vm.isSubmitting.value
                                    ? null
                                    : () => vm.submit(_formKey.currentState),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: AppColors.black,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: vm.isSubmitting.value
                                    ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                                    : const Text(
                                  'SUBMIT INQUIRY',
                                  style: TextStyle(
                                    fontFamily: _bold,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'We respect your privacy and will only contact you regarding partnership opportunities.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: _font,
                              fontSize: 11.5,
                              height: 1.35,
                              color: AppColors.greyshade1,
                            ),
                          ),
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
