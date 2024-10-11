library polyline_tools;

import 'lat_lng.dart';

/// A utility for encoding and decoding Google Maps polylines.
class PolylineTools {
  /// Encodes a list of [LatLng] into a polyline string.
  ///
  /// This method takes a list of [LatLng] coordinates and converts them
  /// into a Google Maps polyline string representation. The polyline
  /// string can be used in Google Maps to render the path defined by
  /// the coordinates.
  static String encodePolyline(List<LatLng> coordinates) {
    StringBuffer encoded = StringBuffer();

    int lastLat = 0; // Holds the last latitude value
    int lastLng = 0; // Holds the last longitude value

    // Iterate through each point in the list of coordinates
    for (var point in coordinates) {
      int lat = (point.latitude * 1E5).round(); // Convert latitude to integer
      int lng = (point.longitude * 1E5).round(); // Convert longitude to integer

      // Calculate the difference from the last point
      int dLat = lat - lastLat;
      int dLng = lng - lastLng;

      // Encode the difference and append to the result
      encoded.write(_encodeValue(dLat));
      encoded.write(_encodeValue(dLng));

      // Update the last latitude and longitude for the next iteration
      lastLat = lat;
      lastLng = lng;
    }

    return encoded.toString(); // Return the encoded polyline string
  }

  /// Encodes a value using the polyline encoding algorithm.
  ///
  /// This helper method takes an integer value and encodes it using
  /// the Google Maps polyline encoding algorithm. The encoded value
  /// is returned as a string.
  static String _encodeValue(int value) {
    value = value < 0 ? ~(value << 1) : (value << 1); // Encode the value based on its sign
    StringBuffer encoded = StringBuffer(); // Buffer to hold the encoded characters

    // Continue encoding until the value is less than 0x20
    while (value >= 0x20) {
      // Encode the value and append it to the buffer
      encoded.writeCharCode((0x20 | (value & 0x1f)) + 63);
      value >>= 5; // Right shift the value for the next iteration
    }
    // Append the final character to the buffer
    encoded.writeCharCode(value + 63);

    return encoded.toString(); // Return the encoded string
  }

  /// Decodes a polyline string into a list of [LatLng].
  ///
  /// This method takes a Google Maps polyline string and decodes it
  /// into a list of [LatLng] coordinates. The coordinates represent
  /// the path defined by the polyline.
  static List<LatLng> decodePolyline(String polyline) {
    List<LatLng> points = []; // List to hold the decoded coordinates
    int index = 0, len = polyline.length; // Initialize index and length of the polyline
    int lat = 0, lng = 0; // Variables to hold latitude and longitude

    // While there are still characters to process in the polyline
    while (index < len) {
      int b, shift = 0, result = 0;

      // Decode latitude
      do {
        b = polyline.codeUnitAt(index++) - 63; // Get the next character
        result |= (b & 0x1F) << shift; // Update the result
        shift += 5; // Increase the shift
      } while (b >= 0x20); // Continue until a character less than 0x20 is found

      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1)); // Decode the latitude delta
      lat += dlat; // Update the latitude

      shift = 0; // Reset shift for longitude decoding
      result = 0; // Reset result for longitude decoding

      // Decode longitude
      do {
        b = polyline.codeUnitAt(index++) - 63; // Get the next character
        result |= (b & 0x1F) << shift; // Update the result
        shift += 5; // Increase the shift
      } while (b >= 0x20); // Continue until a character less than 0x20 is found

      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1)); // Decode the longitude delta
      lng += dlng; // Update the longitude

      // Add the new LatLng point to the list of points
      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points; // Return the list of decoded LatLng points
  }
}
