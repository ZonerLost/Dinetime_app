import 'package:get/get.dart';
import '../Models/chat_models.dart';
import '../Constants/app_images.dart';

class ChatVM extends GetxController {
  // Top search
  final RxString query = ''.obs;

  // Stories / quick contacts
  final RxList<StoryUser> stories = <StoryUser>[
    StoryUser(id: 'u1', name: 'Emma',  photo: app_images.picture1),
    StoryUser(id: 'u2', name: 'Liam',  photo: app_images.picture2),
    StoryUser(id: 'u3', name: 'Ava',   photo: app_images.picture1),
    StoryUser(id: 'u4', name: 'Noah',  photo: app_images.picture2),
  ].obs;

  // Conversation list
  final RxList<ChatThread> threads = <ChatThread>[
    ChatThread(
      id: 't1',
      title: 'Emma',
      subtitle: 'Let’s try that sushi place tonight?',
      timeLabel: '2m',
      avatar: app_images.picture1,
      isRead: false,
      unread: 2,
    ),
    ChatThread(
      id: 't2',
      title: 'Liam',
      subtitle: 'I booked 7:30 at Burger Palace',
      timeLabel: '1h',
      avatar: app_images.picture2,
      isRead: true,
      unread: 0,
    ),
    ChatThread(
      id: 't3',
      title: 'Ava',
      subtitle: 'Italian or Mexican tomorrow?',
      timeLabel: 'Tue',
      avatar: app_images.picture1,
      isRead: true,
      unread: 0,
    ),
  ].obs;

  // Selected thread (null = list mode)
  final Rx<ChatThread?> activeThread = Rx<ChatThread?>(null);

  // Messages for the active thread
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;

  // Derived: filter threads by query
  List<ChatThread> get filteredThreads {
    final q = query.value.trim().toLowerCase();
    if (q.isEmpty) return threads;
    return threads
        .where((t) =>
    t.title.toLowerCase().contains(q) ||
        t.subtitle.toLowerCase().contains(q))
        .toList(growable: false);
  }

  // Open a thread and load demo messages
  void openThread(String id) {
    final t = threads.firstWhereOrNull((e) => e.id == id);
    if (t == null) return;

    activeThread.value = t;

    // Demo convo per-thread
    if (id == 't1') {
      messages.assignAll([
        ChatMessage(text: 'Hey! Sushi tonight?', time: '7:02 PM', me: false),
        ChatMessage(text: 'Totally down 🍣', time: '7:03 PM', me: true),
        ChatMessage(text: 'There’s a 7:30 slot open.', time: '7:03 PM', me: false),
        ChatMessage(text: 'Grab it! I’ll meet you there.', time: '7:04 PM', me: true),
      ]);
    } else if (id == 't2') {
      messages.assignAll([
        ChatMessage(text: 'Booked 7:30 at Burger Palace.', time: '6:10 PM', me: false),
        ChatMessage(text: 'Legend. See you!', time: '6:11 PM', me: true),
      ]);
    } else {
      messages.assignAll([
        ChatMessage(text: 'Italian or Mexican tomorrow?', time: 'Tue 4:10 PM', me: false),
        ChatMessage(text: 'Hmm… Mexican 🌮', time: 'Tue 4:11 PM', me: true),
      ]);
    }

    // Mark unread as read
    if (t.unread > 0) {
      final idx = threads.indexWhere((x) => x.id == t.id);
      if (idx != -1) {
        threads[idx] = threads[idx].copyWith(unread: 0, isRead: true);
      }
    }
  }

  // Close detail -> back to list
  void closeThread() {
    activeThread.value = null;
    messages.clear();
  }

  // Send message
  void sendMessage(String text) {
    final clean = text.trim();
    if (clean.isEmpty) return;
    messages.add(ChatMessage(text: clean, time: _nowLabel(), me: true));
  }

  String _nowLabel() {
    // quick label for demo
    return 'now';
  }
}
