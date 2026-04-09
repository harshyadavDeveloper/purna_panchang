import 'package:flutter_test/flutter_test.dart';
import 'package:purna_panchang/core/astronomy/astro_calculator.dart';

void main() {
  test('Sun longitude on 2000-01-01 should be ~280°', () {
    final dt = DateTime.utc(2000, 1, 1, 12, 0, 0);
    final sunLon = AstroCalculator.sunLongitude(dt);
    print('Sun longitude: $sunLon°');
    // J2000 epoch — Sun near 280°
    expect(sunLon, greaterThan(279.0));
    expect(sunLon, lessThan(282.0));
  });

  test('Moon longitude should be between 0–360', () {
    final dt = DateTime.utc(2024, 4, 9, 12, 0, 0);
    final moonLon = AstroCalculator.moonLongitude(dt);
    print('Moon longitude: $moonLon°');
    expect(moonLon, greaterThanOrEqualTo(0.0));
    expect(moonLon, lessThan(360.0));
  });

  test('Julian day for J2000 epoch should be 2451545.0', () {
    final dt = DateTime.utc(2000, 1, 1, 12, 0, 0);
    final jd = AstroCalculator.julianDay(dt);
    print('JD: $jd');
    expect(jd, closeTo(2451545.0, 0.001));
  });
}