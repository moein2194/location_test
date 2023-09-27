import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:location_test/config/assets/vectors.dart';
import 'package:location_test/core/global/event_status.dart';
import 'package:location_test/core/router/app_router.dart';
import 'package:location_test/features/auth/presentation/getx/auth_controller.dart';
import 'package:location_test/config/extensions.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    controller.addListener(() {
      if (controller.userToken is EventCompleted) {
        controller.saveUserToken();
        Get.offAndToNamed(RouterKey.main);
      }
      if (controller.userToken is EventError) {
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: theme.colorScheme.error,
            title: "Sign In Error",
            message: (controller.userToken as EventError).message,
            duration: const Duration(milliseconds: 1500),
          ),
        );
      }
    });
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Icon(
                  Icons.location_on_rounded,
                  size: 50,
                  color: theme.colorScheme.primary,
                ),
                Text(
                  "Location",
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 100,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) => value?.validateEmail,
                          decoration: InputDecoration(
                            hintText: "Enter your email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.all(4),
                            labelText: "Email",
                            prefixIcon: Icon(
                              Icons.mail_rounded,
                              size: 18,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: passwordController,
                          // validator: (value) => value?.validatePassword,
                          decoration: InputDecoration(
                            hintText: "Enter your password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.all(4),
                            labelText: "Password",
                            prefixIcon: Icon(
                              Icons.mail_rounded,
                              size: 18,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              controller.loginEvent(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GetBuilder<AuthController>(builder: (_) {
                    return ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          controller.loginEvent(
                              email: emailController.text,
                              password: passwordController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _.userToken is EventLoading
                            ? [
                                SizedBox(
                                  width: 23,
                                  height: 23,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                    color: theme.colorScheme.background,
                                  ),
                                )
                              ]
                            : [
                                Text(
                                  "login",
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyMedium!.apply(
                                    color: theme.colorScheme.background,
                                  ),
                                ),
                              ],
                      ),
                    );
                  }),
                ),
                Text(
                  "or",
                  style: theme.textTheme.bodyMedium,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GetBuilder<AuthController>(builder: (_) {
                    return ElevatedButton(
                      onPressed: () {
                        controller.signInEvent();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: _.userToken is EventLoading
                            ? [
                                SizedBox(
                                  width: 23,
                                  height: 23,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                    color: theme.colorScheme.background,
                                  ),
                                )
                              ]
                            : [
                                SvgPicture.asset(
                                  Vectors.googleIcon,
                                  height: 20,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "login with Google",
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyMedium!.apply(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
