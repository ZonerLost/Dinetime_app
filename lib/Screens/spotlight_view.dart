import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Constants/app_images.dart';
import '../Models/SpotLightModel2.dart';
import '../view_model/spotlight_vm.dart';

class SpotlightView extends GetView<SpotlightVM> {
   SpotlightView({super.key});
  final GlobalKey _filterKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final safeBottom = MediaQuery.paddingOf(context).bottom;


    return Obx(() {
      final SpotlightPost item = controller.current;

      return Stack(
        children: [
          // hero photo (force burger)
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(app_images.burger, fit: BoxFit.cover),
            ),
          ),

          // top + bottom gradients
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 160,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  colors: [Color(0xCC000000), Color(0x00000000)],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 260,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter, end: Alignment.topCenter,
                  colors: [Color(0xE6000000), Color(0x00000000)],
                ),
              ),
            ),
          ),

          // TOP RIGHT DROPDOWN
          Positioned(
            right: 12,
            top: 140,
            child: _FilterPill(
              key: _filterKey,
              label: controller.filter.value == SpotlightFilter.latestInArea
                  ? 'Latest in Your Area'
                  : 'People You Follow',
              onTap: () async {
                final choice = await _showFilterMenuAnchored(context, _filterKey);
                if (choice != null) controller.setFilter(choice);
              },
            ),
          ),

          // RIGHT-SIDE ACTIONS (SVG only, no background)
          Positioned(
            right: 20,
            bottom: 120 + safeBottom,
            child: _SideActions(
              likes: item.likes,
              comments: item.comments,
              shares: item.shares,
              onLike: controller.like,
              onComment: controller.openComments,
              onShare: controller.share,
            ),
          ),

          // BOTTOM INFO STRIP
          Positioned(
            left: 12,
            right: 12,
            bottom: 12 + safeBottom,
            child: _InfoRow(
              item: item,
              onBookmark: controller.toggleBookmark,
            ),
          ),

          // FLOATING "+" BUTTON (bottom-right)
          Positioned(
            right: 12,
            bottom: 60 + safeBottom,
            child: _PlusButton(onTap: () {
              // TODO: compose/new spotlight
            }),
          ),
        ],
      );
    });
  }
}

// ───────────────── UI bits ─────────────────

// ── Pill (no border, light black) ─────────────────────────────────────────────
class _FilterPill extends StatelessWidget {
  const _FilterPill({super.key, required this.label, this.onTap});
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.70), // lighter black pill
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(color: Colors.black38, blurRadius: 6, offset: Offset(0, 2)),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              Image.asset(app_images.dropdown_arrow_png, width: 12, height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

Future<SpotlightFilter?> _showFilterMenuAnchored(
    BuildContext context,
    GlobalKey anchorKey,
    ) async {
  final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
  final box = anchorKey.currentContext!.findRenderObject() as RenderBox;

  // Pill position in the overlay’s coordinate space
  final Offset topLeft = box.localToGlobal(Offset.zero, ancestor: overlay);
  final Size size = box.size;

  // Menu directly beneath the pill, right-aligned with it
  final position = RelativeRect.fromLTRB(
    topLeft.dx,                   // left aligned to pill
    topLeft.dy + size.height,     // just below the pill
    overlay.size.width - (topLeft.dx + size.width), // right
    0,
  );

  return showMenu<SpotlightFilter>(
    context: context,
    position: position,
    color: Colors.black.withOpacity(0.80),         // light black menu
    shape: RoundedRectangleBorder(                 // rounded only, NO border
      borderRadius: BorderRadius.circular(8),
    ),
    items: const [
      PopupMenuItem(
        value: SpotlightFilter.latestInArea,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Text(
          'Latest in Your Area',
          style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
        ),
      ),
      PopupMenuDivider(height: 1),
      PopupMenuItem(
        value: SpotlightFilter.peopleYouFollow,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Text(
          'People You Follow',
          style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
        ),
      ),
    ],
  );
}


class _SideActions extends StatelessWidget {
  const _SideActions({
    required this.likes,
    required this.comments,
    required this.shares,
    required this.onLike,
    required this.onComment,
    required this.onShare,
  });

  final int likes, comments, shares;
  final VoidCallback onLike, onComment, onShare;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _iconWithCount(svg: app_images.like,     count: likes,    onTap: onLike),
        const SizedBox(height: 16),
        _iconWithCount(svg: app_images.comments, count: comments, onTap: onComment),
        const SizedBox(height: 16),
        _iconWithCount(svg: app_images.sharing,  count: shares,   onTap: onShare),
      ],
    );
  }

  Widget _iconWithCount({
    required String svg,
    required int count,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkResponse(
          onTap: onTap,
          radius: 28,
          child: SvgPicture.asset(
            svg,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          _kFormat(count),
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.item, required this.onBookmark});
  final SpotlightPost item;
  final VoidCallback onBookmark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipOval(
              child: Image.asset(app_images.picture1, width: 40, height: 42, fit: BoxFit.cover),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      item.placeName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  SvgPicture.asset(
                    app_images.popular_mark,
                    width: 14, height: 14,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),

          ],
        ),
        const SizedBox(height: 8),
        Text(
          item.caption,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          'Followed by ${item.followedBy}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}

class _PlusButton extends StatelessWidget {
  const _PlusButton({this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.28),
            shape: BoxShape.circle,

            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 3)),
            ],
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.add, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}

// ── utils ──
String _kFormat(int n) {
  if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}m';
  if (n >= 1000) return '${(n / 1000).toStringAsFixed(0)}k';
  return '$n';
}
