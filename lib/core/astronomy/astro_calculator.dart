import 'dart:math';

class AstroCalculator {
  // Convert degrees to radians
  static double toRad(double deg) => deg * pi / 180.0;

  // Convert radians to degrees
  static double toDeg(double rad) => rad * 180.0 / pi;

  // Normalize degrees to 0–360
  static double norm360(double deg) => ((deg % 360) + 360) % 360;

  /// Returns Julian Day Number for a given UTC DateTime
  static double julianDay(DateTime utc) {
    int y = utc.year;
    int m = utc.month;
    double d =
        utc.day + utc.hour / 24.0 + utc.minute / 1440.0 + utc.second / 86400.0;

    if (m <= 2) {
      y -= 1;
      m += 12;
    }

    int a = (y / 100).floor();
    int b = 2 - a + (a / 4).floor();

    return (365.25 * (y + 4716)).floor() +
        (30.6001 * (m + 1)).floor() +
        d +
        b -
        1524.5;
  }

  /// Julian centuries from J2000.0
  static double julianCenturies(double jd) => (jd - 2451545.0) / 36525.0;

  /// Sun's ecliptic longitude in degrees (low-precision, good to ~0.01°)
  static double sunLongitude(DateTime utc) {
    final jd = julianDay(utc);
    final T = julianCenturies(jd);

    // Geometric mean longitude of Sun
    double L0 = norm360(280.46646 + 36000.76983 * T);

    // Mean anomaly of Sun
    double M = norm360(357.52911 + 35999.05029 * T - 0.0001537 * T * T);
    double Mrad = toRad(M);

    // Equation of centre
    double C =
        (1.914602 - 0.004817 * T - 0.000014 * T * T) * sin(Mrad) +
        (0.019993 - 0.000101 * T) * sin(2 * Mrad) +
        0.000289 * sin(3 * Mrad);

    // Sun's true longitude
    double sunLon = L0 + C;

    // Apparent longitude (aberration correction)
    double omega = norm360(125.04 - 1934.136 * T);
    sunLon = sunLon - 0.00569 - 0.00478 * sin(toRad(omega));

    return norm360(sunLon);
  }

  /// Moon's ecliptic longitude in degrees
  static double moonLongitude(DateTime utc) {
    final jd = julianDay(utc);
    final T = julianCenturies(jd);

    // Moon's mean longitude
    double Lp = norm360(218.3164477 + 481267.88123421 * T);

    // Mean elongation
    double D = norm360(297.8501921 + 445267.1114034 * T);

    // Sun's mean anomaly
    double M = norm360(357.5291092 + 35999.0502909 * T);

    // Moon's mean anomaly
    double Mp = norm360(134.9633964 + 477198.8675055 * T);

    // Moon's argument of latitude
    double F = norm360(93.2720950 + 483202.0175233 * T);

    double Drad = toRad(D);
    double Mrad = toRad(M);
    double Mprad = toRad(Mp);
    double Frad = toRad(F);

    // Longitude correction (major terms only — sufficient for Panchang)
    double dL =
        6288774 * sin(Mprad) +
        1274027 * sin(2 * Drad - Mprad) +
        658314 * sin(2 * Drad) +
        213618 * sin(2 * Mprad) +
        -185116 * sin(Mrad) +
        -114332 * sin(2 * Frad) +
        58793 * sin(2 * Drad - 2 * Mprad) +
        57066 * sin(2 * Drad - Mrad - Mprad) +
        53322 * sin(2 * Drad + Mprad) +
        45758 * sin(2 * Drad - Mrad) +
        -40923 * sin(Mrad - Mprad) +
        -34720 * sin(Drad) +
        -30383 * sin(Mrad + Mprad);

    // dL is in units of 1/1,000,000 degree
    double moonLon = Lp + dL / 1000000.0;

    return norm360(moonLon);
  }
}
