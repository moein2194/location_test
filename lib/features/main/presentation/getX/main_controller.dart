import 'dart:async';

import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:location_test/core/global/event_status.dart';
import 'package:location_test/core/network/data_state.dart';
import 'package:location_test/features/main/domain/usecases/check_permission_location_usecase.dart';
import 'package:location_test/features/main/domain/usecases/check_service_lcoation_usecase.dart';
import 'package:location_test/features/main/domain/usecases/send_location_usecase.dart';

class MainController extends GetxController {
  final SendLocationUsecase sendLocationUsecase;
  final CheckPermissionLocationUsecase permissionLocationUsecase;
  final CheckServiceLocationUsecase serviceLocationUsecase;
  MainController({
    required this.sendLocationUsecase,
    required this.permissionLocationUsecase,
    required this.serviceLocationUsecase,
  });

  @override
  void onInit() {
    sendUserLocationEvent();
    super.onInit();
  }

  EventStatus<PermissionStatus>? permissionGranted =
      EventInitial<PermissionStatus>();
  EventStatus<bool> serviceLocationEnabled = EventInitial<bool>();
  Location location = Location();
  LocationData? locationData;
  StreamController<bool> requestStreamController = StreamController<bool>();

  EventStatus<dynamic> sendUserLocationData = EventInitial<dynamic>();

  void sendUserLocationEvent() {
    Timer.periodic(const Duration(seconds: 30), (timer) {
      requestStreamController.sink.add(true);
    });
  }

  @override
  void dispose() {
    requestStreamController.close();
    super.dispose();
  }

  void handlerSendUserLocation() async {
    requestStreamController.stream.listen((event) async{
      if (event) {
      sendUserLocationData = EventLoading();
      update();
      var result = await sendLocationUsecase(
        lat: locationData!.latitude!,
        lng: locationData!.longitude!,
      );
      if (result is DataSuccess) {
        sendUserLocationData = EventCompleted(result.data);
        update();
      }
      if (result is DataFailed) {
        sendUserLocationData = EventError(result.error!.errorMessage);
        update();
      }
      }
    });
  }

  Future<void> checkPermissionEvent() async {
    permissionGranted = EventLoading();
    update();
    var result = await permissionLocationUsecase(
      location: location,
    );
    permissionGranted = EventCompleted(result);
    update();
  }

  Future<void> checkServiceEvent() async {
    serviceLocationEnabled = EventLoading();
    update();
    var result = await serviceLocationUsecase(location: location);
    serviceLocationEnabled = EventCompleted(result);
    update();
  }

  Future<void> setNewLocationEvent({required LocationData event}) async {
    locationData = event;
    update();
  }

  Future<void> getUserLocation() async {
    locationData = await location.getLocation();
    update();
  }
}
