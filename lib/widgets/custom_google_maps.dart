import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({super.key});

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  late CameraPosition initialCameraPosition;

  @override
  void initState() {
    initialCameraPosition = CameraPosition(
      target: LatLng(30.07311530250178, 31.341816307394634),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(

      initialCameraPosition: initialCameraPosition,
    );
  }
}
