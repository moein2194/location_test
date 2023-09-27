// Import necessary packages and files
import 'package:get/get.dart';
import 'package:location_test/features/auth/data/datasources/auth_api_provider.dart';
import 'package:location_test/features/auth/data/repositories/auth_repository_lmpl.dart';
import 'package:location_test/features/auth/domain/repositories/auth_repositry.dart';
import 'package:location_test/features/auth/domain/usecases/login_with_email_usecase.dart';
import 'package:location_test/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:location_test/features/auth/presentation/getx/auth_controller.dart';

// This class extends Bindings from GetX, used to handle dependency injection
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy loading ensures that the instances are only created when first used
    Get.lazyPut<AuthApiProvider>(() => AuthApiProvider());

    // Creates an instance of AuthRepositoryImpl using the AuthApiProvider
    Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(apiProvider: Get.find()));

    // Creates an instance of LoginWithEmailUsecase using the AuthRepository
    Get.lazyPut<LoginWithEmailUsecase>(
        () => LoginWithEmailUsecase(repository: Get.find()));

    // Creates an instance of SignInGoogleUsecase using the AuthRepository
    Get.lazyPut<SignInGoogleUsecase>(
        () => SignInGoogleUsecase(repository: Get.find()));

    // Creates an instance of AuthController with the Usecases
    Get.lazyPut<AuthController>(
      () => AuthController(
        signInGoogleUsecase: Get.find(),
        loginWithEmailUsecase: Get.find(),
      ),
    );
  }
}
