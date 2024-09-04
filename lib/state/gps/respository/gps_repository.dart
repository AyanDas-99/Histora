import 'dart:async';

import 'package:histora/core/error/exception.dart';
import 'package:histora/state/gps/models/coordinate.dart';
import 'package:geolocator_android/geolocator_android.dart';

abstract class GpsRepository {
  /// Get current location as [Coordinate]
  ///
  /// Throws [GpsException] on error
  Future<Coordinate> getCurrentLocation();
}

class GpsRepositoryImpl implements GpsRepository {
  final GeolocatorAndroid geolocatorAndroid;

  GpsRepositoryImpl({required this.geolocatorAndroid});

  @override
  Future<Coordinate> getCurrentLocation() async {
    bool serviceEnabled = await geolocatorAndroid.isLocationServiceEnabled();
    if (!serviceEnabled) {
      try {
        final position = await geolocatorAndroid.getCurrentPosition();
        serviceEnabled = true;

        return (position.latitude, position.longitude);
      } catch (e) {
        throw GpsException('Accept location service request');
      }
    } else {
      final position = await geolocatorAndroid.getCurrentPosition();
      return (position.latitude, position.longitude);
    }
  }

  Future<Stream<Coordinate>> liveLocation() async {
    late StreamSubscription<Position> subscription;
    final controller = StreamController<Coordinate>(
      onCancel: () {
        subscription.cancel();
      },
    );

    bool serviceEnabled = await geolocatorAndroid.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw GpsException('Turn on location service');
    }

    LocationPermission permission = await geolocatorAndroid.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await geolocatorAndroid.requestPermission();

      if (permission == LocationPermission.denied) {
        throw GpsException('Permission denied');
      } else if (permission == LocationPermission.deniedForever) {
        throw GpsException(
            'Permission denied forever. Cannot request persmission');
      }
    }

    subscription = geolocatorAndroid.getPositionStream().listen((position) {
      controller.sink.add((position.latitude, position.longitude));
    });

    return controller.stream;
  }
}
