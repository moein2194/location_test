import 'package:location_test/core/storage/local_storage.dart';

class SplashLocalProvider {
  Future<bool> checkUserLogin() async {
    String? isLogin = await LocalStorage.get(key: StorageKeys.isLogin);
    if (isLogin != null) {
      return bool.parse(isLogin);
    } else {
      return false;
    }
  }

  Future<String?> getUserToken() async {
    String? userToken = await LocalStorage.get(key: StorageKeys.userToken);
    return userToken;
  }
}
