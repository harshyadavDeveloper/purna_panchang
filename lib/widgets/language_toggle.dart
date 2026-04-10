import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/language_provider.dart';
import '../theme/app_theme.dart';

class LanguageToggle extends ConsumerWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(languageProvider);
    final isHindi = lang == AppLanguage.hindi;

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        ref.read(languageProvider.notifier).toggle();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white54, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'EN',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: !isHindi ? Colors.white : Colors.white54,
              ),
            ),
            const SizedBox(width: 4),
            Text('|',
                style: TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(width: 4),
            Text(
              'हि',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isHindi ? Colors.white : Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}