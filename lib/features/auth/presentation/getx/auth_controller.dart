import 'package:get/get.dart';
import 'package:location_test/core/global/app_global.dart';
import 'package:location_test/core/global/event_status.dart';
import 'package:location_test/core/network/data_state.dart';
import 'package:location_test/core/storage/local_storage.dart';
import 'package:location_test/features/auth/domain/usecases/login_with_email_usecase.dart';
import 'package:location_test/features/auth/domain/usecases/sign_in_usecase.dart';

class AuthController extends GetxController {
  final SignInGoogleUsecase signInGoogleUsecase;
  final LoginWithEmailUsecase loginWithEmailUsecase;
  AuthController(
      {required this.signInGoogleUsecase, required this.loginWithEmailUsecase});

  EventStatus<String> userToken = EventInitial<String>();

  Future<void> signInEvent() async {
    userToken = EventLoading();
    DataState<String> result = await signInGoogleUsecase();
    if (result is DataSuccess) {
      userToken = EventCompleted(result.data!);
      update();
    } else {
      userToken = EventError(result.error!.errorMessage);
      update();
    }
  }

  Future<void> loginEvent({
    required String email,
    required String password,
  }) async {
    userToken = EventLoading<String>();
    DataState<String> result =
        await loginWithEmailUsecase(email: email, password: password);
    if (result is DataSuccess) {
      userToken = EventCompleted<String>(result.data!);
      update();
    } else {
      userToken = EventError<String>(result.error!.errorMessage);
      update();
    }
  }

  Future<void> saveUserToken() async {
    AppGlobal.userToken = (userToken as EventCompleted).data;
    LocalStorage.addorUpdate(
        key: StorageKeys.userToken, value: AppGlobal.userToken);
    LocalStorage.addorUpdate(key: StorageKeys.isLogin, value: true);
  }
}
