class MuhuratData {
  final DateTime rahuKaalStart;
  final DateTime rahuKaalEnd;
  final DateTime gulikaKaalStart;
  final DateTime gulikaKaalEnd;
  final DateTime yamagandaStart;
  final DateTime yamagandaEnd;
  final DateTime abhijitStart;
  final DateTime abhijitEnd;
  final DateTime brahmaMuhurtStart;
  final DateTime brahmaMuhurtEnd;

  MuhuratData({
    required this.rahuKaalStart,
    required this.rahuKaalEnd,
    required this.gulikaKaalStart,
    required this.gulikaKaalEnd,
    required this.yamagandaStart,
    required this.yamagandaEnd,
    required this.abhijitStart,
    required this.abhijitEnd,
    required this.brahmaMuhurtStart,
    required this.brahmaMuhurtEnd,
  });
}

class MuhuratEngine {
  // Rahu Kaal slot index per weekday (Sun=0 to Sat=6)
  // Slot order: day is divided into 8 equal parts, index = which part is Rahu
  static const List<int> rahuSlot  = [8, 2, 7, 5, 6, 4, 3]; // Sun..Sat
  static const List<int> gulikaSlot = [6, 5, 4, 3, 2, 1, 7];
  static const List<int> yamagandaSlot = [5, 4, 3, 2, 1, 7, 6];

  /// sunrise and sunset are local DateTime objects
  static MuhuratData calculate(DateTime sunrise, DateTime sunset, int weekday) {
    // weekday: DateTime.weekday → Mon=1..Sun=7, convert to Sun=0..Sat=6
    int day = weekday % 7; // Sun=0, Mon=1 ... Sat=6

    final dayDuration = sunset.difference(sunrise);
    final slotDuration = dayDuration ~/ 8; // divide day into 8 equal slots

    // --- Rahu Kaal ---
    final rahuStart = sunrise.add(slotDuration * rahuSlot[day]);
    final rahuEnd   = rahuStart.add(slotDuration);

    // --- Gulika Kaal ---
    final gulikaStart = sunrise.add(slotDuration * gulikaSlot[day]);
    final gulikaEnd   = gulikaStart.add(slotDuration);

    // --- Yamaganda ---
    final yamagandaStart = sunrise.add(slotDuration * yamagandaSlot[day]);
    final yamagandaEnd   = yamagandaStart.add(slotDuration);

    // --- Abhijit Muhurat ---
    // Middle of the day ± 24 minutes (approx 1 ghati = 24 min)
    final middleOfDay = sunrise.add(dayDuration ~/ 2);
    final abhijitStart = middleOfDay.subtract(const Duration(minutes: 24));
    final abhijitEnd   = middleOfDay.add(const Duration(minutes: 24));

    // --- Brahma Muhurat ---
    // 1 hour 36 minutes before sunrise (2 muhurats = 48 min before sunrise
    // actually starts 1h36m before and ends 48min before sunrise)
    final brahmaMuhurtStart = sunrise.subtract(const Duration(minutes: 96));
    final brahmaMuhurtEnd   = sunrise.subtract(const Duration(minutes: 48));

    return MuhuratData(
      rahuKaalStart: rahuStart,
      rahuKaalEnd: rahuEnd,
      gulikaKaalStart: gulikaStart,
      gulikaKaalEnd: gulikaEnd,
      yamagandaStart: yamagandaStart,
      yamagandaEnd: yamagandaEnd,
      abhijitStart: abhijitStart,
      abhijitEnd: abhijitEnd,
      brahmaMuhurtStart: brahmaMuhurtStart,
      brahmaMuhurtEnd: brahmaMuhurtEnd,
    );
  }
}