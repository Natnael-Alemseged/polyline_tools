import 'package:flutter/material.dart';
import 'package:polyline_tools/lat_lng.dart';
import 'package:polyline_tools/polyline_tools.dart';

void main() {
  // Example usage of PolylineTools
  List<LatLng> coordinates = [
    LatLng(37.7749, -122.4194), // San Francisco
    LatLng(34.0522, -118.2437), // Los Angeles
  ];

  // Encode the coordinates to a polyline
  String encodedPolyline = PolylineTools.encodePolyline(coordinates);
  debugPrint('Encoded Polyline: $encodedPolyline');

  // Decode the polyline back to coordinates
  List<LatLng> decodedCoordinates = PolylineTools.decodePolyline(encodedPolyline);
  debugPrint('Decoded Coordinates: ${decodedCoordinates.map((latLng) => '(${latLng.latitude}, ${latLng.longitude})').join(', ')}');
}
