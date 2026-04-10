# 🕉 पूर्ण पंचांग — Purna Panchang

> **Complete Vedic Calendar — Built with Flutter**

A full-featured, offline-first Hindu Panchang app for Android. Computes all five Panchang elements astronomically on-device — no API, no internet dependency, works anywhere.

---


---

## ✨ Features

### 🔭 Core Panchang (Computed On-Device)
All calculations use Surya Siddhanta-based astronomical algorithms — the same mathematics used in traditional printed Panchangs.

| Element | Description | Algorithm |
|---------|-------------|-----------|
| **Vara** | Weekday with Sanskrit name | Based on Julian Day |
| **Tithi** | Lunar day (1–30) with Paksha | Moon − Sun longitude ÷ 12° |
| **Nakshatra** | Moon's position in 27 star mansions | Moon longitude ÷ 13°20' |
| **Yoga** | Luni-solar combination (27 types) | (Sun + Moon) longitude ÷ 13°20' |
| **Karana** | Half-tithi period (11 types) | Half of Tithi calculation |

### ⏰ Muhurat Timings
Daily auspicious and inauspicious time windows:

- 🌄 **Brahma Muhurat** — Most auspicious morning window (1h36m before sunrise)
- ✨ **Abhijit Muhurat** — Midday auspicious window (±24 min from solar noon)
- 🚫 **Rahu Kaal** — Inauspicious period (weekday-indexed, ~1.5 hours)
- 🚫 **Gulika Kaal** — Secondary inauspicious period
- 🚫 **Yamaganda** — Third inauspicious window

### 📅 Samvat (Traditional Year Systems)
- **Vikram Samvat** with 60-year Sanskrit cycle name (Prabhava → Akshaya)
- **Shaka Samvat** — Official Indian national calendar era
- **Gujarati Samvat** — Regional calendar used in Gujarat

### 🙏 Vrat & Fast Detection
Automatically detects fasts and observances from Tithi + Vara:

**Tithi-based:** Ekadashi, Pradosh Vrat, Purnima, Amavasya, Chaturthi, Navami, and more

**Weekday-based:** Somavar (Shiva), Mangalavar (Hanuman), Guruvara (Vishnu), Shanivara (Shani)

**Special combinations:** Shani Pradosh, Shiva Pradosh, and other composite vrats

Major vrats are highlighted with 🪔 badge, minor with 🙏

### 🗓 Festival Calendar
40+ pre-loaded festivals for the year including:
- Major Hindu festivals (Diwali, Holi, Navratri, Ganesh Chaturthi, Janmashtami...)
- Regional festivals (Pongal, Ugadi, Onam, Baisakhi, Gudi Padwa...)
- National holidays (Republic Day, Independence Day, Gandhi Jayanti...)
- Green dot markers on calendar for festival dates

### 🌐 Bilingual — English / Hindi
Full EN ↔ हि toggle persistent across sessions:
- All UI labels, titles, and navigation
- All 27 Nakshatra names in Hindi
- All 27 Yoga names in Hindi
- All 16 Tithi names in Hindi
- All 11 Karana names in Hindi
- Weekday names, Paksha names, Muhurat names
- Date display format switches language too

### 📍 Manual City Selection
50+ Indian cities with accurate coordinates:
- Searchable by city name or state
- Covers all major states: Maharashtra, Gujarat, Rajasthan, UP, Karnataka, Tamil Nadu, Kerala, Bengal, Punjab, and more
- Sunrise/sunset times adjusted per city latitude
- Selection persists across app restarts

### 📤 Share Panchang
One-tap WhatsApp-ready share with:
- Full 5-element Panchang summary
- All Muhurat timings
- Samvat year
- Vrats and festivals for the day
- Formatted with emojis and bold headings

### 📢 AdMob Ready
50px banner slot reserved above bottom navigation bar. Clearly commented TODO for integration — swap one widget when ready.

---

## 🏗 Project Structure

```
purna_panchang/
├── lib/
│   ├── main.dart                        # App entry, ProviderScope, RootScreen
│   ├── theme/
│   │   └── app_theme.dart               # Saffron theme, colors, typography
│   ├── core/
│   │   ├── astronomy/
│   │   │   └── astro_calculator.dart    # Sun/Moon longitude, Julian Day
│   │   ├── panchang/
│   │   │   ├── panchang_engine.dart     # Tithi, Nakshatra, Yoga, Karana, Vara
│   │   │   ├── vrat_calculator.dart     # Vrat/fast detection logic
│   │   │   └── samvat_calculator.dart   # Vikram, Shaka, Gujarati Samvat
│   │   └── muhurat/
│   │       └── muhurat_engine.dart      # Rahu Kaal, Gulika, Abhijit etc.
│   ├── data/
│   │   ├── cities.dart                  # 50+ cities with lat/lon/sunrise
│   │   └── festivals.dart               # 40+ festivals with Hindi names
│   ├── providers/
│   │   ├── city_provider.dart           # Selected city (persisted)
│   │   └── language_provider.dart       # EN/HI toggle (persisted)
│   ├── l10n/
│   │   └── app_strings.dart             # All UI strings in EN + HI
│   ├── screens/
│   │   ├── home_screen.dart             # Main Panchang view
│   │   ├── calendar_screen.dart         # Monthly calendar + festivals
│   │   └── city_picker_screen.dart      # Searchable city selector
│   └── widgets/
│       ├── panchang_card.dart           # 5-element Panchang card
│       ├── samvat_vrat_card.dart        # Samvat years + Vrat list
│       ├── language_toggle.dart         # EN | हि pill button
│       └── share_helper.dart            # Share sheet formatter
└── test/
    └── core/
        ├── astro_calculator_test.dart   # Sun/Moon longitude tests
        ├── panchang_engine_test.dart    # Tithi/Nakshatra/Yoga tests
        └── muhurat_engine_test.dart     # Rahu Kaal timing tests
```

---

## 🧮 Calculation Architecture

### Astronomy Core
```
DateTime (local) → UTC → Julian Day Number → Julian Centuries (T)
                                          ↓
                              Sun Longitude (ecliptic)
                              Moon Longitude (ecliptic, 13 major terms)
```

### Panchang Engine
```
Sun Longitude + Moon Longitude
        ↓
Tithi    = (Moon − Sun) / 12°          → 1–30
Nakshatra = Moon / 13.333°             → 1–27
Yoga     = (Moon + Sun) / 13.333°      → 1–27
Karana   = Tithi × 2 (half-tithi seq)  → 1–11
Vara     = weekday of local date       → 1–7
```

### Muhurat Engine
```
Sunrise + Sunset → Day Duration → ÷ 8 slots
Rahu Kaal slot index: [8,2,7,5,6,4,3] for Sun–Sat
Gulika slot index:    [6,5,4,3,2,1,7]
Yamaganda slot index: [5,4,3,2,1,7,6]
Abhijit = Solar noon ± 24 minutes
Brahma Muhurat = Sunrise − 96min to Sunrise − 48min
```

---

## 📦 Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_riverpod` | ^3.x | State management |
| `shared_preferences` | ^2.x | Persist city + language selection |
| `table_calendar` | ^3.x | Monthly calendar widget |
| `share_plus` | ^10.x | Native share sheet |

No external API dependencies. All calculations are pure Dart.

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.x+
- Dart SDK 3.x+
- Android Studio / VS Code

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/purna_panchang.git
cd purna_panchang

# Install dependencies
flutter pub get

# Run tests
flutter test

# Run the app
flutter run
```

### Running Tests

```bash
# All tests
flutter test

# Specific test files
flutter test test/core/astro_calculator_test.dart
flutter test test/core/panchang_engine_test.dart
flutter test test/core/muhurat_engine_test.dart
```

---

## 🏪 Play Store Preparation

### Before Release Checklist
- [ ] Update `version` in `pubspec.yaml` (e.g. `1.0.0+1`)
- [ ] Set `applicationId` in `android/app/build.gradle`
- [ ] Add app icon (`flutter_launcher_icons` package)
- [ ] Add splash screen (`flutter_native_splash` package)
- [ ] Set `minSdkVersion` to 21 in `android/app/build.gradle`
- [ ] Build release APK: `flutter build appbundle --release`
- [ ] Test on physical device before submission

### AdMob Integration (When Ready)
```bash
flutter pub add google_mobile_ads
```

1. Add App ID to `android/app/src/main/AndroidManifest.xml`:
```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX"/>
```

2. In `main.dart`, initialize AdMob:
```dart
await MobileAds.instance.initialize();
```

3. Replace `AdBannerPlaceholder` in `main.dart` with real `BannerAd` widget.

---

## 🗺 Roadmap

### v1.1
- [ ] Choghadiya (8 daily time slots)
- [ ] Actual sunrise calculation from lat/lon (replacing static approximation)
- [ ] Ayanamsa correction (Lahiri) for sidereal accuracy

### v1.2
- [ ] Push notifications for Ekadashi, Purnima reminders
- [ ] Widget (home screen glanceable Panchang)
- [ ] More regional languages (Marathi, Gujarati, Tamil, Telugu)

### v2.0
- [ ] Kundli / birth chart
- [ ] Dynamic festival calendar (lunar-computed, not static)
- [ ] Panchang PDF export

---

## 🙏 Acknowledgements

- Astronomical algorithms based on **Jean Meeus — Astronomical Algorithms**
- Panchang calculation methodology from **Surya Siddhanta** tradition
- Verified against [Drikpanchang.com](https://www.drikpanchang.com) reference data

---

## 📄 License

```
MIT License — Free to use, modify, and distribute.
```

---

*Built with 🧡 for the Hindu community. Jai Shri Ram 🙏*
