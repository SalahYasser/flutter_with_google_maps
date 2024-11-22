import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/models/place_model.dart';
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
      zoom: 1,
      target: LatLng(30.02847630076141, 31.259918244401106),
    );
    // initMarkers();
    // initPolylines();
    initPolygons();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  late GoogleMapController googleMapController;

  Set<Marker> markers = {};

  Set<Polyline> polylines = {};

  Set<Polygon> polygons = {};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          polylines: polylines,
          zoomControlsEnabled: false,
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

  void initMarkers() async {
    var customMarkerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker icon.png');

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

  void initPolylines() {
    Polyline polyline = Polyline(
      polylineId: PolylineId('1'),
      zIndex: 2,
      width: 5,
      startCap: Cap.roundCap,
      color: Colors.green,
      points: [
        LatLng(30.02909864687402, 31.25921014121841),
        LatLng(30.030921587755223, 31.232454863733096),
        LatLng(30.03754258190257, 31.215382937188323),
        LatLng(30.046067751123516, 31.211128210174067),
      ],
    );
    polylines.add(polyline);

    Polyline polyline2 = Polyline(
      polylineId: PolylineId('2'),
      zIndex: 1,
      geodesic: true,
      width: 5,
      startCap: Cap.roundCap,
      color: Colors.cyan,
      points: [
        LatLng(-31.59001195057221, 22.222114094760947),
        LatLng(84.30464358118809, 58.11661595700817),
      ],
    );

    polylines.add(polyline2);
  }

  void initPolygons() {
    Polygon polygon = Polygon(
        holes: const [
          [
            LatLng(25.030949373562184, 29.71903473330491),
            LatLng(28.753297577743304, 26.950480244745513),
            LatLng(29.673819683117372, 34.245401595552806),
          ]
        ],
        strokeWidth: 3,
        fillColor: Colors.black.withOpacity(.5),
        points: const [
          LatLng(31.5, 25.0),
          LatLng(31.5, 28.0),
          LatLng(31.2, 30.0),
          LatLng(31.0, 32.0),
          LatLng(31.0, 34.0),
          LatLng(31.0, 34.0),
          LatLng(29.5, 34.5),
          LatLng(28.0, 34.5),
          LatLng(25.0, 34.0),
          LatLng(25.0, 34.0),
          LatLng(22.0, 36.0),
          LatLng(22.0, 36.0),
          LatLng(22.0, 31.0),
          LatLng(22.0, 25.0),
          LatLng(22.0, 25.0),
          LatLng(25.0, 25.0),
          LatLng(31.5, 25.0)
        ],
        polygonId: const PolygonId('1'));
    polygons.add(polygon);
  }

}

// World View 0 -> 3
// Country View 4 -> 6
// City View 10 -> 12
// Street View 13 -> 17
// Building View 18 -> 20
