class StoryUser {
  final String id;
  final String name;
  final String photo;
  StoryUser({required this.id, required this.name, required this.photo});
}

class ChatThread {
  final String id;
  final String title;
  final String subtitle;
  final String timeLabel;
  final String avatar;
  final bool isRead;
  final int unread;

  ChatThread({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timeLabel,
    required this.avatar,
    required this.isRead,
    required this.unread,
  });

  ChatThread copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? timeLabel,
    String? avatar,
    bool? isRead,
    int? unread,
  }) {
    return ChatThread(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      timeLabel: timeLabel ?? this.timeLabel,
      avatar: avatar ?? this.avatar,
      isRead: isRead ?? this.isRead,
      unread: unread ?? this.unread,
    );
  }
}

class ChatMessage {
  final String text;
  final String time;
  final bool me;
  ChatMessage({required this.text, required this.time, required this.me});
}
