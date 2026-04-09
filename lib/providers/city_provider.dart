import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/cities.dart';

class CityNotifier extends Notifier<City?> {
  @override
  City? build() {
    _loadSaved();
    return indianCities.firstWhere(
      (c) => c.name == 'New Delhi',
      orElse: () => indianCities.first,
    ); // default city
  }

  Future<void> _loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('selected_city');
    if (saved != null) {
      final match = indianCities.where((c) => c.name == saved).toList();
      if (match.isNotEmpty) state = match.first;
    }
  }

  Future<void> setCity(City city) async {
    state = city;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_city', city.name);
  }
}

final cityProvider = NotifierProvider<CityNotifier, City?>(() => CityNotifier());