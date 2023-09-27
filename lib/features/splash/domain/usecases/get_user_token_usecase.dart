import 'package:location_test/features/splash/domain/repositories/splash_repository.dart';

class GetUserTokenUsecase {
  final SplashRepository repository;

  GetUserTokenUsecase({required this.repository});

  Future<String?> call() async {
    return repository.getUserToken();
  }
}
