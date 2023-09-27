import 'package:location_test/core/network/data_state.dart';
import 'package:location_test/features/auth/domain/repositories/auth_repositry.dart';

class SignInGoogleUsecase {
  final AuthRepository repository;

  SignInGoogleUsecase({required this.repository});

  Future<DataState<String>> call() async {
    return await repository.signIn();
  }
}
