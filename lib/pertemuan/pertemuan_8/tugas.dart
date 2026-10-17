import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_badge.dart';
import '../../widgets/app_card.dart';

class TugasPertemuan8 extends StatefulWidget {
  const TugasPertemuan8({super.key});

  @override
  State<TugasPertemuan8> createState() => _TugasPertemuan8State();
}

class _TugasPertemuan8State extends State<TugasPertemuan8> {
  final List<Map<String, dynamic>> _tasks = [
    {'title': 'Instalasi Flutter SDK & Editor', 'done': true},
    {'title': 'Implementasi Layout Makanan P3', 'done': true},
    {'title': 'Uji Interaksi Toast & Alert P4', 'done': true},
    {'title': 'Validasi Form & Input P5', 'done': true},
    {'title': 'GridView Developer Tools P6', 'done': true},
    {'title': 'Simulasi State Cart & Checkout P7', 'done': true},
    {'title': 'Penyusunan Laporan Akhir Praktikum', 'done': false},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tugas 8: Tab & Analisis'),
          bottom: const TabBar(
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            tabs: [
              Tab(icon: Icon(LucideIcons.layoutDashboard, size: 18), text: 'Ikhtisar'),
              Tab(icon: Icon(LucideIcons.checkSquare, size: 18), text: 'Tugas'),
              Tab(icon: Icon(LucideIcons.barChart2, size: 18), text: 'Statistik'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
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
                        colors: [Color(0xFFE11D48), Color(0xFFBE123C)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: AppShadows.medium,
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBadge(
                          label: 'Pertemuan 8 • TabBar, TabBarView & Dashboard',
                          icon: LucideIcons.layoutDashboard,
                          backgroundColor: Colors.white24,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: AppSpacing.md),
                        Text(
                          'Dashboard Mahasiswa',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: AppSpacing.xs),
                        Text(
                          'Penyajian antarmuka multi-tab modern dengan navigasi swipe yang responsif.',
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
                    'Pencapaian Capstone',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppCard(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(AppSpacing.md),
                              decoration: BoxDecoration(
                                color: AppColors.successSubtle,
                                borderRadius: BorderRadius.circular(AppRadius.md),
                              ),
                              child: const Icon(LucideIcons.trophy, color: AppColors.success, size: 24),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Semua Modul Praktikum Selesai',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                  Text(
                                    '8 dari 8 pertemuan telah diimplementasikan dengan UI/UX modern.',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        LinearProgressIndicator(
                          value: 0.88,
                          backgroundColor: isDark ? AppColors.borderDark : AppColors.border,
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(AppRadius.full),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.lg),
              physics: const BouncingScrollPhysics(),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                final bool done = task['done'] as bool;

                return AppCard(
                  margin: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: done,
                    title: Text(
                      task['title'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        decoration: done ? TextDecoration.lineThrough : null,
                        color: done
                            ? (isDark ? AppColors.textSecondaryDark : AppColors.textSecondary)
                            : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        task['done'] = val ?? false;
                      });
                    },
                  ),
                );
              },
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Distribusi Kategori Materi',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        _buildStatRow('Dasar Flutter & Dart', 0.25, AppColors.info),
                        const SizedBox(height: AppSpacing.md),
                        _buildStatRow('Tata Letak & Responsif', 0.35, AppColors.primary),
                        const SizedBox(height: AppSpacing.md),
                        _buildStatRow('Interaksi & Form Input', 0.25, AppColors.accent),
                        const SizedBox(height: AppSpacing.md),
                        _buildStatRow('State Management & Navigasi', 0.15, AppColors.secondary),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, double percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 12)),
            Text('${(percentage * 100).toInt()}%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        LinearProgressIndicator(
          value: percentage,
          color: color,
          backgroundColor: color.withAlpha(30),
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
      ],
    );
  }
}
