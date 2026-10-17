import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_badge.dart';
import '../../widgets/app_card.dart';

class TugasPertemuan2 extends StatefulWidget {
  const TugasPertemuan2({super.key});

  @override
  State<TugasPertemuan2> createState() => _TugasPertemuan2State();
}

class _TugasPertemuan2State extends State<TugasPertemuan2> {
  MainAxisAlignment _alignment = MainAxisAlignment.center;
  Color _boxColor = AppColors.primary;
  double _borderRadius = 16.0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas 2: Widget Dasar & Layout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.xl),
                gradient: const LinearGradient(
                  colors: [AppColors.secondary, Color(0xFF4338CA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: AppShadows.medium,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBadge(
                    label: 'Pertemuan 2 • Row, Column, Container',
                    icon: LucideIcons.layers,
                    backgroundColor: Colors.white24,
                    textColor: Colors.white,
                  ),
                  SizedBox(height: AppSpacing.md),
                  Text(
                    'Eksplorasi Komposisi Widget',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    'Manipulasi properti Container, Row, dan Column secara interaktif untuk memahami tata letak dinamis.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text(
              'Pratinjau Hasil Layout Dinamis',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: _boxColor.withAlpha(25),
                borderRadius: BorderRadius.circular(_borderRadius),
                border: Border.all(color: _boxColor, width: 2),
              ),
              child: Row(
                mainAxisAlignment: _alignment,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _boxColor,
                      borderRadius: BorderRadius.circular(_borderRadius / 2),
                    ),
                    child: const Icon(LucideIcons.star, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _boxColor.withAlpha(180),
                      borderRadius: BorderRadius.circular(_borderRadius / 2),
                    ),
                    child: const Icon(LucideIcons.heart, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _boxColor.withAlpha(120),
                      borderRadius: BorderRadius.circular(_borderRadius / 2),
                    ),
                    child: const Icon(LucideIcons.thumbsUp, color: Colors.white, size: 22),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text(
              'Pengaturan Properti Interaktif',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pilihan MainAxisAlignment:',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    children: [
                      ChoiceChip(
                        label: const Text('Start'),
                        selected: _alignment == MainAxisAlignment.start,
                        onSelected: (_) => setState(() => _alignment = MainAxisAlignment.start),
                      ),
                      ChoiceChip(
                        label: const Text('Center'),
                        selected: _alignment == MainAxisAlignment.center,
                        onSelected: (_) => setState(() => _alignment = MainAxisAlignment.center),
                      ),
                      ChoiceChip(
                        label: const Text('Space Between'),
                        selected: _alignment == MainAxisAlignment.spaceBetween,
                        onSelected: (_) => setState(() => _alignment = MainAxisAlignment.spaceBetween),
                      ),
                    ],
                  ),
                  const Divider(height: AppSpacing.xxl),
                  const Text(
                    'Pilihan Warna Aksen:',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _boxColor = AppColors.primary),
                        child: CircleAvatar(
                          backgroundColor: AppColors.primary,
                          radius: 16,
                          child: _boxColor == AppColors.primary
                              ? const Icon(LucideIcons.check, size: 16, color: Colors.white)
                              : null,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      GestureDetector(
                        onTap: () => setState(() => _boxColor = AppColors.secondary),
                        child: CircleAvatar(
                          backgroundColor: AppColors.secondary,
                          radius: 16,
                          child: _boxColor == AppColors.secondary
                              ? const Icon(LucideIcons.check, size: 16, color: Colors.white)
                              : null,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      GestureDetector(
                        onTap: () => setState(() => _boxColor = AppColors.accent),
                        child: CircleAvatar(
                          backgroundColor: AppColors.accent,
                          radius: 16,
                          child: _boxColor == AppColors.accent
                              ? const Icon(LucideIcons.check, size: 16, color: Colors.white)
                              : null,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      GestureDetector(
                        onTap: () => setState(() => _boxColor = AppColors.error),
                        child: CircleAvatar(
                          backgroundColor: AppColors.error,
                          radius: 16,
                          child: _boxColor == AppColors.error
                              ? const Icon(LucideIcons.check, size: 16, color: Colors.white)
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: AppSpacing.xxl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Border Radius:',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${_borderRadius.toInt()} px',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                    ],
                  ),
                  Slider(
                    value: _borderRadius,
                    min: 0,
                    max: 36,
                    divisions: 18,
                    activeColor: _boxColor,
                    onChanged: (val) => setState(() => _borderRadius = val),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
