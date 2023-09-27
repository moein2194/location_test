import 'package:location/location.dart';
import 'package:location_test/features/main/domain/repositories/main_repository.dart';

class CheckPermissionLocationUsecase {
  final MainRepository repository;

  CheckPermissionLocationUsecase({required this.repository});

  Future<PermissionStatus> call({required Location location}) async {
    return await repository.checkPermissionLocation(location: location);
  }
}
