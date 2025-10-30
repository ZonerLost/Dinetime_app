// lib/Screens/chat_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Constants/app_images.dart';
import '../Models/chat_models.dart';
import '../view_model/chat_vm.dart';
import 'chat_detail_view.dart';

class ChatView extends GetView<ChatVM> {
  const ChatView({super.key});

  @override
  ChatVM get controller => Get.put(ChatVM(), permanent: true);

  @override
  Widget build(BuildContext context) {
    final safeBottom = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar (search + right icons)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: Obx( () {
                final isDetail = controller.activeThread.value != null;
                 return !isDetail ? Row(
                  children: [
                    Expanded(
                      child: _SearchField(
                        onChanged: (t) => controller.query.value = t,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        app_images.ic_settings,
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
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
              ) : AbsorbPointer() ;}
              ),
            ),
          if(  controller.activeThread.value == null)
            const SizedBox(height: 10),

            Obx(() {
              final isDetail = controller.activeThread.value != null;
              if (isDetail) return const SizedBox.shrink();
              return SizedBox(
                height: 94,
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.stories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (context, i) =>
                      _StoryChip(user: controller.stories[i]),
                ),
              );
            }),

            Expanded(
              child: Obx(() {
                final thread = controller.activeThread.value;
                if (thread != null) {
                  return ChatDetailView(thread: thread);
                }

                // List screen
                final items = controller.filteredThreads;
                if (items.isEmpty) {
                  return const Center(
                    child: Text(
                      'No conversations',
                      style: TextStyle(color: Colors.black54),
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(12, 8, 12, safeBottom + 12),
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, i) {
                    final t = items[i];
                    return InkWell(
                      onTap: () => controller.openThread(t.id),
                      child: _ThreadTile(thread: t),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------- Top search ----------
class _SearchField extends StatelessWidget {
  const _SearchField({required this.onChanged});
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search restaurants, events…',
        hintStyle: const TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: Colors.black.withValues(alpha: 0.05),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(26),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            app_images.search,
            width: 15,
            height: 15,
            colorFilter: const ColorFilter.mode(
              Colors.black54,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

class _StoryChip extends StatelessWidget {
  const _StoryChip({required this.user});
  final StoryUser user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image.asset(
            user.photo,
            width: 48,
            height: 48,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 60,
          child: Text(
            user.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _ThreadTile extends StatelessWidget {
  const _ThreadTile({required this.thread});
  final ChatThread thread;

  @override
  Widget build(BuildContext context) {
    final hasUnread = thread.unread > 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.asset(
              thread.avatar,
              width: 44,
              height: 44,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),

          // Title + preview (fills remaining)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  thread.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 3),
                // Preview
                Text(
                  thread.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: 0.70),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Trailing column: time ABOVE badge/tick
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                thread.timeLabel,
                style: const TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w700,
                  fontSize: 11.5,
                ),
              ),
              const SizedBox(height: 6),
              if (hasUnread)
                _UnreadBadge(count: thread.unread)
              else if (thread.isRead)
                SvgPicture.asset(
                  app_images.check_check,
                  width: 16,
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                    Colors.green,
                    BlendMode.srcIn,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// Pretty unread badge (1–9 circle, 10–99 pill)
class _UnreadBadge extends StatelessWidget {
  const _UnreadBadge({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    final int shown = count.clamp(0, 99);
    final bool oneDigit = shown < 10;

    return Container(
      // Circle for 1–9, pill for 10–99
      constraints: oneDigit
          ? const BoxConstraints.tightFor(width: 24, height: 24)
          : const BoxConstraints(minWidth: 30, minHeight: 24),
      padding: EdgeInsets.symmetric(horizontal: oneDigit ? 0 : 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2F3440),
            Color(0xFF1F232C),
          ],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        shown.toString(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w800,
          height: 1.0,
        ),
      ),
    );
  }
}
