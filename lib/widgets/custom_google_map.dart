import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_with_google_maps/models/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

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
      zoom: 12,
      target: LatLng(30.02847630076141, 31.259918244401106),
    );
    initMarkers();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  late GoogleMapController googleMapController;

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          markers: markers,
          onMapCreated: (controller) {
            googleMapController = controller;
            initMapStyle();
          },
          initialCameraPosition: initialCameraPosition,
        ),
        Positioned(
          left: 50,
          right: 70,
          bottom: 50,
          child: ElevatedButton(
            onPressed: () {
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

  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/night_map_style.json');

    googleMapController.setMapStyle(nightMapStyle);
  }

  Future<Uint8List> getImageFromRowData(String image, double width) async {
    var imageData = await rootBundle.load(image);
    var imageCodec = await ui.instantiateImageCodec(
        imageData.buffer.asUint8List(),
        targetHeight: width.round());

    var imageFrameInfo = await imageCodec.getNextFrame();
    var imageByteData =
        await imageFrameInfo.image.toByteData(format: ui.ImageByteFormat.png);

    return imageByteData!.buffer.asUint8List();
  }

  void initMarkers() async {
    var customMarkerIcon = BitmapDescriptor.fromBytes(
      await getImageFromRowData('assets/images/marker icon.png', 100),
    );
    var myMarkers = places
        .map(
          (placeModel) => Marker(
            icon: customMarkerIcon,
            infoWindow: InfoWindow(title: placeModel.name),
            position: placeModel.latLng,
            markerId: MarkerId(
              placeModel.id.toString(),
            ),
          ),
        )
        .toSet();
    markers.addAll(myMarkers);
    setState(() {});
  }
}

// World View 0 -> 3
// Country View 4 -> 6
// City View 10 -> 12
// Street View 13 -> 17
// Building View 18 -> 20
