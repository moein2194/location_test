import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_test/features/splash/presentation/getX/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashConrtoller conrtoller = Get.find();

  @override
  void initState() {
    conrtoller.checkUserLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "User Location",
              style: theme.textTheme.headlineMedium!.apply(),
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
                strokeWidth: 1.5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
