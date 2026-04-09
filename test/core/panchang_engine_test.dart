import 'package:flutter_test/flutter_test.dart';
import 'package:purna_panchang/core/panchang/panchang_engine.dart';

void main() {
  test('Panchang for today (IST)', () {
    final today = DateTime(2025, 4, 9);
    final result = PanchangEngine.calculate(today, 5.5);

    print('--- Panchang for ${result.date} ---');
    print('Vara      : ${result.varaName}');
    print('Tithi     : ${result.tithiName} (${result.tithiPaksha}) [#${result.tithiIndex}]');
    print('Nakshatra : ${result.nakshatraName} [#${result.nakshatraIndex}]');
    print('Yoga      : ${result.yogaName} [#${result.yogaIndex}]');
    print('Karana    : ${result.karanaName} [#${result.karanaIndex}]');

    expect(result.tithiIndex, greaterThanOrEqualTo(1));
    expect(result.tithiIndex, lessThanOrEqualTo(30));
    expect(result.nakshatraIndex, greaterThanOrEqualTo(1));
    expect(result.nakshatraIndex, lessThanOrEqualTo(27));
    expect(result.yogaIndex, greaterThanOrEqualTo(1));
    expect(result.yogaIndex, lessThanOrEqualTo(27));
  });
}