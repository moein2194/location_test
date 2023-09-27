import 'package:location_test/features/splash/data/datasources/splash_local_provider.dart';
import 'package:location_test/features/splash/domain/repositories/splash_repository.dart';

class SplashRepositoryImpl extends SplashRepository {
  final SplashLocalProvider localProvider;

  SplashRepositoryImpl({required this.localProvider});

  @override
  Future<bool> checkUserLogin() async {
    var result = await localProvider.checkUserLogin();
    return result;
  }

  @override
  Future<String?> getUserToken() async {
    var result = await localProvider.getUserToken();
    return result;
  }
}
