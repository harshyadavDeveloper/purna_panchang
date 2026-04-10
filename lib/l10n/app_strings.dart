import '../providers/language_provider.dart';

class AppStrings {
  final AppLanguage lang;
  const AppStrings(this.lang);

  bool get isHindi => lang == AppLanguage.hindi;

  // ── App general ───────────────────────────────────────────
  String get appName        => isHindi ? 'पूर्ण पंचांग'         : 'Purna Panchang';
  String get appSubtitle    => isHindi ? 'संपूर्ण वैदिक पंचांग' : 'Complete Vedic Calendar';
  String get today          => isHindi ? 'आज'                   : 'Today';
  String get tapToPickDate  => isHindi ? 'तिथि चुनें'           : 'Tap to pick date';
  String get selectCity     => isHindi ? 'शहर चुनें'            : 'Select City';
  String get searchCity     => isHindi ? 'शहर या राज्य खोजें...' : 'Search city or state...';
  String get share          => isHindi ? 'साझा करें'            : 'Share';
  String get advertisement  => isHindi ? 'विज्ञापन'             : 'Advertisement';

  // ── Bottom nav ────────────────────────────────────────────
  String get navPanchang    => isHindi ? 'पंचांग'    : 'Panchang';
  String get navCalendar    => isHindi ? 'कैलेंडर'   : 'Calendar';

  // ── Panchang card ─────────────────────────────────────────
  String get panchang       => isHindi ? 'पञ्चाङ्ग'  : 'Panchang';
  String get vara           => isHindi ? 'वार'        : 'Vara';
  String get varaEn         => isHindi ? 'वार'        : 'Weekday';
  String get tithi          => isHindi ? 'तिथि'       : 'Tithi';
  String get tithiEn        => isHindi ? 'तिथि'       : 'Lunar Day';
  String get nakshatra      => isHindi ? 'नक्षत्र'    : 'Nakshatra';
  String get nakshatraEn    => isHindi ? 'नक्षत्र'    : 'Lunar Mansion';
  String get yoga           => isHindi ? 'योग'        : 'Yoga';
  String get yogaEn         => isHindi ? 'योग'        : 'Luni-Solar Yoga';
  String get karana         => isHindi ? 'करण'        : 'Karana';
  String get karanaEn       => isHindi ? 'करण'        : 'Half Tithi';

  // ── Sunrise/Sunset ────────────────────────────────────────
  String get sunriseSunset  => isHindi ? 'सूर्योदय / सूर्यास्त' : 'Sunrise & Sunset';
  String get sunrise        => isHindi ? 'सूर्योदय'  : 'Sunrise';
  String get sunset         => isHindi ? 'सूर्यास्त'  : 'Sunset';

  // ── Muhurat ───────────────────────────────────────────────
  String get muhurat        => isHindi ? 'मुहूर्त'          : 'Muhurat';
  String get muhuratTitle   => isHindi ? 'मुहूर्त समय'       : 'Muhurat Timings';
  String get brahmaMuhurat  => isHindi ? 'ब्रह्म मुहूर्त'    : 'Brahma Muhurat';
  String get abhijitMuhurat => isHindi ? 'अभिजित मुहूर्त'   : 'Abhijit Muhurat';
  String get rahuKaal       => isHindi ? 'राहु काल'          : 'Rahu Kaal';
  String get gulikaKaal     => isHindi ? 'गुलिका काल'        : 'Gulika Kaal';
  String get yamaganda      => isHindi ? 'यमगण्ड'           : 'Yamaganda';
  String get auspicious     => isHindi ? '✓ शुभ'            : '✓ Auspicious';
  String get avoid          => isHindi ? '✗ वर्जित'          : '✗ Avoid';

  // ── Samvat & Vrat ─────────────────────────────────────────
  String get samvatVrat     => isHindi ? 'संवत् & व्रत'      : 'Samvat & Vrat';
  String get samvatVratEn   => isHindi ? 'संवत् & व्रत'      : 'Samvat & Vrat';
  String get vikramSamvat   => isHindi ? 'विक्रम संवत्'      : 'Vikram Samvat';
  String get shakaSamvat    => isHindi ? 'शक संवत्'          : 'Shaka Samvat';
  String get gujaratiSamvat => isHindi ? 'गुजराती संवत्'     : 'Gujarati Samvat';
  String get noVratToday    => isHindi ? 'आज कोई व्रत नहीं'  : 'No vrat today';
  String get major          => isHindi ? 'प्रमुख'            : 'Major';

  // ── Calendar ──────────────────────────────────────────────
  String get calendarTitle  => isHindi ? 'पंचांग कैलेंडर'    : 'Panchang Calendar';
  String get festivalsTitle => isHindi ? 'त्योहार & उत्सव'   : 'Festivals & Events';

  // ── Weekday names ─────────────────────────────────────────
  String weekday(String vara) {
    if (!isHindi) return vara;
    const map = {
      'Ravivara'    : 'रविवार',
      'Somavara'    : 'सोमवार',
      'Mangalavara' : 'मंगलवार',
      'Budhavara'   : 'बुधवार',
      'Guruvara'    : 'गुरुवार',
      'Shukravara'  : 'शुक्रवार',
      'Shanivara'   : 'शनिवार',
    };
    return map[vara] ?? vara;
  }

  // ── Paksha ────────────────────────────────────────────────
  String paksha(String paksha) {
    if (!isHindi) return paksha;
    return paksha == 'Shukla Paksha' ? 'शुक्ल पक्ष' : 'कृष्ण पक्ष';
  }

  // ── Tithi names ───────────────────────────────────────────
  String tithiName(String name) {
    if (!isHindi) return name;
    const map = {
      'Pratipada'    : 'प्रतिपदा',
      'Dwitiya'      : 'द्वितीया',
      'Tritiya'      : 'तृतीया',
      'Chaturthi'    : 'चतुर्थी',
      'Panchami'     : 'पंचमी',
      'Shashthi'     : 'षष्ठी',
      'Saptami'      : 'सप्तमी',
      'Ashtami'      : 'अष्टमी',
      'Navami'       : 'नवमी',
      'Dashami'      : 'दशमी',
      'Ekadashi'     : 'एकादशी',
      'Dwadashi'     : 'द्वादशी',
      'Trayodashi'   : 'त्रयोदशी',
      'Chaturdashi'  : 'चतुर्दशी',
      'Purnima'      : 'पूर्णिमा',
      'Amavasya'     : 'अमावस्या',
    };
    return map[name] ?? name;
  }

  // ── Nakshatra names ───────────────────────────────────────
  String nakshatraName(String name) {
    if (!isHindi) return name;
    const map = {
      'Ashwini'           : 'अश्विनी',
      'Bharani'           : 'भरणी',
      'Krittika'          : 'कृत्तिका',
      'Rohini'            : 'रोहिणी',
      'Mrigashira'        : 'मृगशिरा',
      'Ardra'             : 'आर्द्रा',
      'Punarvasu'         : 'पुनर्वसु',
      'Pushya'            : 'पुष्य',
      'Ashlesha'          : 'आश्लेषा',
      'Magha'             : 'मघा',
      'Purva Phalguni'    : 'पूर्व फाल्गुनी',
      'Uttara Phalguni'   : 'उत्तर फाल्गुनी',
      'Hasta'             : 'हस्त',
      'Chitra'            : 'चित्रा',
      'Swati'             : 'स्वाती',
      'Vishakha'          : 'विशाखा',
      'Anuradha'          : 'अनुराधा',
      'Jyeshtha'          : 'ज्येष्ठा',
      'Mula'              : 'मूल',
      'Purva Ashadha'     : 'पूर्व आषाढ़',
      'Uttara Ashadha'    : 'उत्तर आषाढ़',
      'Shravana'          : 'श्रवण',
      'Dhanishtha'        : 'धनिष्ठा',
      'Shatabhisha'       : 'शतभिषा',
      'Purva Bhadrapada'  : 'पूर्व भाद्रपद',
      'Uttara Bhadrapada' : 'उत्तर भाद्रपद',
      'Revati'            : 'रेवती',
    };
    return map[name] ?? name;
  }

  // ── Yoga names ────────────────────────────────────────────
  String yogaName(String name) {
    if (!isHindi) return name;
    const map = {
      'Vishkambha' : 'विष्कम्भ', 'Priti'     : 'प्रीति',
      'Ayushman'   : 'आयुष्मान', 'Saubhagya' : 'सौभाग्य',
      'Shobhana'   : 'शोभन',     'Atiganda'  : 'अतिगण्ड',
      'Sukarma'    : 'सुकर्मा',  'Dhriti'    : 'धृति',
      'Shula'      : 'शूल',      'Ganda'     : 'गण्ड',
      'Vriddhi'    : 'वृद्धि',   'Dhruva'    : 'ध्रुव',
      'Vyaghata'   : 'व्याघात',  'Harshana'  : 'हर्षण',
      'Vajra'      : 'वज्र',     'Siddhi'    : 'सिद्धि',
      'Vyatipata'  : 'व्यतीपात', 'Variyana'  : 'वरीयान',
      'Parigha'    : 'परिघ',     'Shiva'     : 'शिव',
      'Siddha'     : 'सिद्ध',    'Sadhya'    : 'साध्य',
      'Shubha'     : 'शुभ',      'Shukla'    : 'शुक्ल',
      'Brahma'     : 'ब्रह्म',   'Indra'     : 'ऐन्द्र',
      'Vaidhriti'  : 'वैधृति',
    };
    return map[name] ?? name;
  }

  // ── Karana names ──────────────────────────────────────────
  String karanaName(String name) {
    if (!isHindi) return name;
    const map = {
      'Bava'        : 'बव',       'Balava'      : 'बालव',
      'Kaulava'     : 'कौलव',     'Taitila'     : 'तैतिल',
      'Garija'      : 'गरज',      'Vanija'      : 'वणिज',
      'Vishti'      : 'विष्टि',   'Shakuni'     : 'शकुनि',
      'Chatushpada' : 'चतुष्पाद', 'Naga'        : 'नाग',
      'Kimstughna'  : 'किंस्तुघ्न',
    };
    return map[name] ?? name;
  }
}