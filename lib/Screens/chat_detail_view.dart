// lib/Screens/chat_detail_view.dart
import 'package:canada/Widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/chat_models.dart';
import '../view_model/chat_vm.dart';

/// Standalone chat detail that sits INSIDE your tab (no route push).
/// Assumes ChatVM is already registered by ChatView.
class ChatDetailView extends StatefulWidget {
  const ChatDetailView({super.key, required this.thread});
  final ChatThread thread;

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  final TextEditingController _tc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<ChatVM>();
    final safeBottom = MediaQuery.paddingOf(context).bottom;

    return Column(
      children: [
        // ── Top app bar area (back + centered title)
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: vm.closeThread,
                  icon: const Icon(Icons.arrow_back_ios_new,
                      size: 18, color: Colors.black),
                  padding: EdgeInsets.zero,
                  constraints:
                  const BoxConstraints(minWidth: 36, minHeight: 36),
                ),
              ),
              const Text(
                'View User',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16.5,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),

        // ── User header (avatar + name + presence)
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  widget.thread.avatar,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emma 25',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14.5,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 2),
                  CustomTextWidget(
                    text:  'Active now',
                    
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                      fontSize: 11.5,
                    
                  ),
                ],
              ),
            ],
          ),
        ),

        // ── Messages
        Expanded(
          child: Obx(() {
            final msgs = vm.messages;
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              physics: const BouncingScrollPhysics(),
              itemCount: msgs.length,
              itemBuilder: (context, i) => _Bubble(
                text: msgs[i].text,
                time: msgs[i].time,
                me: msgs[i].me,
              ),
            );
          }),
        ),

        // ── Composer
        Padding(
          padding: EdgeInsets.fromLTRB(12, 6, 12, safeBottom + 6),
          child: Row(
            children: [
              // Input
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: _tc,
                    minLines: 1,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'Write here...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Actions
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.emoji_emotions_outlined,
                    color: Colors.black87),
              ),
              IconButton(
                onPressed: () {},
                icon:
                const Icon(Icons.photo_outlined, color: Colors.black87),
              ),
              IconButton(
                onPressed: () {
                  final t = _tc.text.trim();
                  if (t.isEmpty) return;
                  vm.sendMessage(t);
                  _tc.clear();
                },
                icon:
                const Icon(Icons.send_rounded, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Chat bubble that matches the mock: light grey for incoming, black for outgoing,
/// timestamp tucked right under each bubble.
class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.text,
    required this.time,
    required this.me,
  });

  final String text;
  final String time;
  final bool me;

  @override
  Widget build(BuildContext context) {
    final bg = me ? Colors.black : const Color(0xFFF1F2F4);
    final fg = me ? Colors.white : Colors.black87;
    final align = me ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: align,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.72,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: CustomTextWidget(
              text:  text,
              
                color: fg,
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
              
            ),
          ),
          const SizedBox(height: 4),
          CustomTextWidget(
            text:  time,
            
              color: Colors.black38,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            
          ),
        ],
      ),
    );
  }
}
