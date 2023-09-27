import 'package:get/get.dart';
import 'package:location_test/features/splash/data/datasources/splash_local_provider.dart';
import 'package:location_test/features/splash/data/repositories/splash_repository_lmpl.dart';
import 'package:location_test/features/splash/domain/repositories/splash_repository.dart';
import 'package:location_test/features/splash/domain/usecases/check_user_login_usecase.dart';
import 'package:location_test/features/splash/domain/usecases/get_user_token_usecase.dart';
import 'package:location_test/features/splash/presentation/getX/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashLocalProvider>(() => SplashLocalProvider());

    Get.lazyPut<SplashRepository>(
        () => SplashRepositoryImpl(localProvider: Get.find()));

    Get.lazyPut<CheckUserLoginUsecase>(
        () => CheckUserLoginUsecase(repository: Get.find()));
    Get.lazyPut<GetUserTokenUsecase>(
        () => GetUserTokenUsecase(repository: Get.find()));

    Get.lazyPut<SplashConrtoller>(() => SplashConrtoller(
        userLoginUsecase: Get.find(), userTokenUsecase: Get.find()));
  }
}
