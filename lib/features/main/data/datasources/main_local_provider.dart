import 'package:location/location.dart';

class MainLocalProvider {
  Future<PermissionStatus> checkPermissionGranted(
      {required Location location}) async {
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }
    return permissionGranted;
  }

  Future<bool> checkServiceLocation({required Location location}) async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    return serviceEnabled;
  }
}
