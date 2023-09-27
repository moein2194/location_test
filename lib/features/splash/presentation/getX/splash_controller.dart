import 'package:get/get.dart';
import 'package:location_test/core/global/app_global.dart';
import 'package:location_test/core/global/event_status.dart';
import 'package:location_test/core/router/app_router.dart';
import 'package:location_test/features/splash/domain/usecases/check_user_login_usecase.dart';
import 'package:location_test/features/splash/domain/usecases/get_user_token_usecase.dart';

class SplashConrtoller extends GetxController {
  final CheckUserLoginUsecase userLoginUsecase;
  final GetUserTokenUsecase userTokenUsecase;

  SplashConrtoller(
      {required this.userLoginUsecase, required this.userTokenUsecase});

  EventStatus<String> userToken = EventInitial();

  Future<void> checkUserLogin() async {
    userToken = EventLoading();
    bool isLogin = await userLoginUsecase();

    if (isLogin) {
      String? token = await userTokenUsecase();
      if (token != null) {
        userToken = EventCompleted(token);

        AppGlobal.userToken = token;
        Get.offAllNamed(RouterKey.main);
      } else {
        userToken = EventError("user don't login");
        Get.offAndToNamed(RouterKey.auth);
      }
    } else {
      Get.offAndToNamed(RouterKey.auth);
    }
  }
}
