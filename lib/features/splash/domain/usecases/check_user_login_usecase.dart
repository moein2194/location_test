import 'package:location_test/features/splash/domain/repositories/splash_repository.dart';

class CheckUserLoginUsecase {
  final SplashRepository repository;

  CheckUserLoginUsecase({required this.repository});

  Future<bool> call() async {
    return repository.checkUserLogin();
  }
}
