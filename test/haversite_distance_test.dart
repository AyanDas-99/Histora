import 'package:flutter_test/flutter_test.dart';
import 'package:histora/state/gps/utils/haversine_distance.dart';

void main() {
  test(
      'should calculate distance between two coordinates when less than 200 mtrs, ',
      () async {
    // arrange
    final haversine = HaversineDistance();
    // act
    final distance = haversine.haversine((11.668691, 92.7470291), (11.6651148, 92.7531003), Unit.METER);
    // assert
    expect(true, distance <= 200);
  });
}
