// main_nav_view.dart
import 'package:canada/Controllers/nav_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:canada/Screens/hungry_now_view.dart';
import 'package:canada/Screens/discover_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../widgets/dt_bottom_nav.dart';
import '../Constants/app_images.dart';
import '../Screens/chat_view.dart';
import '../Screens/profile_view.dart';
import '../Screens/reservations_view.dart';


class MainNavView extends StatefulWidget {
  const MainNavView({super.key});

  @override
  State<MainNavView> createState() => _MainNavViewState();
}

class _MainNavViewState extends State<MainNavView> {
  final NavbarController navbarController = Get.find();

  // ❌ Do NOT use const here; these screens register controllers (Get.put)
  final List<Widget> _pages = [
    HungryNowView(),
    DiscoverView(),
    ReservationsView(),                 // <-- your real screen
    ChatView(),
    ProfileView(),
  ];

  final List<DtNavItem> _items = const [
    DtNavItem(app_images.ic_tab_hungry,       'Hungry Now'),
    DtNavItem(app_images.ic_tab_discover,     'Discover'),
    DtNavItem(app_images.ic_tab_reservations, 'Reservations'),
    DtNavItem(app_images.ic_tab_chat,         'Chat'),
    DtNavItem(app_images.ic_tab_profile,      'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: navbarController.index.value,
        children: _pages,
      )),
      bottomNavigationBar: Obx(() => DtBottomNav(
        currentIndex: navbarController.index.value,
        onTap: navbarController.toggleIndex,
        items: _items,
        child: Row(
          children: List.generate(_items.length, (i) {
            final selected = i == navbarController.index.value;
            final item = _items[i];
            return Expanded(
              child: InkResponse(
                onTap: () => navbarController.toggleIndex(i),
                radius: 42,


                child: Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        item.iconPath,
                        height: 20,
                        color: i == 2 ? null :  selected
                            ? Colors.white
                            :  Colors.white
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          height: 1.0,
                          color: selected
                              ? Colors.white
                              : Colors.white.withOpacity(0.75),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      )),
    );
  }
}

class _Placeholder extends StatelessWidget {
  final String title;
  const _Placeholder({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(title,
            style: const TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }
}
