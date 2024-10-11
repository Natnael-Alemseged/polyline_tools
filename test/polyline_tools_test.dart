import 'package:flutter_test/flutter_test.dart';
import 'package:polyline_tools/polyline_tools.dart';
import 'package:polyline_tools/lat_lng.dart';

void main() {
  group('PolylineTools', () {
    test('encode and decode polyline', () {
      List<LatLng> points = [
        LatLng(38.5, -120.2),
        LatLng(40.7, -120.95),
        LatLng(43.252, -126.453),
      ];

      // Encode the polyline
      String encoded = PolylineTools.encodePolyline(points);

      // Decode the polyline back into a list of points
      List<LatLng> decodedPoints = PolylineTools.decodePolyline(encoded);

      // Check if the decoded points match the original points
      expect(decodedPoints.length, points.length);
      for (int i = 0; i < points.length; i++) {
        expect(decodedPoints[i].latitude, closeTo(points[i].latitude, 0.00001));
        expect(decodedPoints[i].longitude, closeTo(points[i].longitude, 0.00001));
      }
    });

    test('decodes polyline correctly', () {
      String encodedPolyline = '_p~iF~ps|U_ulLnnqC_mqNvxq`@';
      List<LatLng> decoded = PolylineTools.decodePolyline(encodedPolyline);

      expect(decoded.length, 3);
      expect(decoded[0].latitude, closeTo(38.5, 0.00001));
      expect(decoded[0].longitude, closeTo(-120.2, 0.00001));
      expect(decoded[1].latitude, closeTo(40.7, 0.00001));
      expect(decoded[1].longitude, closeTo(-120.95, 0.00001));
      expect(decoded[2].latitude, closeTo(43.252, 0.00001));
      expect(decoded[2].longitude, closeTo(-126.453, 0.00001));
    });
  });
}
