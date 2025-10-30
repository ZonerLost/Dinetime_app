import 'package:canada/Screens/settings_view.dart';
import 'package:canada/Widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Constants/app_images.dart';
import '../view_model/profile_vm.dart';
import '../Models/profile_models.dart';

class ProfileView extends GetView<ProfileVM> {
  const ProfileView({super.key});

  @override
  ProfileVM get controller => Get.put(ProfileVM(), permanent: true);

  @override
  Widget build(BuildContext context) {
    final safeBottom = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          final s = controller.state.value;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16, 12, 16, safeBottom + 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // tiny top row like the mock: left “time area” feel is OS; we just add right icons
                Row(
                  children: [
                    const Spacer(),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () => Get.to(() => const SettingsView()),
                      icon: SvgPicture.asset(
                        app_images.ic_settings,
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                      ),
                    ),

                    const SizedBox(width: 2),
                    ClipOval(
                      child: Image.asset(
                        app_images.picture1,
                        width: 26,
                        height: 26,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Profile card
                _Card(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(48),
                        child: Container(
                          width: 96,
                          height: 96,
                          color: const Color(0xFFEDEDED),
                          child: Image.asset(s.avatar, fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        s.name,
                        style: const TextStyle(
                          fontFamily:'Helvetica' ,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        s.bio,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                          height: 1.35,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: _BlackButton(label: 'Edit Profile', onTap: controller.editProfile),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _BlackButton(label: 'Status', onTap: () => _showStatusSheet(context)),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Wishlist
                 _SectionHeader(title: 'My Wishlist', trailing: 'View Feed'),

                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _WishlistCard(
                        item: s.wishlist[0],
                        onTap: () => controller.openWishlist(s.wishlist[0]),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _WishlistCard(
                        item: s.wishlist[1],
                        onTap: () => controller.openWishlist(s.wishlist[1]),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Instagram Preview
                const _SectionHeader(title: 'Instagram Preview', trailing: 'View Post'),
                const SizedBox(height: 8),
                _InstaGrid(
                  assets: s.instagram,
                  onTap: controller.openInstagram,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

/// ---------- Reusable widgets ----------

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow:  [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
        border: Border.all(color: const Color(0x11000000)),
      ),
      child: child,
    );
  }
}

class _BlackButton extends StatelessWidget {
  const _BlackButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 14,
          ),
        ),
        child: CustomTextWidget(text: label, 
        color: Colors.white, fontWeight: FontWeight.w600,),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.trailing});
  final String title;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomTextWidget(
          text:  title,
          
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          
        ),
        const Spacer(),
        if (trailing != null)
          CustomTextWidget(
           text:  trailing!,
            
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            
          ),
      ],
    );
  }
}

class _WishlistCard extends StatelessWidget {
  const _WishlistCard({required this.item, required this.onTap});
  final WishlistItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
       
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0x11000000)),
          boxShadow:  [BoxShadow(color: Colors.grey.withValues(alpha: 0.3), 
          blurRadius: 10, offset: Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(item.image, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                  const SizedBox(height: 2),
                  CustomTextWidget(text:  item.subtitle, 
                     
                     fontSize: 14, color: Colors.black45, fontWeight: FontWeight.w500),
            const SizedBox(height: 8),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _InstaGrid extends StatelessWidget {
  const _InstaGrid({required this.assets, required this.onTap});
  final List<String> assets;
  final void Function(String asset) onTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: assets.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (_, i) => GestureDetector(
        onTap: () => onTap(assets[i]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),   // ← small rounding, not circular
          child: Image.asset(assets[i], fit: BoxFit.cover),
        ),
      ),
    );
  }
}

void _showStatusSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent, // dim backdrop
    barrierColor: Colors.black.withOpacity(0.55),
    builder: (_) => const _StatusSheet(),
  );
}

class _StatusSheet extends StatefulWidget {
  const _StatusSheet({super.key});
  @override
  State<_StatusSheet> createState() => _StatusSheetState();
}

class _StatusSheetState extends State<_StatusSheet> {
  final TextEditingController _tc = TextEditingController();

  int activity = 0; // 0: Dine, 1: Event, 2: Anything
  int looking  = 0; // 0: Both, 1: Male, 2: Female
  int payment  = 0; // 0: Bill Paid, 1: Bill Split, 2: Prefer Not To Pay

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;

    return DraggableScrollableSheet(
      initialChildSize: 0.70,
      maxChildSize: 0.94,
      minChildSize: 0.60,
      builder: (context, controller) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF111111).withOpacity(0.96),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // drag handle
              Container(
                width: 64, height: 5,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 10),

              // title row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text('Status',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              const Text('Adjust your discovery preferences.',
                  style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),

              const SizedBox(height: 14),

              // sheet content
              Expanded(
                child: ListView(
                  controller: controller,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  children: [
                    // Text field
                    Container(
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white24),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        controller: _tc,
                        maxLines: 4,
                        minLines: 3,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        decoration: const InputDecoration(
                          hintText: 'E.g Looking for girls to grab drink with',
                          hintStyle: TextStyle(color: Colors.white60, fontWeight: FontWeight.w600,fontSize: 12),
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Activity type
                    const _SheetLabel('Activity type'),
                    _PillRow(
                      options: const ['Dine', 'Event', 'Anything'],
                      selected: activity,
                      onChanged: (i) => setState(() => activity = i),
                    ),

                    const SizedBox(height: 18),

                    // Looking For
                    const _SheetLabel('Looking For'),
                    _PillRow(
                      options: const ['Both', 'Male', 'Female'],
                      selected: looking,
                      onChanged: (i) => setState(() => looking = i),
                    ),

                    const SizedBox(height: 28),

                    // Payment
                    const _SheetLabel('Payment'),
                    _PillRow(
                      options: const ['Bill Paid', 'Bill Split', 'Prefer Not To Pay'],
                      selected: payment,
                      onChanged: (i) => setState(() => payment = i),
                    ),
                  ],
                ),
              ),

              // Bottom buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white24),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          textStyle: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: send values to your VM if needed
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          textStyle: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                        child: const Text('Save Status'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,)
            ],
          ),
        );
      },
    );
  }
}

class _SheetLabel extends StatelessWidget {
  const _SheetLabel(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
    );
  }
}

class _PillRow extends StatelessWidget {
  const _PillRow({
    required this.options,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final List<String> options;
  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    // Equal-width, full-row pills with comfy height
    const double h = 42;
    const double gap = 12;

    return Row(
      children: List.generate(options.length * 2 - 1, (idx) {
        if (idx.isOdd) return const SizedBox(width: gap);
        final i = idx ~/ 2;
        final picked = i == selected;

        return Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(11),
            onTap: () => onChanged(i),
            child: Container(
              height: h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: picked ? Colors.white : Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(11),
                border: Border.all(
                  color: picked ? Colors.white : Colors.white24,
                  width: 1,
                ),
              ),
              child: Text(
                options[i],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: picked ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}


