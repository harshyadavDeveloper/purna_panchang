import '../astronomy/astro_calculator.dart';

class PanchangData {
  final int tithiIndex;       // 1–30
  final String tithiName;
  final String tithiPaksha;   // Shukla / Krishna

  final int nakshatraIndex;   // 1–27
  final String nakshatraName;

  final int yogaIndex;        // 1–27
  final String yogaName;

  final int karanaIndex;      // 1–11
  final String karanaName;

  final String varaName;      // Weekday (Sanskrit)

  final DateTime date;

  PanchangData({
    required this.tithiIndex,
    required this.tithiName,
    required this.tithiPaksha,
    required this.nakshatraIndex,
    required this.nakshatraName,
    required this.yogaIndex,
    required this.yogaName,
    required this.karanaIndex,
    required this.karanaName,
    required this.varaName,
    required this.date,
  });
}

class PanchangEngine {
  static const List<String> tithiNames = [
    'Pratipada', 'Dwitiya', 'Tritiya', 'Chaturthi', 'Panchami',
    'Shashthi', 'Saptami', 'Ashtami', 'Navami', 'Dashami',
    'Ekadashi', 'Dwadashi', 'Trayodashi', 'Chaturdashi', 'Purnima / Amavasya',
  ];

  static const List<String> nakshatraNames = [
    'Ashwini', 'Bharani', 'Krittika', 'Rohini', 'Mrigashira',
    'Ardra', 'Punarvasu', 'Pushya', 'Ashlesha', 'Magha',
    'Purva Phalguni', 'Uttara Phalguni', 'Hasta', 'Chitra', 'Swati',
    'Vishakha', 'Anuradha', 'Jyeshtha', 'Mula', 'Purva Ashadha',
    'Uttara Ashadha', 'Shravana', 'Dhanishtha', 'Shatabhisha',
    'Purva Bhadrapada', 'Uttara Bhadrapada', 'Revati',
  ];

  static const List<String> yogaNames = [
    'Vishkambha', 'Priti', 'Ayushman', 'Saubhagya', 'Shobhana',
    'Atiganda', 'Sukarma', 'Dhriti', 'Shula', 'Ganda',
    'Vriddhi', 'Dhruva', 'Vyaghata', 'Harshana', 'Vajra',
    'Siddhi', 'Vyatipata', 'Variyana', 'Parigha', 'Shiva',
    'Siddha', 'Sadhya', 'Shubha', 'Shukla', 'Brahma',
    'Indra', 'Vaidhriti',
  ];

  static const List<String> karanaNames = [
    'Bava', 'Balava', 'Kaulava', 'Taitila', 'Garija',
    'Vanija', 'Vishti', 'Shakuni', 'Chatushpada', 'Naga', 'Kimstughna',
  ];

  static const List<String> varaNames = [
    'Ravivara',    // Sunday
    'Somavara',    // Monday
    'Mangalavara', // Tuesday
    'Budhavara',   // Wednesday
    'Guruvara',    // Thursday
    'Shukravara',  // Friday
    'Shanivara',   // Saturday
  ];

  /// Main method — pass local date + UTC offset in hours (e.g. 5.5 for IST)
  static PanchangData calculate(DateTime localDate, double utcOffsetHours) {
    // Panchang is calculated at sunrise — approximate as 6:00 AM local time
    final sunriseLocal = DateTime(
      localDate.year,
      localDate.month,
      localDate.day,
      6, 0, 0,
    );

    // Convert to UTC for astronomical calculations
    final offsetMinutes = (utcOffsetHours * 60).round();
    final utc = sunriseLocal.subtract(Duration(minutes: offsetMinutes));

    final sunLon = AstroCalculator.sunLongitude(utc);
    final moonLon = AstroCalculator.moonLongitude(utc);

    // --- Tithi ---
    // Moon - Sun longitude, each 12° = 1 tithi
    double tithiDeg = (moonLon - sunLon + 360) % 360;
    int tithiNum = (tithiDeg / 12).floor() + 1; // 1–30
    bool isShukla = tithiNum <= 15;
    int tithiInPaksha = isShukla ? tithiNum : tithiNum - 15;

    String tithiName;
    if (tithiNum == 15) {
      tithiName = 'Purnima';
    } else if (tithiNum == 30) {
      tithiName = 'Amavasya';
    } else {
      tithiName = tithiNames[(tithiInPaksha - 1).clamp(0, 14)];
    }

    // --- Nakshatra ---
    // Moon longitude / 13.333...° = nakshatra index
    int nakshatraIndex = (moonLon / (360.0 / 27)).floor(); // 0–26
    String nakshatraName = nakshatraNames[nakshatraIndex];

    // --- Yoga ---
    // (Sun + Moon) / 13.333...°
    double yogaDeg = (sunLon + moonLon) % 360;
    int yogaIndex = (yogaDeg / (360.0 / 27)).floor(); // 0–26
    String yogaName = yogaNames[yogaIndex];

    // --- Karana ---
    // Half-tithi: each tithi has 2 karanas
    // tithiDeg / 6 gives karana number (0-based)
    int karanaSeq = (tithiDeg / 6).floor(); // 0–59
    int karanaIndex;
    if (karanaSeq == 0) {
      karanaIndex = 10; // Kimstughna (fixed, always first karana of Shukla 1)
    } else if (karanaSeq >= 57) {
      // Last 3 fixed karanas
      karanaIndex = 8 + (karanaSeq - 57); // Chatushpada, Naga, Kimstughna
    } else {
      karanaIndex = ((karanaSeq - 1) % 7); // Rotating 7 movable karanas
    }
    karanaIndex = karanaIndex.clamp(0, 10);
    String karanaName = karanaNames[karanaIndex];

    // --- Vara (weekday) ---
    int weekday = localDate.weekday % 7; // Dart: Mon=1..Sun=7, we want Sun=0
    String varaName = varaNames[weekday];

    return PanchangData(
      tithiIndex: tithiNum,
      tithiName: tithiName,
      tithiPaksha: isShukla ? 'Shukla Paksha' : 'Krishna Paksha',
      nakshatraIndex: nakshatraIndex + 1,
      nakshatraName: nakshatraName,
      yogaIndex: yogaIndex + 1,
      yogaName: yogaName,
      karanaIndex: karanaIndex + 1,
      karanaName: karanaName,
      varaName: varaName,
      date: localDate,
    );
  }
}