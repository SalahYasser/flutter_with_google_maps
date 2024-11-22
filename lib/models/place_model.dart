import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModel({
    required this.id,
    required this.name,
    required this.latLng,
  });
}

List<PlaceModel> places = [
  PlaceModel(
    id: 1,
    name: 'Salah AlDin Castle',
    latLng: LatLng(30.029358198216972, 31.259815391310145),
  ),
  PlaceModel(
    id: 2,
    name: 'Qasr ELAiny Hospital',
    latLng: LatLng(30.030731318553013, 31.233390716117515),
  ),
  PlaceModel(
    id: 3,
    name: 'Seoudi Supermarket',
    latLng: LatLng(30.03741888209873, 31.215590119809423),
  )
];
