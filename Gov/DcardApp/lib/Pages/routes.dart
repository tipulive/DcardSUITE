import 'package:get/get.dart';
import '../Pages/Homepage.dart';
import '../Pages/Login.dart';
import '../Pages/ProfilePage.dart';
import '../Pages/EventsPage.dart';

import '../Pages/UserAccountPage.dart';
import '../Pages/QuickBonusPage.dart';
import '../Pages/QuickCartPage.dart';
import '../Pages/ErrorPage.dart';
import '../Pages/SetStockPage.dart';
import '../Pages/SettingPage.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () =>const Homepage()),
    GetPage(name: '/home', page: () =>const Homepage()),
    GetPage(name: '/Login', page: () =>const Login()),
    GetPage(name: '/ProfilePage', page: () => const ProfilePage()),
    GetPage(name: '/EventsPage', page: () => const EventsPage()),
    GetPage(name: '/UserAccount', page: () =>const UserAccountPage()),
    GetPage(name: '/UserAccount', page: () =>const UserAccountPage()),
    GetPage(name: '/QuickBonus', page: () =>const QuickBonusPage()),
    GetPage(name: '/QuickCart', page: () =>const QuickCartPage()),
    GetPage(name: '/ErrorPage', page: () => const ErrorPage()),
    GetPage(name: '/SetStock', page: () => const SetStockPage()),
    GetPage(name: '/settings', page: () => const SettingPage()),
  ];
}