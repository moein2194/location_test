import 'package:location_test/core/network/data_state.dart';
import 'package:location_test/features/auth/domain/repositories/auth_repositry.dart';

class LoginWithEmailUsecase {
  final AuthRepository repository;

  LoginWithEmailUsecase({required this.repository});

  Future<DataState<String>> call({
    required String email,
    required String password,
  }) {
    return repository.login(
      email: email,
      password: password,
    );
  }
}
