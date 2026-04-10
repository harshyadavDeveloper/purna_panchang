import 'package:flutter/material.dart';
import '../core/panchang/vrat_calculator.dart';
import '../core/panchang/samvat_calculator.dart';
import '../core/panchang/panchang_engine.dart';
import '../theme/app_theme.dart';

class SamvatVratCard extends StatelessWidget {
  final PanchangData panchang;
  final DateTime date;

  const SamvatVratCard({
    super.key,
    required this.panchang,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final samvat = SamvatCalculator.calculate(date);
    final vrats = VratCalculator.getVrats(panchang);

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
          // ── Header ───────────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                const Icon(Icons.temple_hindu,
                    color: AppTheme.saffron, size: 18),
                const SizedBox(width: 8),
                Text(
                  'संवत् & व्रत',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.saffron,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Samvat & Vrat',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Samvat section ────────────────────────────
                _samvatRow('विक्रम संवत्', 'Vikram Samvat',
                    '${samvat.vikramSamvat} — ${samvat.vikramYear}'),
                const SizedBox(height: 8),
                _samvatRow('शक संवत्', 'Shaka Samvat',
                    '${samvat.shakaSamvat}'),
                const SizedBox(height: 8),
                _samvatRow('गुजराती संवत्', 'Gujarati Samvat',
                    '${samvat.gujaratiSamvat}'),

                if (vrats.isNotEmpty) ...[
                  Divider(
                      height: 24, color: Colors.orange.shade50),

                  // ── Vrat section ──────────────────────────
                  ...vrats.map((v) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              v.isMajor ? '🪔' : '🙏',
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        v.nameHindi,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: v.isMajor
                                              ? AppTheme.saffron
                                              : AppTheme.darkBrown,
                                        ),
                                      ),
                                      if (v.isMajor) ...[
                                        const SizedBox(width: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 1),
                                          decoration: BoxDecoration(
                                            color: AppTheme.saffron,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Text(
                                            'Major',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 9,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  Text(
                                    v.name,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 11,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                  Text(
                                    v.description,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 11,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ] else ...[
                  Divider(height: 24, color: Colors.orange.shade50),
                  Row(
                    children: [
                      const Text('😊', style: TextStyle(fontSize: 18)),
                      const SizedBox(width: 8),
                      Text(
                        'No vrat today',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _samvatRow(String hindi, String english, String value) {
    return Row(
      children: [
        const Text('📅', style: TextStyle(fontSize: 16)),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hindi,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.saffron,
              ),
            ),
            Text(
              english,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppTheme.darkBrown,
          ),
        ),
      ],
    );
  }
}