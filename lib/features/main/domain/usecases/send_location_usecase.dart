import 'package:location_test/core/network/data_state.dart';
import 'package:location_test/features/main/domain/repositories/main_repository.dart';

class SendLocationUsecase {
  final MainRepository repository;

  SendLocationUsecase({required this.repository});

  Future<DataState<dynamic>> call(
      {required double lat, required double lng}) async {
    return await repository.sendUserLocation(lat: lat, lng: lng);
  }
}
