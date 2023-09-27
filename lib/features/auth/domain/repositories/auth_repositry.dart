import 'package:location_test/core/network/data_state.dart';

abstract class AuthRepository {
  Future<DataState<String>> login({
    required String email,
    required String password,
  });

  Future<DataState<String>> signIn();
}
