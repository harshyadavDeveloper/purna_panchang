class SamvatInfo {
  final int vikramSamvat;
  final String vikramYear;   // Sanskrit year name
  final int shakaSamvat;
  final int gujaratiSamvat;

  const SamvatInfo({
    required this.vikramSamvat,
    required this.vikramYear,
    required this.shakaSamvat,
    required this.gujaratiSamvat,
  });
}

class SamvatCalculator {
  // 60 Sanskrit year names (Shashtyabdi cycle)
  static const List<String> _yearNames = [
    'Prabhava', 'Vibhava', 'Shukla', 'Pramodoota', 'Prajapati',
    'Aangirasa', 'Shrimukha', 'Bhava', 'Yuva', 'Dhaatu',
    'Eeshvara', 'Bahudhanya', 'Pramaadi', 'Vikrama', 'Vrisha',
    'Chitrabhanu', 'Subhanu', 'Tarana', 'Paarthiva', 'Vyaya',
    'Sarvajit', 'Sarvadhari', 'Virodhi', 'Vikriti', 'Khara',
    'Nandana', 'Vijaya', 'Jaya', 'Manmatha', 'Durmukhi',
    'Hevilambi', 'Vilambi', 'Vikaari', 'Shaarvari', 'Plava',
    'Shubhakruti', 'Shobhakruti', 'Krodhi', 'Vishvavasu', 'Parabhava',
    'Plavanga', 'Keelaka', 'Saumya', 'Sadhaarana', 'Virodhikritu',
    'Paridhavi', 'Pramaadeecha', 'Aananda', 'Raakshasa', 'Nala',
    'Pingala', 'Kaalayukti', 'Siddharthi', 'Raudra', 'Durmati',
    'Dundubhi', 'Rudhirodgaari', 'Raktaakshi', 'Krodhana', 'Akshaya',
  ];

  static SamvatInfo calculate(DateTime date) {
    // Vikram Samvat starts mid-April (after Chaitra Shukla Pratipada)
    // Simplified: add 57 before mid-April, 56 after (approximate)
    int vikram;
    if (date.month > 4 || (date.month == 4 && date.day >= 14)) {
      vikram = date.year + 57;
    } else {
      vikram = date.year + 56;
    }

    // Shaka Samvat = Gregorian year - 78 (starts ~March 22)
    int shaka;
    if (date.month > 3 || (date.month == 3 && date.day >= 22)) {
      shaka = date.year - 78;
    } else {
      shaka = date.year - 79;
    }

    // Gujarati Samvat = Vikram - 1 (starts day after Diwali, roughly)
    int gujarati = vikram - 1;

    // Sanskrit year name from Vikram Samvat mod 60
    String yearName = _yearNames[(vikram - 1) % 60];

    return SamvatInfo(
      vikramSamvat: vikram,
      vikramYear: yearName,
      shakaSamvat: shaka,
      gujaratiSamvat: gujarati,
    );
  }
}