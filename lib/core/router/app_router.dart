import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_test/features/auth/binding/auth_binding.dart';
import 'package:location_test/features/auth/presentation/pages/auth_page.dart';
import 'package:location_test/features/main/data/bindings/main_binding.dart';
import 'package:location_test/features/main/presentation/pages/main_page.dart';
import 'package:location_test/features/splash/binding/splash_binding.dart';
import 'package:location_test/features/splash/presentation/pages/splash_page.dart';

class AppRouter {
  AppRouter._();

  static List<GetPage> pages = [
    GetPage(
      name: RouterKey.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: RouterKey.main,
      page: () => const MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: RouterKey.auth,
      page: () => const AuthPage(),
      binding: AuthBinding(),
    ),
  ];

  static Map<String, Widget Function(BuildContext)> routers = {
    RouterKey.main: (context) => const MainPage(),
    RouterKey.splash: (context) => const SplashPage(),
    RouterKey.auth: (context) => const AuthPage(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterKey.main:
        return MaterialPageRoute(
          builder: (_) => const MainPage(),
          settings: settings,
        );
      case RouterKey.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
          settings: settings,
        );
      case RouterKey.auth:
        return MaterialPageRoute(
          builder: (_) => const AuthPage(),
          settings: settings,
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text("Page not found!"),
        ),
      );
    });
  }
}

class RouterKey {
  static const String splash = "/";
  static const String main = "/main";
  static const String auth = "/auth";
}
