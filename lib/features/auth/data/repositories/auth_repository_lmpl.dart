import 'package:location_test/core/network/data_state.dart';
import 'package:location_test/core/network/error_handler.dart';
import 'package:location_test/features/auth/data/datasources/auth_api_provider.dart';
import 'package:location_test/features/auth/domain/repositories/auth_repositry.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthApiProvider apiProvider;

  AuthRepositoryImpl({required this.apiProvider});

  @override
  Future<DataState<String>> login(
      {required String email, required String password}) async {
    try {
      var response = await apiProvider.loginWithEmailAndPassword(
          email: email, password: password);

      if (response.$1 != null) {
        return DataSuccess(response.$1);
      } else {
        return DataFailed(
          ErrorHandler(
            errorMessage: response.$2!,
          ),
        );
      }
    } catch (e) {
      return DataFailed(
        ErrorHandler(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<DataState<String>> signIn() async {
    try {
      var response = await apiProvider.signInWithGoogle();
      if (response.$1 != null) {
        return DataSuccess(response.$1);
      } else {
        return DataFailed(
          ErrorHandler(
            errorMessage: response.$2!,
          ),
        );
      }
    } catch (e) {
      return DataFailed(
        ErrorHandler(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
