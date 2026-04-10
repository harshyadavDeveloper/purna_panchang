import 'package:flutter/material.dart';
import 'package:purna_panchang/l10n/app_strings.dart';
import '../core/panchang/panchang_engine.dart';
import '../theme/app_theme.dart';

class PanchangCard extends StatelessWidget {
  final PanchangData data;
  final AppStrings strings;

  const PanchangCard({super.key, required this.data,required this.strings});

  @override
  Widget build(BuildContext context) {
    return _AppCard(
      headerIcon: Icons.auto_awesome,
      headerSanskrit: 'पञ्चाङ्ग',
      headerEnglish: 'Panchang',
      child: Column(
        children: [
          _PanchangRow(sanskrit: strings.vara,     transliteration: strings.varaEn,     value: strings.weekday(data.varaName),          icon: '☀️'),

          const _RowDivider(),
          _PanchangRow(sanskrit: strings.tithi,    transliteration: strings.tithiEn,    value: strings.tithiName(data.tithiName),       icon: '🌙', subtitle: strings.paksha(data.tithiPaksha), badge: '#${data.tithiIndex}'),

          const _RowDivider(),
          _PanchangRow(sanskrit: strings.nakshatra,transliteration: strings.nakshatraEn,value: strings.nakshatraName(data.nakshatraName),icon: '⭐', badge: '#${data.nakshatraIndex}'),

          const _RowDivider(),
          _PanchangRow(sanskrit: strings.yoga,     transliteration: strings.yogaEn,     value: strings.yogaName(data.yogaName),         icon: '◎', badge: '#${data.yogaIndex}'),

          const _RowDivider(),
         _PanchangRow(sanskrit: strings.karana,   transliteration: strings.karanaEn,   value: strings.karanaName(data.karanaName),     icon: '◑'),

        ],
      ),
    );
  }
}

class _PanchangRow extends StatelessWidget {
  final String sanskrit;
  final String transliteration;
  final String value;
  final String? subtitle;
  final String icon;
  final String? badge;

  const _PanchangRow({
    required this.sanskrit,
    required this.transliteration,
    required this.value,
    required this.icon,
    this.subtitle,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sanskrit,
                style: AppTheme.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.saffron,
                ),
              ),
              Text(
                transliteration,
                style: AppTheme.poppins(
                  fontSize: 10,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  if (badge != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppTheme.saffronLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        badge!,
                        style: AppTheme.poppins(
                          fontSize: 10,
                          color: AppTheme.saffron,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    value,
                    style: AppTheme.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBrown,
                    ),
                  ),
                ],
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: AppTheme.poppins(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) =>
      Divider(height: 1, color: Colors.orange.shade50);
}

// ── Shared card shell used across the app ──────────────────────

class AppCard extends StatelessWidget {
  final IconData headerIcon;
  final String headerSanskrit;
  final String headerEnglish;
  final Widget child;

  const AppCard({
    super.key,
    required this.headerIcon,
    required this.headerSanskrit,
    required this.headerEnglish,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => _AppCard(
        headerIcon: headerIcon,
        headerSanskrit: headerSanskrit,
        headerEnglish: headerEnglish,
        child: child,
      );
}

class _AppCard extends StatelessWidget {
  final IconData headerIcon;
  final String headerSanskrit;
  final String headerEnglish;
  final Widget child;

  const _AppCard({
    required this.headerIcon,
    required this.headerSanskrit,
    required this.headerEnglish,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                Icon(headerIcon, color: AppTheme.saffron, size: 18),
                const SizedBox(width: 8),
                Text(
                  headerSanskrit,
                  style: AppTheme.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.saffron,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  headerEnglish,
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
            child: child,
          ),
        ],
      ),
    );
  }
}