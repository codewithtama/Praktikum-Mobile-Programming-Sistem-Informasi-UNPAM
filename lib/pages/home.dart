import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../theme/app_theme.dart';
import '../widgets/app_badge.dart';
import '../widgets/app_card.dart';
import '../widgets/animated_pressable.dart';
import '../widgets/staggered_entrance.dart';
import '../widgets/pulsing_glow.dart';
import '../pertemuan/pertemuan_1/tugas.dart';
import '../pertemuan/pertemuan_2/tugas.dart';
import '../pertemuan/pertemuan_3/tugas_layout.dart';
import '../pertemuan/pertemuan_4/tugas.dart';
import '../pertemuan/pertemuan_5/tugas.dart';
import '../pertemuan/pertemuan_6/tugas.dart';

class HomePage extends StatefulWidget {
  final void Function(int index)? onNavigateTab;

  const HomePage({super.key, this.onNavigateTab});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int? _expandedGuideIndex;
  late AnimationController _bannerPulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _bannerPulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.985, end: 1.015).animate(
      CurvedAnimation(parent: _bannerPulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _bannerPulseController.dispose();
    super.dispose();
  }

  void _showNotificationSheet(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xxl)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pemberitahuan Praktikum',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(LucideIcons.x, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.primarySubtle,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: const Icon(LucideIcons.sparkles, color: AppColors.primary, size: 20),
                ),
                title: const Text(
                  'Desain Modern Interaktif Aktif',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                subtitle: const Text(
                  'Seluruh modul menggunakan Lucide Icons, animasi mikro, dan transisi taktil.',
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
                  child: const Icon(LucideIcons.star, color: AppColors.warning, size: 20),
                ),
                title: const Text(
                  'Tugas Kuliner & Dialog',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                subtitle: const Text(
                  'Coba fitur pemesanan kuliner interaktif di Tugas 3 dan simulasi modal di Tugas 4.',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Tutup'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final quickStories = [
      {'title': 'Tugas 1', 'subtitle': 'Dasar', 'icon': LucideIcons.code, 'color': AppColors.info, 'target': const TugasPertemuan1()},
      {'title': 'Tugas 2', 'subtitle': 'Layout', 'icon': LucideIcons.layers, 'color': AppColors.secondary, 'target': const TugasPertemuan2()},
      {'title': 'Tugas 3', 'subtitle': 'Kuliner', 'icon': LucideIcons.utensils, 'color': AppColors.accent, 'target': const TugasLayoutPertemuan3()},
      {'title': 'Tugas 4', 'subtitle': 'Dialog', 'icon': LucideIcons.messageSquare, 'color': AppColors.primary, 'target': const TugasPertemuan4()},
      {'title': 'Tugas 5', 'subtitle': 'Form', 'icon': LucideIcons.fileEdit, 'color': AppColors.primaryLight, 'target': const TugasPertemuan5()},
      {'title': 'Tugas 6', 'subtitle': 'Daftar', 'icon': LucideIcons.fileSpreadsheet, 'color': AppColors.primary, 'target': const TugasPertemuan6()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            PulsingGlow(
              glowColor: AppColors.primaryLight.withAlpha(60),
              minScale: 0.95,
              maxScale: 1.05,
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.xs + 2),
                decoration: BoxDecoration(
                  color: AppColors.primarySubtle,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(LucideIcons.sparkles, color: AppColors.primary, size: 20),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Praktikum MP 2',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
                Text(
                  'DIMAS ALFA PRATAMA • Semester 4',
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Notifikasi',
            onPressed: () => _showNotificationSheet(context),
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  LucideIcons.bell,
                  size: 22,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
                Positioned(
                  right: 1,
                  top: 1,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? AppColors.surfaceDark : Colors.white,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, 0),
              child: StaggeredEntrance(
                index: 0,
                child: AnimatedBuilder(
                  animation: _bannerPulseController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: child,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.xxl),
                      color: isDark ? AppColors.surfaceDark : const Color(0xFF0F172A),
                      border: Border.all(
                        color: isDark ? AppColors.borderDark : const Color(0xFF1E293B),
                      ),
                      boxShadow: AppShadows.medium,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.md,
                                vertical: AppSpacing.xs + 1,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(50),
                                borderRadius: BorderRadius.circular(AppRadius.full),
                              ),
                              child: const Row(
                                children: [
                                  Icon(LucideIcons.zap, size: 14, color: AppColors.accent),
                                  SizedBox(width: AppSpacing.xs),
                                  Text(
                                    'Mobile Programming 2',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm + 2,
                                vertical: AppSpacing.xs,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(AppRadius.full),
                              ),
                              child: const Row(
                                children: [
                                  Icon(LucideIcons.checkCircle2, size: 13, color: AppColors.success),
                                  SizedBox(width: 4),
                                  Text(
                                    '8/8 Lengkap',
                                    style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        const Text(
                          'Halo, DIMAS ALFA PRATAMA! 👋',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Eksplorasi seluruh komponen widget Flutter modern dengan ikon Lucide dan tata letak responsif.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withAlpha(220),
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Row(
                          children: [
                            AnimatedPressable(
                              onTap: () {
                                if (widget.onNavigateTab != null) {
                                  widget.onNavigateTab!(1);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.lg,
                                  vertical: AppSpacing.sm + 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(AppRadius.full),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 8,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  children: [
                                    Text(
                                      'Buka Semua Materi',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryDark,
                                      ),
                                    ),
                                    SizedBox(width: AppSpacing.xs),
                                    Icon(LucideIcons.arrowRight, size: 16, color: AppColors.primaryDark),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: StaggeredEntrance(
                index: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Akses Cepat Modul',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                    Text(
                      'Pilih Modul',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            StaggeredEntrance(
              index: 2,
              child: SizedBox(
                height: 94,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  itemCount: quickStories.length,
                  itemBuilder: (context, index) {
                    final story = quickStories[index];
                    final Color color = story['color'] as Color;

                    return AnimatedPressable(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => story['target'] as Widget),
                        );
                      },
                      child: Container(
                        width: 82,
                        margin: const EdgeInsets.only(right: AppSpacing.md),
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.cardDark : Colors.white,
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                          border: Border.all(
                            color: color.withAlpha(50),
                            width: 1.5,
                          ),
                          boxShadow: isDark ? [] : AppShadows.soft,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(AppSpacing.sm),
                              decoration: BoxDecoration(
                                color: color.withAlpha(25),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(story['icon'] as IconData, size: 20, color: color),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              story['title'] as String,
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              story['subtitle'] as String,
                              style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: StaggeredEntrance(
                index: 3,
                child: Text(
                  'Statistik & Kemajuan Praktikum',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: StaggeredEntrance(
                index: 4,
                child: Row(
                  children: [
                    Expanded(
                      child: AppCard(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(AppSpacing.sm),
                                  decoration: BoxDecoration(
                                    color: AppColors.primarySubtle,
                                    borderRadius: BorderRadius.circular(AppRadius.md),
                                  ),
                                  child: const Icon(LucideIcons.graduationCap, color: AppColors.primary, size: 20),
                                ),
                                const AppBadge(
                                  label: 'Aktif',
                                  backgroundColor: AppColors.successSubtle,
                                  textColor: AppColors.success,
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              '8 Pertemuan',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Total Materi Perkuliahan',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: AppCard(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(AppSpacing.sm),
                                  decoration: BoxDecoration(
                                    color: AppColors.infoSubtle,
                                    borderRadius: BorderRadius.circular(AppRadius.md),
                                  ),
                                  child: const Icon(LucideIcons.award, color: AppColors.info, size: 20),
                                ),
                                const AppBadge(
                                  label: '100%',
                                  backgroundColor: AppColors.infoSubtle,
                                  textColor: AppColors.info,
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              'Selesai Penuh',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Status Evaluasi Modul',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: StaggeredEntrance(
                index: 5,
                child: Text(
                  'Tugas Interaktif Pilihan',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: StaggeredEntrance(
                index: 6,
                child: AppCard(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TugasLayoutPertemuan3()),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.deepOrange.withAlpha(25),
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                        ),
                        child: const Icon(LucideIcons.utensils, color: Colors.deepOrange, size: 24),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Tugas 3: Kuliner Populer',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                const AppBadge(
                                  label: 'Populer',
                                  backgroundColor: Color(0xFFFFEDD5),
                                  textColor: Colors.deepOrange,
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              'Katalog menu makanan dengan filter kategori, pencarian, dan interaksi favorit.',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.xs),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.surfaceDark : AppColors.background,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(LucideIcons.chevronRight, size: 16, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: StaggeredEntrance(
                index: 7,
                child: AppCard(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TugasPertemuan4()),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(25),
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                        ),
                        child: const Icon(LucideIcons.messageSquare, color: AppColors.primary, size: 24),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tugas 4: Toast & Alert Dialog',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              'Eksplorasi notifikasi toast, alert modal, bottom sheet, dan floating snackbar.',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.xs),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.surfaceDark : AppColors.background,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(LucideIcons.chevronRight, size: 16, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: StaggeredEntrance(
                index: 8,
                child: Text(
                  'Panduan Penggunaan Interaktif',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: StaggeredEntrance(
                index: 9,
                child: AppCard(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Column(
                    children: [
                      _buildExpandableTile(
                        index: 0,
                        icon: LucideIcons.home,
                        color: AppColors.primary,
                        title: 'Navigasi Menu Home',
                        subtitle: 'Halaman ringkasan informasi modul perkuliahan.',
                        details: 'Menyajikan ikhtisar pencapaian perkuliahan, kartu akses cepat, status pengerjaan modul praktikum, dan notifikasi terkini.',
                        isDark: isDark,
                      ),
                      const Divider(),
                      _buildExpandableTile(
                        index: 1,
                        icon: LucideIcons.bookOpen,
                        color: AppColors.info,
                        title: 'Navigasi Menu Materi',
                        subtitle: 'Daftar pertemuan lengkap dengan filter pencarian.',
                        details: 'Berisi 8 modul praktikum Flutter yang dapat dicari secara langsung atau difilter berdasarkan kategori (Dasar, Layout, Interaksi, Kompleks).',
                        isDark: isDark,
                        actionLabel: 'Buka Menu Materi',
                        onAction: () {
                          if (widget.onNavigateTab != null) {
                            widget.onNavigateTab!(1);
                          }
                        },
                      ),
                      const Divider(),
                      _buildExpandableTile(
                        index: 2,
                        icon: LucideIcons.user,
                        color: AppColors.secondary,
                        title: 'Navigasi Menu Profile',
                        subtitle: 'Informasi identitas mahasiswa & preferensi.',
                        details: 'Menampilkan data mahasiswa DIMAS ALFA PRATAMA, NIM 241011750032, program studi Sistem Informasi, serta switch interaktif untuk Tema Gelap/Terang.',
                        isDark: isDark,
                        actionLabel: 'Buka Menu Profile',
                        onAction: () {
                          if (widget.onNavigateTab != null) {
                            widget.onNavigateTab!(2);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableTile({
    required int index,
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required String details,
    required bool isDark,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final isExpanded = _expandedGuideIndex == index;

    return Column(
      children: [
        ListTile(
          onTap: () {
            setState(() {
              _expandedGuideIndex = isExpanded ? null : index;
            });
          },
          contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withAlpha(25),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
          ),
          trailing: AnimatedRotation(
            turns: isExpanded ? 0.25 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(LucideIcons.chevronRight, size: 18, color: AppColors.textMuted),
          ),
        ),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 250),
          crossFadeState: isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.xxl + 8, 0, AppSpacing.md, AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  details,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
                if (actionLabel != null && onAction != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      foregroundColor: color,
                    ),
                    onPressed: onAction,
                    icon: const Icon(LucideIcons.arrowRight, size: 14),
                    label: Text(actionLabel, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ],
              ],
            ),
          ),
          secondChild: const SizedBox.shrink(),
        ),
      ],
    );
  }
}
