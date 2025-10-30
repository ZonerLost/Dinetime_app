import 'package:canada/Widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Constants/app_images.dart';
import '../view_model/reservations_vm.dart';
import '../Models/reservation_models.dart';

class ReservationsView extends GetView<ReservationsVM> {
  const ReservationsView({super.key});
  @override
  ReservationsVM get controller => Get.put(ReservationsVM(), permanent: true);

  @override
  Widget build(BuildContext context) {
    final safeBottom = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        titleSpacing: 0,
        title: const Text(
          'Reservations',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        leading: Navigator.of(context).canPop()
            ? IconButton(
          icon: SvgPicture.asset(
            app_images.back_icon,
            width: 22,
            height: 22,
            colorFilter:
            const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          onPressed: () => Get.back<void>(),
        )
            : const SizedBox.shrink(),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              app_images.ic_settings,
              width: 22,
              height: 22,
              colorFilter:
              const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16, 8, 16, safeBottom + 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SearchField(),
            const SizedBox(height: 16),

            const _SectionTitle('Upcoming Reservations'),
            const SizedBox(height: 10),

            Obx(() {
              final items = controller.upcoming;
              if (items.isEmpty) {
                return const _EmptyStripPlaceholder(
                  label: 'No upcoming reservations',
                  icon: app_images.calender,
                );
              }
              return _UpcomingStrip(
                upcoming: items,
                onManage: controller.manageReservation,
              );
            }),

            const SizedBox(height: 16),
            _QuickActionsRow(
              onNew: controller.newReservation,
              onInvite: controller.inviteFriends,
              onSync: controller.syncCalendar,
            ),

            const SizedBox(height: 16),
            _ExploreCard(onExplore: controller.explore),

            const SizedBox(height: 18),
            const _SectionTitle('Past Reservations'),
            const SizedBox(height: 10),

            Obx(() {
              final past = controller.past;
              if (past.isEmpty) {
                return const _EmptyListPlaceholder(
                  label: 'Nothing here yet',
                  sub: 'Your past reservations will appear here.',
                );
              }
              return _PastList(past: past, onTap: controller.openPast);
            }),
          ],
        ),
      ),
    );
  }
}

/// ---------- UI bits tuned to the mock ----------

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (t) => Get.find<ReservationsVM>().query.value = t,
      decoration: InputDecoration(
        hintText: 'Search restaurants, events…',
        hintStyle:
        const TextStyle(color: Colors.black38, fontWeight: FontWeight.w400),
        filled: true,
        fillColor: Colors.black.withValues(alpha: 0.05),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            app_images.ic_tab_discover,
            width: 18,
            height: 18,
            colorFilter:
            const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomTextWidget(
      text:  title,
     
          fontSize: 16.5, fontWeight: FontWeight.w800, color: Colors.black87
    );
  }
}

class _UpcomingStrip extends StatelessWidget {
  const _UpcomingStrip({required this.upcoming, required this.onManage});
  final List<UpcomingReservation> upcoming;
  final void Function(String id) onManage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 322, 
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: upcoming.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) =>
            _UpcomingCard(item: upcoming[i], onManage: onManage),
      ),
    );
  }
}

class _UpcomingCard extends StatelessWidget {
  const _UpcomingCard({required this.item, required this.onManage});
  final UpcomingReservation item;
  final void Function(String id) onManage;

  @override
  Widget build(BuildContext context) {
    final String dayPill = _weekdayOrFallback(item.date, fallback: 'Fri');

    return Container(
      width: 290,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 18,
            spreadRadius: 1,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: Stack(
              children: [
                Image.asset(
                  item.image,
                  height: 140,
                  width: 290,
                  fit: BoxFit.cover,
                ),
                Positioned(left: 10, top: 10, child: _DayPill(label: dayPill)),
              ],
            ),
          ),

          // 🟢 NEW space between image and content
          const SizedBox(height: 10),

          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + orange status chip
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.restaurantName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          height: 1.1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _StatusPill(text: item.status),
                  ],
                ),

                const SizedBox(height: 10),

                // Column of details
                _IconText(svg: app_images.map_pin, text: item.address),
                const SizedBox(height: 6),
                _IconText(svg: app_images.clock, text: item.time),
                const SizedBox(height: 6),
                _IconText(svg: app_images.invite_friends, text: '${item.guests} Guests'),

                const SizedBox(height: 14),

                // CTA button
                SizedBox(
                  height: 42,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () => onManage(item.id),
                    child: const CustomTextWidget(text: 'Manage Reservation', color: Colors.white, fontWeight: FontWeight.w600,),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// --- helpers styled to the comp ---

class _DayPill extends StatelessWidget {
  const _DayPill({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 4)],
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF4A4A4A),
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFF8A00), // orange pill
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w800,
          height: 1,
        ),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  const _IconText({required this.svg, required this.text});
  final String svg;
  final String text;

  @override
  Widget build(BuildContext context) {
    const c = Color(0xA6000000); // ~65% black like mock
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          svg,
          width: 16, // slightly larger to match comp
          height: 16,
          colorFilter: const ColorFilter.mode(c, BlendMode.srcIn),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            color: c,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}




// robust-enough weekday
String _weekdayOrFallback(String dateStr, {required String fallback}) {
  try {
    // Try DateTime.parse first; if it fails, try a loose parse for "Oct 15, 2025"
    DateTime? d = DateTime.tryParse(dateStr);
    d ??= DateTime.tryParse(dateStr.replaceAll(',', ''));
    d ??= DateTime.now();
    const wk = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return wk[d.weekday - 1];
  } catch (_) {
    return fallback;
  }
}


class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow(
      {required this.onNew, required this.onInvite, required this.onSync});
  final VoidCallback onNew, onInvite, onSync;

  @override
  Widget build(BuildContext context) {
    final items = [
      (app_images.plus, 'New Reservation', onNew),
      (app_images.invite_friends, 'Invite Friends', onInvite),
      (app_images.calender, 'Sync Calendar', onSync),
    ];

    return Row(
      children: items
          .map((it) => Expanded(
        child: _QuickActionTile(svg: it.$1, label: it.$2, onTap: it.$3),
      ))
          .toList(growable: false),
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile(
      {required this.svg, required this.label, required this.onTap});
  final String svg;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color: const Color(0x11000000)),
          boxShadow:  [
            BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 28, offset: Offset(0, 3))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svg,
              width: 20,
              height: 20,
              colorFilter:
              const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExploreCard extends StatelessWidget {
  const _ExploreCard({required this.onExplore});
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x0F000000)), // subtle hairline
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Texts
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  'Browse Restaurants',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 6),
                // Subtitle
                Text(
                  'Find your next dining experience.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Black pill button with arrow
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              elevation: 0,
              minimumSize: const Size(0, 40), // compact height
              padding: const EdgeInsets.symmetric(horizontal: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 13.5,
              ),
            ),
            onPressed: onExplore,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomTextWidget(text: 'Explore', color: Colors.white, fontWeight: FontWeight.w600,),
                const SizedBox(width: 8),
                SvgPicture.asset(
                  app_images.lina_arrow, // ensure this exists in your assets
                  width: 14,
                  height: 14,
                  colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _PastList extends StatelessWidget {
  const _PastList({required this.past, required this.onTap});
  final List<PastReservation> past;
  final void Function(String id) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: past
          .map((p) => _PastTile(item: p, onTap: () => onTap(p.id)))
          .toList(growable: false),
    );
  }
}

class _PastTile extends StatelessWidget {
  const _PastTile({required this.item, required this.onTap});
  final PastReservation item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 74,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0x11000000)),
          boxShadow:  [
            BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 18, offset: Offset(0, 3))
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(item.image,
                  width: 44, height: 44, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.restaurantName,
                      maxLines: 1,
                      
                      style: const TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 2),
                  Text(item.date,
                      style: const TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 2),
                  Text('${item.guests} Guests',
                      style: const TextStyle(color: Colors.black54)),
                ],
              ),
            ),
            SvgPicture.asset(app_images.orange_check, width: 18, height: 18),
          ],
        ),
      ),
    );
  }
}

class _EmptyStripPlaceholder extends StatelessWidget {
  const _EmptyStripPlaceholder({required this.label, required this.icon});
  final String label;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.035),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon, width: 18, height: 18,
              colorFilter:
              const ColorFilter.mode(Colors.black54, BlendMode.srcIn)),
          const SizedBox(width: 8),
          const Text('No upcoming reservations',
              style:
              TextStyle(color: Colors.black54, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _EmptyListPlaceholder extends StatelessWidget {
  const _EmptyListPlaceholder({required this.label, required this.sub});
  final String label;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.035),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(label,
              style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w800,
                  fontSize: 14)),
          const SizedBox(height: 6),
          Text(sub,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54, fontSize: 12)),
        ],
      ),
    );
  }
}
