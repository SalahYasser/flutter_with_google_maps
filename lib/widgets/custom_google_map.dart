import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      zoom: 10,
      target: LatLng(30.07311530250178, 31.341816307394634),
    );
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
          // cameraTargetBounds: CameraTargetBounds(
          //   LatLngBounds(
          //     southwest: LatLng(30.05410470840546, 31.314569569626677),
          //     northeast: LatLng(30.086209095519088, 31.36544760712294),
          //   ),
          // ),
          mapType: MapType.hybrid,
          onMapCreated: (controller) {
            googleMapController = controller;
          },
          initialCameraPosition: initialCameraPosition,
        ),
        Positioned(
          left: 50,
          right: 50,
          bottom: 50,
          child: ElevatedButton(
            onPressed: () {
              // CameraPosition newLocation = CameraPosition(
              //   target: LatLng(29.28340297642408, 32.5660879837098),
              //   zoom: 10,
              // );
              //
              // googleMapController
              //     .animateCamera(CameraUpdate.newCameraPosition(newLocation));

              googleMapController.animateCamera(
                CameraUpdate.newLatLng(
                  LatLng(29.91109465958638, 31.395767241101126),
                ),
              );
            },
            child: Text('Change Location'),
          ),
        ),
      ],
    );
  }
}

// World View 0 -> 3
// Country View 4 -> 6
// City View 10 -> 12
// Street View 13 -> 17
// Building View 18 -> 20
