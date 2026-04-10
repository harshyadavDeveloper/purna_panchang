import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppLanguage { english, hindi }

class LanguageNotifier extends Notifier<AppLanguage> {
  @override
  AppLanguage build() {
    _loadSaved();
    return AppLanguage.english; // default
  }

  Future<void> _loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('app_language');
    if (saved == 'hindi') state = AppLanguage.hindi;
  }

  Future<void> toggle() async {
    state = state == AppLanguage.english
        ? AppLanguage.hindi
        : AppLanguage.english;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'app_language', state == AppLanguage.hindi ? 'hindi' : 'english');
  }

  bool get isHindi => state == AppLanguage.hindi;
}

final languageProvider =
    NotifierProvider<LanguageNotifier, AppLanguage>(() => LanguageNotifier());