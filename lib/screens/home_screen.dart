import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/panchang/panchang_engine.dart';
import '../core/muhurat/muhurat_engine.dart';
import '../data/cities.dart';
import '../data/festivals.dart';
import '../providers/city_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/panchang_card.dart';
import 'city_picker_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  DateTime _selectedDate = DateTime.now();

  String _formatDate(DateTime d) {
    const months = [
      'January','February','March','April','May','June',
      'July','August','September','October','November','December'
    ];
    const weekdays = [
      '','Monday','Tuesday','Wednesday',
      'Thursday','Friday','Saturday','Sunday'
    ];
    return '${weekdays[d.weekday]}, ${d.day} ${months[d.month - 1]} ${d.year}';
  }

  String _fmt(DateTime dt) {
    final h = dt.hour > 12
        ? dt.hour - 12
        : dt.hour == 0
            ? 12
            : dt.hour;
    final m = dt.minute.toString().padLeft(2, '0');
    final a = dt.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $a';
  }

  bool _isToday(DateTime d) {
    final n = DateTime.now();
    return d.year == n.year && d.month == n.month && d.day == n.day;
  }

  void _changeDate(int days) {
    HapticFeedback.lightImpact();
    setState(() => _selectedDate = _selectedDate.add(Duration(days: days)));
  }

  @override
  Widget build(BuildContext context) {
    final city = ref.watch(cityProvider) ??
        indianCities.firstWhere((c) => c.name == 'New Delhi');

    final panchang = PanchangEngine.calculate(_selectedDate, city.utcOffset);

    final sunrise = DateTime(
      _selectedDate.year, _selectedDate.month, _selectedDate.day,
      city.sunriseMinutesFromMidnight ~/ 60,
      city.sunriseMinutesFromMidnight % 60,
    );
    final sunset = DateTime(
      _selectedDate.year, _selectedDate.month, _selectedDate.day,
      city.sunsetMinutesFromMidnight ~/ 60,
      city.sunsetMinutesFromMidnight % 60,
    );

    final muhurat =
        MuhuratEngine.calculate(sunrise, sunset, _selectedDate.weekday);

    final todayFestivals =
        festivalsForDate(_selectedDate.month, _selectedDate.day);

    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(city.name),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Column(
                children: [
                  _buildDateNav(),
                  const SizedBox(height: 16),
                  if (todayFestivals.isNotEmpty) ...[
                    _buildFestivalBanner(todayFestivals),
                    const SizedBox(height: 16),
                  ],
                  PanchangCard(data: panchang),
                  const SizedBox(height: 16),
                  _buildSunCard(sunrise, sunset),
                  const SizedBox(height: 16),
                  _buildMuhuratCard(muhurat),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(String cityName) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: AppTheme.saffron,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFF6F00), Color(0xFFE65100)],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🕉 पूर्ण पंचांग',
                    style: AppTheme.playfair(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Purna Panchang — Complete Vedic Calendar',
                    style: AppTheme.poppins(
                      fontSize: 11,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        TextButton.icon(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CityPickerScreen()),
          ),
          icon: const Icon(Icons.location_on, color: Colors.white, size: 16),
          label: Text(
            cityName,
            style: AppTheme.poppins(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.saffron.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, color: AppTheme.saffron),
            onPressed: () => _changeDate(-1),
          ),
          GestureDetector(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                builder: (context, child) => Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                        primary: AppTheme.saffron),
                  ),
                  child: child!,
                ),
              );
              if (picked != null) {
                HapticFeedback.selectionClick();
                setState(() => _selectedDate = picked);
              }
            },
            child: Column(
              children: [
                Text(
                  _formatDate(_selectedDate),
                  style: AppTheme.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBrown,
                  ),
                ),
                const SizedBox(height: 4),
                if (_isToday(_selectedDate))
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.saffron,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Today',
                      style: AppTheme.poppins(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                else
                  Text(
                    'Tap to pick date',
                    style: AppTheme.poppins(
                      fontSize: 10,
                      color: Colors.grey.shade400,
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, color: AppTheme.saffron),
            onPressed: () => _changeDate(1),
          ),
        ],
      ),
    );
  }

  Widget _buildFestivalBanner(List<Festival> festivals) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFB300), Color(0xFFFF6F00)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.gold.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Text('🪔', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: festivals
                  .map((f) => Text(
                        '${f.name} — ${f.nameHindi}',
                        style: AppTheme.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSunCard(DateTime sunrise, DateTime sunset) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.saffron.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.saffron.withOpacity(0.12),
                  AppTheme.saffron.withOpacity(0.04),
                ],
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                const Icon(Icons.wb_twilight,
                    color: AppTheme.saffron, size: 18),
                const SizedBox(width: 8),
                Text(
                  'सूर्योदय / सूर्यास्त',
                  style: AppTheme.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.saffron,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Sunrise & Sunset',
                  style: AppTheme.poppins(
                    fontSize: 11,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                    child: _sunBlock(
                        '🌅', 'Sunrise', 'सूर्योदय', _fmt(sunrise),
                        Colors.orange)),
                Container(
                    width: 1,
                    height: 60,
                    color: Colors.orange.shade100),
                Expanded(
                    child: _sunBlock(
                        '🌇', 'Sunset', 'सूर्यास्त', _fmt(sunset),
                        AppTheme.darkBrown)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sunBlock(String emoji, String en, String hi, String time,
      Color color) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 26)),
        const SizedBox(height: 4),
        Text(hi,
            style: AppTheme.poppins(
                fontSize: 12, color: AppTheme.saffron,
                fontWeight: FontWeight.w600)),
        Text(en,
            style: AppTheme.poppins(
                fontSize: 11, color: Colors.grey.shade400)),
        const SizedBox(height: 4),
        Text(time,
            style: AppTheme.poppins(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: color)),
      ],
    );
  }

  Widget _buildMuhuratCard(MuhuratData m) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.saffron.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.saffron.withOpacity(0.12),
                  AppTheme.saffron.withOpacity(0.04),
                ],
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                const Icon(Icons.access_time,
                    color: AppTheme.saffron, size: 18),
                const SizedBox(width: 8),
                Text('मुहूर्त',
                    style: AppTheme.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.saffron,
                    )),
                const SizedBox(width: 8),
                Text('Muhurat Timings',
                    style: AppTheme.poppins(
                      fontSize: 11,
                      color: Colors.grey.shade400,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _muhuratRow('🌄', 'Brahma Muhurat', 'ब्रह्म मुहूर्त',
                    '${_fmt(m.brahmaMuhurtStart)} – ${_fmt(m.brahmaMuhurtEnd)}',
                    Colors.amber.shade700, true),
                Divider(height: 1, color: Colors.orange.shade50),
                _muhuratRow('✨', 'Abhijit Muhurat', 'अभिजित मुहूर्त',
                    '${_fmt(m.abhijitStart)} – ${_fmt(m.abhijitEnd)}',
                    Colors.green.shade700, true),
                Divider(height: 1, color: Colors.orange.shade50),
                _muhuratRow('🚫', 'Rahu Kaal', 'राहु काल',
                    '${_fmt(m.rahuKaalStart)} – ${_fmt(m.rahuKaalEnd)}',
                    Colors.red.shade700, false),
                Divider(height: 1, color: Colors.orange.shade50),
                _muhuratRow('🚫', 'Gulika Kaal', 'गुलिका काल',
                    '${_fmt(m.gulikaKaalStart)} – ${_fmt(m.gulikaKaalEnd)}',
                    Colors.red.shade400, false),
                Divider(height: 1, color: Colors.orange.shade50),
                _muhuratRow('🚫', 'Yamaganda', 'यमगण्ड',
                    '${_fmt(m.yamagandaStart)} – ${_fmt(m.yamagandaEnd)}',
                    Colors.red.shade300, false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _muhuratRow(String emoji, String en, String hi, String time,
      Color color, bool auspicious) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(hi,
                    style: AppTheme.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: color,
                    )),
                Text(en,
                    style: AppTheme.poppins(
                        fontSize: 11, color: Colors.grey.shade400)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(time,
                  style: AppTheme.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: color,
                  )),
              Text(
                auspicious ? '✓ Auspicious' : '✗ Avoid',
                style: AppTheme.poppins(
                  fontSize: 10,
                  color: auspicious
                      ? Colors.green.shade600
                      : Colors.red.shade400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}