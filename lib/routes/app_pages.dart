import 'package:get/get.dart';
import 'package:tiktok/routes/routes.dart';

import '../dependency/dependency.dart';
import '../views/screens/auth/login_screen.dart';
import '../views/screens/auth/singup_screen.dart';
import '../views/screens/home/home_screen.dart';

class AppRoutes {
  static final List<GetPage> pagesRoute = [
    GetPage(
      name: loginRoute,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: registerRoute,
      page: () => const SignupScreen(),
      binding: RegistrationBinding(),
    ),
    GetPage(name: homeRoute, page: () => const HomeScreen()),
  ];
}
