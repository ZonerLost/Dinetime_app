class HungryNowModel {
  final String topIcon;
  final String settingsIcon;
  final String avatarIcon;

  final String tabHungry;
  final String tabDiscover;
  final String tabReservations;
  final String tabChat;
  final String tabProfile;

  final String checkIcon;
  final String? locationIcon;
  final String? chatIcon;

  const HungryNowModel({
    required this.topIcon,
    required this.settingsIcon,
    required this.avatarIcon,
    required this.tabHungry,
    required this.tabDiscover,
    required this.tabReservations,
    required this.tabChat,
    required this.tabProfile,
    required this.checkIcon,
     this.chatIcon, 
     this.locationIcon
  });
}
