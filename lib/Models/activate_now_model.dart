class ActivateNowItem {
  final String title;
  final String subtitle;
  final ActivateNowIcon icon;
  const ActivateNowItem({required this.title, required this.subtitle, required this.icon});
}

enum ActivateNowIcon { time, heart, pin }

class ActivateNowModel {
  final String heading;
  final String subheading;
  final List<ActivateNowItem> items;

  const ActivateNowModel({
    required this.heading,
    required this.subheading,
    required this.items,
  });
}
