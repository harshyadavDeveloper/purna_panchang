import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../data/festivals.dart';
import '../core/panchang/panchang_engine.dart';
import '../providers/city_provider.dart';
import '../data/cities.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  static const _saffron = Color(0xFFFF6F00);
  static const _cream = Color(0xFFFFF8E1);
  static const _darkBrown = Color(0xFF4E342E);

  @override
  Widget build(BuildContext context) {
    final city = ref.watch(cityProvider) ??
        indianCities.firstWhere((c) => c.name == 'New Delhi');

    final selectedPanchang =
        PanchangEngine.calculate(_selectedDay, city.utcOffset);
    final todayFestivals =
        festivalsForDate(_selectedDay.month, _selectedDay.day);

    return Scaffold(
      backgroundColor: _cream,
      appBar: AppBar(
        backgroundColor: _saffron,
        foregroundColor: Colors.white,
        title: const Text(
          'पंचांग कैलेंडर',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          _buildCalendar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSelectedDayPanchang(selectedPanchang),
                  if (todayFestivals.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _buildFestivalList(todayFestivals),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      color: Colors.white,
      child: TableCalendar(
        firstDay: DateTime(2020),
        lastDay: DateTime(2030),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
        onDaySelected: (selected, focused) {
          setState(() {
            _selectedDay = selected;
            _focusedDay = focused;
          });
        },
        onPageChanged: (focused) {
          setState(() => _focusedDay = focused);
        },
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: _saffron.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          selectedDecoration: const BoxDecoration(
            color: _saffron,
            shape: BoxShape.circle,
          ),
          markerDecoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          markersMaxCount: 1,
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: const TextStyle(
            color: _darkBrown,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          leftChevronIcon:
              const Icon(Icons.chevron_left, color: _saffron),
          rightChevronIcon:
              const Icon(Icons.chevron_right, color: _saffron),
        ),
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: _darkBrown, fontSize: 12),
          weekendStyle: TextStyle(color: _saffron, fontSize: 12),
        ),
        eventLoader: (day) => festivalsForDate(day.month, day.day),
      ),
    );
  }

  Widget _buildSelectedDayPanchang(PanchangData p) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.orange.shade100, blurRadius: 8)
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: _saffron, size: 18),
              const SizedBox(width: 8),
              Text(
                '${p.varaName} — ${p.tithiName}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _darkBrown,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _chip('${p.tithiPaksha}', Colors.orange),
              _chip('☽ ${p.nakshatraName}', Colors.purple),
              _chip('◎ ${p.yogaName}', Colors.teal),
              _chip('◑ ${p.karanaName}', Colors.indigo),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFestivalList(List<Festival> festivals) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.orange.shade100, blurRadius: 8)
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.celebration, color: _saffron, size: 18),
              SizedBox(width: 8),
              Text(
                'Festivals & Events',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _saffron,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...festivals.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('🪔', style: TextStyle(fontSize: 20)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            f.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _darkBrown,
                            ),
                          ),
                          Text(
                            f.nameHindi,
                            style: const TextStyle(
                              fontSize: 13,
                              color: _saffron,
                            ),
                          ),
                          Text(
                            f.description,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _chip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500),
      ),
    );
  }
}