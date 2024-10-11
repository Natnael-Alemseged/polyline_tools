library polyline_tools;

import 'lat_lng.dart';

/// A utility for encoding and decoding Google Maps polylines.
class PolylineTools {
  /// Encodes a list of [LatLng] into a polyline string.
  static String encodePolyline(List<LatLng> coordinates) {
    StringBuffer encoded = StringBuffer();

    int lastLat = 0;
    int lastLng = 0;

    for (var point in coordinates) {
      int lat = (point.latitude * 1E5).round();
      int lng = (point.longitude * 1E5).round();

      int dLat = lat - lastLat;
      int dLng = lng - lastLng;

      encoded.write(_encodeValue(dLat));
      encoded.write(_encodeValue(dLng));

      lastLat = lat;
      lastLng = lng;
    }

    return encoded.toString();
  }

  /// Encodes a value using the polyline encoding algorithm.
  static String _encodeValue(int value) {
    value = value < 0 ? ~(value << 1) : (value << 1);
    StringBuffer encoded = StringBuffer();

    while (value >= 0x20) {
      encoded.writeCharCode((0x20 | (value & 0x1f)) + 63);
      value >>= 5;
    }
    encoded.writeCharCode(value + 63);

    return encoded.toString();
  }

  /// Decodes a polyline string into a list of [LatLng].
  static List<LatLng> decodePolyline(String polyline) {
    List<LatLng> points = [];
    int index = 0, len = polyline.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;

      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;

      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }
}


