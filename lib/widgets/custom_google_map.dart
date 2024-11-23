import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late Location location;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      zoom: 12,
      target: LatLng(30.02847630076141, 31.259918244401106),
    );
    location = Location();
    checkAndRequestLocationService();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (controller) {
            googleMapController = controller;
          },
          initialCameraPosition: initialCameraPosition,
        ),
      ],
    );
  }

  void checkAndRequestLocationService() async {
    var isServiceEnabled = await location.requestService();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        //  show error bar
      }
    }
  }
}

// inquire about location service
// request permission
// get location
// display
