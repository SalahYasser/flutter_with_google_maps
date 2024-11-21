import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/widgets/custom_google_maps.dart';

void main() {
  runApp(const TestGoogleMapsWithFlutter());
}

class TestGoogleMapsWithFlutter extends StatelessWidget {
  const TestGoogleMapsWithFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomGoogleMaps(),
    );
  }
}
