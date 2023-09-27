import 'package:location/location.dart';
import 'package:location_test/features/main/domain/repositories/main_repository.dart';

class CheckServiceLocationUsecase {
  final MainRepository repository;

  CheckServiceLocationUsecase({required this.repository});

  Future<bool> call({required Location location}) async {
    return await repository.checkServiceLocation(location: location);
  }
}
