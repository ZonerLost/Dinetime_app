import 'package:get/get.dart';
import '../Constants/app_images.dart';
import '../Models/reservation_models.dart';

class ReservationsVM extends GetxController {
  // search field text (if you want to hook it later)
  final RxString query = ''.obs;

  final RxList<UpcomingReservation> upcoming = <UpcomingReservation>[
    UpcomingReservation(
      id: 'u1',
      restaurantName: 'The Culinary Haver',
      image: app_images.resturant,
      address: '123 Main St, Downtown',
      date: 'Oct 18, 2025',
      time: '7:30 PM',
      guests: 4,
      status: 'Confirmed',
      isVip: true,
    ),
    UpcomingReservation(
      id: 'u2',
      restaurantName: 'Spice Route',
      image: app_images.italian_food, // demo image
      address: '480 Oak Circle',
      date: 'Oct 20, 2025',
      time: '8:00 PM',
      guests: 2,
      status: 'Booked',
    ),
  ].obs;

  final RxList<PastReservation> past = <PastReservation>[
    PastReservation(
      id: 'p1',
      restaurantName: 'Pasta Palace',
      image: app_images.pasta,
      date: 'Oct 15, 2025',
      guests: 3,
    ),
    PastReservation(
      id: 'p2',
      restaurantName: 'Sushi Zen Garden',
      image: app_images.sushi,
      date: 'Sep 28, 2025',
      guests: 2,
    ),
    PastReservation(
      id: 'p3',
      restaurantName: 'Burger Blast',
      image: app_images.burger,
      date: 'Sep 22, 2025',
      guests: 6,
    ),
  ].obs;

  // actions (stubs)
  void manageReservation(String id) {}
  void newReservation() {}
  void inviteFriends() {}
  void syncCalendar() {}
  void explore() {}
  void openPast(String id) {}
}
