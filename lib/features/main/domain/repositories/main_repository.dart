import 'package:location/location.dart';
import 'package:location_test/core/network/data_state.dart';

abstract class MainRepository {
  Future<DataState<dynamic>> sendUserLocation(
      {required double lat, required double lng});

  Future<PermissionStatus> checkPermissionLocation({required Location location});
  Future<bool> checkServiceLocation({required Location location});
}
