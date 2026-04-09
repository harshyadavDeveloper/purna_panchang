import 'package:flutter_test/flutter_test.dart';
import 'package:purna_panchang/core/muhurat/muhurat_engine.dart';

void main() {
  test('Muhurat for Wednesday (Budhavara) with typical IST sunrise/sunset', () {
    // Approximate Delhi sunrise/sunset on a typical April day
    final sunrise = DateTime(2025, 4, 9, 6, 3);  // 6:03 AM
    final sunset  = DateTime(2025, 4, 9, 18, 44); // 6:44 PM

    // Wednesday = DateTime.wednesday = 3
    final result = MuhuratEngine.calculate(sunrise, sunset, DateTime.wednesday);

    String fmt(DateTime dt) =>
        '${dt.hour.toString().padLeft(2,'0')}:${dt.minute.toString().padLeft(2,'0')}';

    print('Brahma Muhurat : ${fmt(result.brahmaMuhurtStart)} - ${fmt(result.brahmaMuhurtEnd)}');
    print('Rahu Kaal      : ${fmt(result.rahuKaalStart)} - ${fmt(result.rahuKaalEnd)}');
    print('Gulika Kaal    : ${fmt(result.gulikaKaalStart)} - ${fmt(result.gulikaKaalEnd)}');
    print('Yamaganda      : ${fmt(result.yamagandaStart)} - ${fmt(result.yamagandaEnd)}');
    print('Abhijit Muhurat: ${fmt(result.abhijitStart)} - ${fmt(result.abhijitEnd)}');

    // Rahu on Wednesday = slot 5 → roughly afternoon
    expect(result.rahuKaalStart.hour, greaterThanOrEqualTo(12));
    expect(result.rahuKaalEnd.isAfter(result.rahuKaalStart), isTrue);
    expect(result.abhijitStart.isBefore(result.abhijitEnd), isTrue);
  });
}