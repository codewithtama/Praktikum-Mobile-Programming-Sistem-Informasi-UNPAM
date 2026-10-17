import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_badge.dart';
import '../../widgets/app_card.dart';
import '../../widgets/animated_pressable.dart';

class TugasPertemuan1 extends StatefulWidget {
  const TugasPertemuan1({super.key});

  @override
  State<TugasPertemuan1> createState() => _TugasPertemuan1State();
}

class _TugasPertemuan1State extends State<TugasPertemuan1> {
  int _counter = 0;
  bool _isReloading = false;

  void _simulateHotReload() {
    setState(() {
      _isReloading = true;
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _isReloading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Hot Reload Berhasil Disimulasikan! (240ms)'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas 1: Pengenalan Flutter'),
        actions: [
          IconButton(
            tooltip: 'Simulasi Hot Reload',
            onPressed: _isReloading ? null : _simulateHotReload,
            icon: AnimatedRotation(
              turns: _isReloading ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: const Icon(
                LucideIcons.zap,
                color: AppColors.accent,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
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
                  colors: [AppColors.info, Color(0xFF1D4ED8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: AppShadows.medium,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBadge(
                    label: 'Pertemuan 1 • Dasar Dart & Flutter',
                    icon: LucideIcons.code,
                    backgroundColor: Colors.white24,
                    textColor: Colors.white,
                  ),
                  SizedBox(height: AppSpacing.md),
                  Text(
                    'Arsitektur Widget Flutter',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    'Flutter menyusun seluruh elemen antarmuka melalui struktur hierarki Widget Tree yang deklaratif dan reaktif.',
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
              'Konsep Utama Pemrograman Flutter',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AppCard(
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.primarySubtle,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: const Icon(
                        LucideIcons.layers,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    title: const Text(
                      'Stateless vs Stateful',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: const Text(
                      'StatelessWidget tidak memiliki state internal, sedangkan StatefulWidget mempertahankan mutable state.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.infoSubtle,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: const Icon(
                        LucideIcons.gitBranch,
                        color: AppColors.info,
                        size: 20,
                      ),
                    ),
                    title: const Text(
                      'Widget Tree & Element Tree',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: const Text(
                      'Pohon hierarki immutable widget dirender menjadi Element dan RenderObject yang efisien.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.warningSubtle,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: const Icon(
                        LucideIcons.zap,
                        color: AppColors.warning,
                        size: 20,
                      ),
                    ),
                    title: const Text(
                      'Hot Reload & Hot Restart',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: const Text(
                      'Menyuntikkan kode baru ke Dart VM secara instan tanpa kehilangan state aplikasi.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text(
              'Uji Interaktivitas Widget State',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AppCard(
              child: Column(
                children: [
                  Text(
                    'Nilai Penghitung State:',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AnimatedScale(
                    scale: 1.0,
                    duration: const Duration(milliseconds: 150),
                    child: Text(
                      '$_counter',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedPressable(
                        onTap: () {
                          setState(() {
                            if (_counter > 0) _counter--;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                            vertical: AppSpacing.sm + 2,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.border),
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                LucideIcons.minus,
                                size: 16,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: AppSpacing.xs),
                              Text(
                                'Kurang',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      AnimatedPressable(
                        onTap: () {
                          setState(() {
                            _counter++;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                            vertical: AppSpacing.sm + 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                LucideIcons.plus,
                                size: 16,
                                color: Colors.white,
                              ),
                              SizedBox(width: AppSpacing.xs),
                              Text(
                                'Tambah',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
