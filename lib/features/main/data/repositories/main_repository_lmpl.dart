import 'package:location/location.dart';
import 'package:location_test/core/network/data_state.dart';
import 'package:location_test/core/network/error_handler.dart';
import 'package:location_test/features/main/data/datasources/main_api_provider.dart';
import 'package:location_test/features/main/data/datasources/main_local_provider.dart';
import 'package:location_test/features/main/domain/repositories/main_repository.dart';

class MainRepositoryImpl extends MainRepository {
  final MainApiProvider apiProvider;
  final MainLocalProvider localProvider;

  MainRepositoryImpl({
    required this.apiProvider,
    required this.localProvider,
  });

  @override
  Future<DataState> sendUserLocation(
      {required double lat, required double lng}) async {
    try {
      var response = await apiProvider.sendLocation(
        lat: lat,
        lng: lng,
      );
      if (response.$1 != null) {
        return DataSuccess(response.$1);
      } else {
        return DataFailed(
          ErrorHandler(errorMessage: response.$2!),
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
  Future<PermissionStatus> checkPermissionLocation(
      {required Location location}) async {
    try {
      var result =
          await localProvider.checkPermissionGranted(location: location);
      return result;
    } catch (e) {
      return PermissionStatus.denied;
    }
  }

  @override
  Future<bool> checkServiceLocation({required Location location}) async {
    var result = await localProvider.checkServiceLocation(location: location);
    return result;
  }
}
