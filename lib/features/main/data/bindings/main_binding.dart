import 'package:get/get.dart';
import 'package:location_test/features/main/data/datasources/main_api_provider.dart';
import 'package:location_test/features/main/data/datasources/main_local_provider.dart';
import 'package:location_test/features/main/data/repositories/main_repository_lmpl.dart';
import 'package:location_test/features/main/domain/repositories/main_repository.dart';
import 'package:location_test/features/main/domain/usecases/check_permission_location_usecase.dart';
import 'package:location_test/features/main/domain/usecases/check_service_lcoation_usecase.dart';
import 'package:location_test/features/main/domain/usecases/send_location_usecase.dart';
import 'package:location_test/features/main/presentation/getX/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainApiProvider>(() => MainApiProvider());
    Get.lazyPut<MainLocalProvider>(() => MainLocalProvider());

    Get.lazyPut<MainRepository>(() =>
        MainRepositoryImpl(apiProvider: Get.find(), localProvider: Get.find()));
    Get.lazyPut<CheckPermissionLocationUsecase>(
        () => CheckPermissionLocationUsecase(repository: Get.find()));
    Get.lazyPut<CheckServiceLocationUsecase>(
        () => CheckServiceLocationUsecase(repository: Get.find()));
    Get.lazyPut<SendLocationUsecase>(
        () => SendLocationUsecase(repository: Get.find()));

    Get.lazyPut<MainController>(() => MainController(
        sendLocationUsecase: Get.find(),
        permissionLocationUsecase: Get.find(),
        serviceLocationUsecase: Get.find()));
  }
}
