import 'dart:math';
import 'package:histora/state/gps/models/coordinate.dart';

class RADII {
  int km;
  int mile;
  int meter;
  int nmi;

  RADII(this.km, this.mile, this.meter, this.nmi);
}

enum Unit { KM, MILE, METER, NMI }

class HaversineDistance {
  final RADII radii = RADII(6371, 3960, 6371000, 3440);

  double toRad(double num) {
    return num * pi / 180;
  }

  int getUnit(Unit unit) {
    switch (unit) {
      case (Unit.KM):
        return radii.km;
      case (Unit.MILE):
        return radii.mile;
      case (Unit.METER):
        return radii.meter;
      case (Unit.NMI):
        return radii.nmi;
      default:
        return radii.km;
    }
  }

  double haversine(
      Coordinate startCoordinates, Coordinate endCoordinates, Unit unit) {
    final R = getUnit(unit);
    final dLat = toRad(endCoordinates.$1 - startCoordinates.$1);
    final dLon = toRad(endCoordinates.$2 - startCoordinates.$2);
    final lat1 = toRad(startCoordinates.$1);
    final lat2 = toRad(endCoordinates.$1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c;
  }
}
