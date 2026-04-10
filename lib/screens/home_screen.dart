import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/panchang/panchang_engine.dart';
import '../core/muhurat/muhurat_engine.dart';
import '../data/cities.dart';
import '../data/festivals.dart';
import '../providers/city_provider.dart';
import '../providers/language_provider.dart';
import '../l10n/app_strings.dart';
import '../theme/app_theme.dart';
import '../widgets/panchang_card.dart';
import '../widgets/samvat_vrat_card.dart';
import '../widgets/share_helper.dart';
import '../widgets/language_toggle.dart';
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
    const monthsHindi = [
      'जनवरी','फरवरी','मार्च','अप्रैल','मई','जून',
      'जुलाई','अगस्त','सितम्बर','अक्टूबर','नवम्बर','दिसम्बर'
    ];
    const weekdays = [
      '','Monday','Tuesday','Wednesday',
      'Thursday','Friday','Saturday','Sunday'
    ];
    const weekdaysHindi = [
      '','सोमवार','मंगलवार','बुधवार',
      'गुरुवार','शुक्रवार','शनिवार','रविवार'
    ];
    final s = ref.read(languageProvider);
    final isHindi = s == AppLanguage.hindi;
    if (isHindi) {
      return '${weekdaysHindi[d.weekday]}, ${d.day} ${monthsHindi[d.month - 1]} ${d.year}';
    }
    return '${weekdays[d.weekday]}, ${d.day} ${months[d.month - 1]} ${d.year}';
  }

  String _fmt(DateTime dt) {
    final h = dt.hour > 12
        ? dt.hour - 12
        : dt.hour == 0 ? 12 : dt.hour;
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
    final lang = ref.watch(languageProvider);
    final s = AppStrings(lang);

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => ShareHelper.shareWithConfirm(
          context,
          date: _selectedDate,
          panchang: panchang,
          muhurat: muhurat,
          cityName: city.name,
        ),
        backgroundColor: AppTheme.saffron,
        icon: const Icon(Icons.share, color: Colors.white),
        label: Text(
          s.share,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(city.name, s),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
              child: Column(
                children: [
                  _buildDateNav(s),
                  const SizedBox(height: 16),
                  if (todayFestivals.isNotEmpty) ...[
                    _buildFestivalBanner(todayFestivals),
                    const SizedBox(height: 16),
                  ],
                  PanchangCard(data: panchang, strings: s),
                  const SizedBox(height: 16),
                  SamvatVratCard(
                      panchang: panchang, date: _selectedDate, strings: s),
                  const SizedBox(height: 16),
                  _buildSunCard(sunrise, sunset, s),
                  const SizedBox(height: 16),
                  _buildMuhuratCard(muhurat, s),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(String cityName, AppStrings s) {
    return SliverAppBar(
      expandedHeight: 80,
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
                  Text('🕉 ${s.appName}',
                      style: const TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  const SizedBox(height: 3),
                  Text(s.appSubtitle,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 8,
                        color: Colors.white70,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        const LanguageToggle(),
        const SizedBox(width: 8),
        TextButton.icon(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const CityPickerScreen())),
          icon: const Icon(Icons.location_on, color: Colors.white, size: 16),
          label: Text(cityName,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,),),
        ),
      ],
    );
  }

  Widget _buildDateNav(AppStrings s) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: AppTheme.saffron.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4)),
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
                Text(_formatDate(_selectedDate),
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBrown,
                    )),
                const SizedBox(height: 4),
                if (_isToday(_selectedDate))
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.saffron,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(s.today,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            fontWeight: FontWeight.w500)),
                  )
                else
                  Text(s.tapToPickDate,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          color: Colors.grey.shade400)),
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
            colors: [Color(0xFFFFB300), Color(0xFFFF6F00)]),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: AppTheme.gold.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4)),
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
                  .map((f) => Text('${f.name} — ${f.nameHindi}',
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSunCard(DateTime sunrise, DateTime sunset, AppStrings s) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: AppTheme.saffron.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          _cardHeader(Icons.wb_twilight, s.sunriseSunset, ''),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                    child: _sunBlock(
                        '🌅', s.sunrise, _fmt(sunrise), Colors.orange)),
                Container(
                    width: 1, height: 60, color: Colors.orange.shade100),
                Expanded(
                    child: _sunBlock(
                        '🌇', s.sunset, _fmt(sunset), AppTheme.darkBrown)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sunBlock(String emoji, String label, String time, Color color) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 26)),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Colors.grey.shade500)),
        const SizedBox(height: 4),
        Text(time,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: color)),
      ],
    );
  }

  Widget _buildMuhuratCard(MuhuratData m, AppStrings s) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: AppTheme.saffron.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          _cardHeader(Icons.access_time, s.muhurat, s.muhuratTitle),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _muhuratRow('🌄', s.brahmaMuhurat,
                    '${_fmt(m.brahmaMuhurtStart)} – ${_fmt(m.brahmaMuhurtEnd)}',
                    Colors.amber.shade700, true, s),
                Divider(height: 1, color: Colors.orange.shade50),
                _muhuratRow('✨', s.abhijitMuhurat,
                    '${_fmt(m.abhijitStart)} – ${_fmt(m.abhijitEnd)}',
                    Colors.green.shade700, true, s),
                Divider(height: 1, color: Colors.orange.shade50),
                _muhuratRow('🚫', s.rahuKaal,
                    '${_fmt(m.rahuKaalStart)} – ${_fmt(m.rahuKaalEnd)}',
                    Colors.red.shade700, false, s),
                Divider(height: 1, color: Colors.orange.shade50),
                _muhuratRow('🚫', s.gulikaKaal,
                    '${_fmt(m.gulikaKaalStart)} – ${_fmt(m.gulikaKaalEnd)}',
                    Colors.red.shade400, false, s),
                Divider(height: 1, color: Colors.orange.shade50),
                _muhuratRow('🚫', s.yamaganda,
                    '${_fmt(m.yamagandaStart)} – ${_fmt(m.yamagandaEnd)}',
                    Colors.red.shade300, false, s),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _muhuratRow(String emoji, String name, String time, Color color,
      bool auspicious, AppStrings s) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(name,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: color)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(time,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: color)),
              Text(
                auspicious ? s.auspicious : s.avoid,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    color: auspicious
                        ? Colors.green.shade600
                        : Colors.red.shade400),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cardHeader(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          AppTheme.saffron.withOpacity(0.12),
          AppTheme.saffron.withOpacity(0.04),
        ]),
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.saffron, size: 18),
          const SizedBox(width: 8),
          Text(title,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.saffron)),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(width: 8),
            Text(subtitle,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    color: Colors.grey.shade400)),
          ],
        ],
      ),
    );
  }
}