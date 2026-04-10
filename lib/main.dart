import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purna_panchang/l10n/app_strings.dart';
import 'package:purna_panchang/providers/language_provider.dart';
import 'screens/home_screen.dart';
import 'screens/calendar_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Purna Panchang',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const RootScreen(),
    );
  }
}

class RootScreen extends ConsumerStatefulWidget {
  const RootScreen({super.key});

  @override
  ConsumerState<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends ConsumerState<RootScreen> {
  int _currentIndex = 0;

  final _screens = const [HomeScreen(), CalendarScreen()];

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(languageProvider);
    final s = AppStrings(lang);

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── AdMob banner will live here ──────────────────────
          // When ready: replace AdBannerPlaceholder with BannerAdWidget
          const AdBannerPlaceholder(),
          // ─────────────────────────────────────────────────────
          BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (i) {
              HapticFeedback.selectionClick();
              setState(() => _currentIndex = i);
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.wb_sunny_outlined),
                activeIcon: const Icon(Icons.wb_sunny),
                label: s.navPanchang,       // 'पंचांग' or 'Panchang'
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.calendar_month_outlined),
                activeIcon: const Icon(Icons.calendar_month),
                label: s.navCalendar,       // 'कैलेंडर' or 'Calendar'
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── AdMob Placeholder ─────────────────────────────────────────
// TODO: When integrating AdMob:
// 1. Add google_mobile_ads to pubspec.yaml
// 2. Add App ID to AndroidManifest.xml
// 3. Replace this widget with BannerAd loaded widget
// 4. Standard banner size is 320x50 (AdSize.banner)
// ─────────────────────────────────────────────────────────────
class AdBannerPlaceholder extends StatelessWidget {
  const AdBannerPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.ads_click, size: 14, color: Colors.grey.shade400),
          const SizedBox(width: 6),
          Text(
            'Advertisement',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade400,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}