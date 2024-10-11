<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Polyline Tools

A Dart package for encoding and decoding Google Maps polylines. The `polyline_tools` package allows you to easily convert between encoded polyline strings and lists of geographical coordinates.

## Features

- Encode a list of `LatLng` points into a Google Maps encoded polyline string.
- Decode a Google Maps encoded polyline string back into a list of `LatLng` points.
- Simple API for quick integration in Flutter and Dart applications.

## Getting started

To use `polyline_tools`, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  polyline_tools: ^1.0.0  # Replace with the latest version
