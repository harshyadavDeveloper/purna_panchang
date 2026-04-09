import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/cities.dart';
import '../providers/city_provider.dart';

class CityPickerScreen extends ConsumerStatefulWidget {
  const CityPickerScreen({super.key});

  @override
  ConsumerState<CityPickerScreen> createState() => _CityPickerScreenState();
}

class _CityPickerScreenState extends ConsumerState<CityPickerScreen> {
  String _search = '';

  List<City> get _filtered {
    if (_search.isEmpty) return indianCities;
    final q = _search.toLowerCase();
    return indianCities.where((c) =>
      c.name.toLowerCase().contains(q) ||
      c.state.toLowerCase().contains(q)
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCity = ref.watch(cityProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select City'),
        backgroundColor: const Color(0xFFFF6F00),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search city or state...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.orange.shade50,
              ),
              onChanged: (v) => setState(() => _search = v),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filtered.length,
              itemBuilder: (context, index) {
                final city = _filtered[index];
                final isSelected = selectedCity?.name == city.name;
                return ListTile(
                  title: Text(
                    city.name,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? const Color(0xFFFF6F00) : null,
                    ),
                  ),
                  subtitle: Text(city.state),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: Color(0xFFFF6F00))
                      : null,
                  onTap: () {
                    ref.read(cityProvider.notifier).setCity(city);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}