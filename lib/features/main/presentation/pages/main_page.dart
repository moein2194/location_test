import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_test/core/global/event_status.dart';
import 'package:location_test/features/main/presentation/getX/main_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainController controller = Get.find();

  @override
  void initState() {
    controller.checkPermissionEvent().whenComplete(() {
      controller.checkServiceEvent().whenComplete(() {
        controller.getUserLocation();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.location.onLocationChanged.listen((event) {
      controller.setNewLocationEvent(event: event);
    });

    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              
            },
            icon: Text(
              "log out",
              style: theme.textTheme.bodyMedium!.apply(
                color: theme.colorScheme.error,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GetBuilder<MainController>(
                builder: (_) {
                  if (controller.locationData != null) {
                    controller.handlerSendUserLocation();
                  }

                  if ((_.permissionGranted is EventLoading ||
                          _.serviceLocationEnabled is EventLoading) &&
                      controller.locationData == null) {
                    return SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        color: theme.colorScheme.primary,
                        strokeWidth: 1.5,
                      ),
                    );
                  }
                  if ((_.permissionGranted is EventCompleted ||
                          _.serviceLocationEnabled is EventCompleted) &&
                      controller.locationData == null) {
                    return Text(
                      "We need your location data",
                      style: theme.textTheme.bodyMedium,
                    );
                  }
                  return Text(
                    "lat: ${_.locationData!.latitude},\n lng:${_.locationData!.longitude}",
                    style: theme.textTheme.bodyMedium,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
