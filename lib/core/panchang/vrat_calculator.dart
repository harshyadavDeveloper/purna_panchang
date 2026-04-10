import 'panchang_engine.dart';

class VratInfo {
  final String name;
  final String nameHindi;
  final String description;
  final bool isMajor; // major = highlighted prominently

  const VratInfo({
    required this.name,
    required this.nameHindi,
    required this.description,
    required this.isMajor,
  });
}

class VratCalculator {
  /// Returns list of vrats/fasts for a given panchang
  static List<VratInfo> getVrats(PanchangData p) {
    final vrats = <VratInfo>[];
    final tithi = p.tithiIndex;
    final vara = p.varaName;

    // ── Tithi based vrats ──────────────────────────────────────

    if (tithi == 1) {
      vrats.add(const VratInfo(
        name: 'Pratipada',
        nameHindi: 'प्रतिपदा',
        description: 'First lunar day',
        isMajor: false,
      ));
    }

    if (tithi == 4 || tithi == 19) {
      vrats.add(const VratInfo(
        name: 'Vinayaka Chaturthi',
        nameHindi: 'विनायक चतुर्थी',
        description: 'Fast for Lord Ganesha',
        isMajor: true,
      ));
    }

    if (tithi == 9 || tithi == 24) {
      vrats.add(const VratInfo(
        name: 'Navami',
        nameHindi: 'नवमी',
        description: 'Auspicious ninth lunar day',
        isMajor: false,
      ));
    }

    if (tithi == 11 || tithi == 26) {
      vrats.add(const VratInfo(
        name: 'Ekadashi',
        nameHindi: 'एकादशी',
        description: 'Fast for Lord Vishnu — avoid grains',
        isMajor: true,
      ));
    }

    if (tithi == 13 || tithi == 28) {
      vrats.add(const VratInfo(
        name: 'Pradosh Vrat',
        nameHindi: 'प्रदोष व्रत',
        description: 'Evening fast for Lord Shiva',
        isMajor: true,
      ));
    }

    if (tithi == 14 || tithi == 29) {
      vrats.add(const VratInfo(
        name: 'Chaturdashi',
        nameHindi: 'चतुर्दशी',
        description: 'Fourteenth lunar day — Shiva worship',
        isMajor: false,
      ));
    }

    if (tithi == 15) {
      vrats.add(const VratInfo(
        name: 'Purnima Vrat',
        nameHindi: 'पूर्णिमा व्रत',
        description: 'Full moon fast — highly auspicious',
        isMajor: true,
      ));
    }

    if (tithi == 30) {
      vrats.add(const VratInfo(
        name: 'Amavasya',
        nameHindi: 'अमावस्या',
        description: 'New moon — ancestor worship day',
        isMajor: true,
      ));
    }

    // ── Vara (weekday) based vrats ─────────────────────────────

    if (vara == 'Somavara') {
      vrats.add(const VratInfo(
        name: 'Somavar Vrat',
        nameHindi: 'सोमवार व्रत',
        description: 'Monday fast for Lord Shiva',
        isMajor: false,
      ));
    }

    if (vara == 'Mangalavara') {
      vrats.add(const VratInfo(
        name: 'Mangalavar Vrat',
        nameHindi: 'मंगलवार व्रत',
        description: 'Tuesday fast for Lord Hanuman',
        isMajor: false,
      ));
    }

    if (vara == 'Guruvara') {
      vrats.add(const VratInfo(
        name: 'Guruvar Vrat',
        nameHindi: 'गुरुवार व्रत',
        description: 'Thursday fast for Lord Vishnu & Brihaspati',
        isMajor: false,
      ));
    }

    if (vara == 'Shanivara') {
      vrats.add(const VratInfo(
        name: 'Shanivar Vrat',
        nameHindi: 'शनिवार व्रत',
        description: 'Saturday fast for Lord Shani',
        isMajor: false,
      ));
    }

    // ── Special combos ─────────────────────────────────────────

    if (vara == 'Somavara' && (tithi == 14 || tithi == 29)) {
      vrats.add(const VratInfo(
        name: 'Shiva Pradosh',
        nameHindi: 'शिव प्रदोष',
        description: 'Most powerful Pradosh — Monday + Trayodashi',
        isMajor: true,
      ));
    }

    if (vara == 'Shanivara' && (tithi == 14 || tithi == 29)) {
      vrats.add(const VratInfo(
        name: 'Shani Pradosh',
        nameHindi: 'शनि प्रदोष',
        description: 'Shani Pradosh — Saturday + Trayodashi',
        isMajor: true,
      ));
    }

    return vrats;
  }
}