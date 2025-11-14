import 'dart:ui';

import 'package:canada/Constants/app_colors.dart';
import 'package:canada/Widgets/custom_text_input_widget.dart';
import 'package:canada/Widgets/details_hotandtrend_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Constants/app_images.dart';
import '../Models/hot_trending_post.dart';
import '../view_model/hot&trending_vm.dart';


class HotTrendingView extends GetView<HotTrendingVM> {
  const HotTrendingView({super.key});

  @override
  Widget build(BuildContext context) {
    final safeBottom = MediaQuery.paddingOf(context).bottom;

    return Obx(() {
      final HotTrendingPost item = controller.current;

      return Stack(
        children: [

          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(app_images.burger, fit: BoxFit.cover),
            ),
          ),



          // gradients
         
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 280,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter, end: Alignment.topCenter,
                  colors: [Color(0xE6000000), Color(0x00000000)],
                ),
              ),
            ),
          ),

          // replace the old Positioned for _InfoRow
          Positioned(
            left: 12,
            right: 60,                 // leave room so the floating info btn doesn't overlap text
            bottom: 40 + safeBottom,   // ↓ a little lower than before (closer to bottom)
            child: _InfoRow(
              item: item,
              onToggleLike: controller.toggleLike,
            ),
          ),

// add this: floating circular INFO at the far right edge
          Positioned(
            right: 15,
            bottom: 90 + safeBottom,   
            child: _roundInfoButton(app_images.info, (){
              Get.bottomSheet(
                DraggableScrollableSheet(
                  expand: false,
                  minChildSize: 0.18,
                  initialChildSize: 0.38,
                  maxChildSize: 0.85,
                  builder: (context, scrollController) {
                    return DetailsHotandtrendSheetWidget(
                      scrollController: scrollController,
                    );
                  },
                ),
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                enableDrag: true,
              );
            }),
          ),

          Positioned(
            left: 0,
            right: 0, // full bleed
            bottom: 15 + MediaQuery.paddingOf(context).bottom,
            child: const _SegmentBarRow(
              segments: 6,
              activeIndex: 0, 
              gap: 6,
            ),
          ),
         
Positioned(
  left: 12,
  right: 12,
  top: 130 + safeBottom,
  child: ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15), 
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03), 
          borderRadius: BorderRadius.circular(16),
          
        ),
        child: CustomTextInputWidget(
          fillColor: Colors.transparent, 
          suffixIcon: const Icon(Icons.search, color: Colors.white70),
          hintText: 'Search',
          controller: TextEditingController(),
          border: OutlineInputBorder(borderSide: BorderSide.none), 
        ),
      ),
    ),
  ),
),
        ],
      );
    });
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.item, required this.onToggleLike});
  final HotTrendingPost item;
  final VoidCallback onToggleLike;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // avatar • name+tick • bookmark
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.asset(
                  app_images.picture1,
                  width: 45, height: 45, fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),

              // name + verified (tight)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      item.placeName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6, top: 1),
                    child: SvgPicture.asset(
                      app_images.popular_mark,
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                          Colors.white, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 8),


              SvgPicture.asset(
                app_images.bookmark,
                width: 25,
                height: 25,
                colorFilter: const ColorFilter.mode(
                    Colors.white, BlendMode.srcIn),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // caption
          Text(
            item.caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),

          const SizedBox(height: 4),

          // followed by…
          Text(
            'Followed by ${item.followedBy}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),

          // ⬆️ bars removed from here (must be in the Stack)
        ],
      ),
    );
  }
}



Widget _roundInfoButton(String asset, VoidCallback? onTap) {
  return Material(
    color: Colors.transparent,
    shape: const CircleBorder(),
    child: InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.32),

        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          asset,
          width: 16,
          height: 16,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    ),
  );
}


// paste this BELOW your _InfoRow class (same file)
class _SegmentBarRow extends StatelessWidget {
  const _SegmentBarRow({
    required this.segments,
    required this.activeIndex,
    this.gap = 6,
  }); 

  final int segments;      // e.g., controller.posts.length
  final int activeIndex;   // e.g., controller.currentIndex.value
  final double gap;        // space between segments

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(segments * 2 - 1, (i) {
          if (i.isOdd) return SizedBox(width: gap);
          final seg = i ~/ 2;
          final bool isActive = seg == activeIndex;
          return Expanded(
            child: Container(
              height: 2,
              decoration: BoxDecoration(
                color: isActive ? Colors.white : Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }
}

