import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../core/panchang/panchang_engine.dart';
import '../core/muhurat/muhurat_engine.dart';
import '../core/panchang/vrat_calculator.dart';
import '../core/panchang/samvat_calculator.dart';
import '../data/festivals.dart';

class ShareHelper {
  static String _fmt(DateTime dt) {
    final h = dt.hour > 12
        ? dt.hour - 12
        : dt.hour == 0
            ? 12
            : dt.hour;
    final m = dt.minute.toString().padLeft(2, '0');
    final a = dt.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $a';
  }

  static String _formatDate(DateTime d) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    const weekdays = [
      '', 'Monday', 'Tuesday', 'Wednesday',
      'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];
    return '${weekdays[d.weekday]}, ${d.day} ${months[d.month - 1]} ${d.year}';
  }

  static void sharePanchang({
    required DateTime date,
    required PanchangData panchang,
    required MuhuratData muhurat,
    required String cityName,
  }) {
    final samvat = SamvatCalculator.calculate(date);
    final vrats = VratCalculator.getVrats(panchang);
    final festivals = festivalsForDate(date.month, date.day);

    final buffer = StringBuffer();

    buffer.writeln('🕉 *पूर्ण पंचांग — Purna Panchang*');
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln('📅 ${_formatDate(date)}');
    buffer.writeln('📍 $cityName');
    buffer.writeln();

    buffer.writeln('*✨ पंचांग*');
    buffer.writeln('☀️ वार (Vara)       : ${panchang.varaName}');
    buffer.writeln('🌙 तिथि (Tithi)     : ${panchang.tithiName}');
    buffer.writeln('   ${panchang.tithiPaksha}');
    buffer.writeln('⭐ नक्षत्र (Nakshatra): ${panchang.nakshatraName}');
    buffer.writeln('◎ योग (Yoga)       : ${panchang.yogaName}');
    buffer.writeln('◑ करण (Karana)     : ${panchang.karanaName}');
    buffer.writeln();

    buffer.writeln('*📅 संवत्*');
    buffer.writeln('विक्रम संवत् : ${samvat.vikramSamvat} (${samvat.vikramYear})');
    buffer.writeln('शक संवत्    : ${samvat.shakaSamvat}');
    buffer.writeln();

    buffer.writeln('*⏰ मुहूर्त*');
    buffer.writeln('🌅 ब्रह्म मुहूर्त  : ${_fmt(muhurat.brahmaMuhurtStart)} – ${_fmt(muhurat.brahmaMuhurtEnd)}');
    buffer.writeln('✨ अभिजित मुहूर्त : ${_fmt(muhurat.abhijitStart)} – ${_fmt(muhurat.abhijitEnd)}');
    buffer.writeln('🚫 राहु काल      : ${_fmt(muhurat.rahuKaalStart)} – ${_fmt(muhurat.rahuKaalEnd)}');
    buffer.writeln('🚫 गुलिका काल    : ${_fmt(muhurat.gulikaKaalStart)} – ${_fmt(muhurat.gulikaKaalEnd)}');
    buffer.writeln('🚫 यमगण्ड       : ${_fmt(muhurat.yamagandaStart)} – ${_fmt(muhurat.yamagandaEnd)}');

    if (vrats.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('*🙏 व्रत & त्योहार*');
      for (final v in vrats) {
        buffer.writeln('${v.isMajor ? '🪔' : '🙏'} ${v.nameHindi} — ${v.name}');
      }
    }

    if (festivals.isNotEmpty) {
      buffer.writeln();
      for (final f in festivals) {
        buffer.writeln('🎉 ${f.nameHindi} — ${f.name}');
      }
    }

    buffer.writeln();
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln('_Shared via पूर्ण पंचांग app_');

    SharePlus.instance.share(
      ShareParams(text: buffer.toString()),
    );
  }

  /// Shows a snackbar confirm then shares
  static void shareWithConfirm(
    BuildContext context, {
    required DateTime date,
    required PanchangData panchang,
    required MuhuratData muhurat,
    required String cityName,
  }) {
    sharePanchang(
      date: date,
      panchang: panchang,
      muhurat: muhurat,
      cityName: cityName,
    );
  }
}