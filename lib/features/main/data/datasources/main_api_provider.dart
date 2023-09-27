import 'package:dio/dio.dart';
import 'package:location_test/core/network/base_urls.dart';
import 'package:location_test/core/network/http_request_handler.dart';

class MainApiProvider {
  Future<(dynamic data, String? error)> sendLocation(
      {required double lat, required double lng}) async {
    try {
      var response = await HttpRequestHanlder.post(
        BaseUrls.userLocation,
        data: FormData.fromMap({
          "lat": lat.toString(),
          "lang": lng.toString(),
        }),
      );
      if (response.$1 != null) {
        return (response.$1, null);
      } else {
        return (null, response.$2);
      }
    } catch (e) {
      return (null, "somethings went wrong...");
    }
  }
}
