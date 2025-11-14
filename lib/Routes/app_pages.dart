// lib/routes/app_pages.dart
import 'package:get/get.dart';
import '../Screens/activate_now_view.dart';
import '../Screens/dining_atmosphere_view.dart';
import '../Screens/discover_view.dart';
import '../Screens/food_interest_view.dart';
import '../Screens/forgot_password_view.dart';
import '../Screens/hungry_active_view.dart';
import '../Screens/hungry_now_view.dart';
import '../Screens/login_view.dart';
import '../Screens/partner_with_dinetime_view.dart';
import '../Screens/setup_profile_view.dart';
import '../Screens/sign_up_view.dart';
import '../Screens/splash_view.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
    ),
    GetPage(
      name: AppRoutes.setupProfile,
      page: () =>  SetupProfileView(),
    ),
    GetPage(name: AppRoutes.foodInterest, page: () => const FoodInterestView()),
    GetPage(name: AppRoutes.diningAtmosphere, page: () => const DiningAtmosphereView()),
    GetPage(name: AppRoutes.signUp, page: () => SignUpView()),
    GetPage(name: AppRoutes.login, page: () => LoginView(), transition: Transition.cupertino,),
    GetPage(name: AppRoutes.partner, page: () => PartnerWithDineTimeView(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => ForgotPasswordView(),
      transition: Transition.cupertino,
    ),
    GetPage(name: AppRoutes.hungryNow, page: () =>  HungryNowView()),
    GetPage(name: AppRoutes.activateNow, page: () =>  ActivateNowView()),
    GetPage(name: AppRoutes.hungryActive,
      page: () =>  HungryActiveView(),
      transition: Transition.cupertino,
    ),
    GetPage(name: AppRoutes.discover,
      page: () =>  DiscoverView(),
      transition: Transition.cupertino,
    ),
    // GetPage(name: AppRoutes.home, page: () => const HomeView()),
  ];
}
