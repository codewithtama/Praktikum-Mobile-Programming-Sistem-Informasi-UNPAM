import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../theme/app_theme.dart';
import '../widgets/app_badge.dart';
import '../widgets/app_card.dart';
import '../widgets/app_empty_state.dart';
import '../widgets/animated_pressable.dart';
import '../widgets/staggered_entrance.dart';

import '../pertemuan/pertemuan_1/tugas.dart';
import '../pertemuan/pertemuan_2/tugas.dart';
import '../pertemuan/pertemuan_3/tugas_layout.dart';
import '../pertemuan/pertemuan_4/tugas.dart';
import '../pertemuan/pertemuan_5/tugas.dart';
import '../pertemuan/pertemuan_6/tugas.dart';
import '../pertemuan/pertemuan_7/tugas.dart';
import '../pertemuan/pertemuan_8/tugas.dart';

class MateriPage extends StatefulWidget {
  const MateriPage({super.key});

  @override
  State<MateriPage> createState() => _MateriPageState();
}

class _MateriPageState extends State<MateriPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Semua';

  final List<Map<String, dynamic>> _materiList = [
    {
      'judul': 'Pertemuan 1',
      'topik': 'Pengenalan Flutter & Arsitektur Widget',
      'deskripsi':
          'Konsep dasar framework Flutter, bahasa Dart, hierarki Widget Tree, dan simulasi Hot Reload interaktif.',
      'kategori': 'Dasar',
      'waktu': '15 Menit',
      'level': 'Dasar',
      'warna': AppColors.info,
      'ikon': LucideIcons.code,
      'target': const TugasPertemuan1(),
    },
    {
      'judul': 'Pertemuan 2',
      'topik': 'Widget Dasar & Layout Dinamis',
      'deskripsi':
          'Eksplorasi properti Row, Column, Container, manipulasi perataan sumbu, radius sudut, dan palet aksen.',
      'kategori': 'Dasar',
      'waktu': '20 Menit',
      'level': 'Dasar',
      'warna': AppColors.secondary,
      'ikon': LucideIcons.layers,
      'target': const TugasPertemuan2(),
    },
    {
      'judul': 'Pertemuan 3',
      'topik': 'Layout Menu Kuliner Populer',
      'deskripsi':
          'Penyajian kartu kuliner interaktif dari data model berulang, sistem pencarian, filter kategori, dan modal pesanan.',
      'kategori': 'Layout',
      'waktu': '25 Menit',
      'level': 'Menengah',
      'warna': AppColors.accent,
      'ikon': LucideIcons.utensils,
      'target': const TugasLayoutPertemuan3(),
    },
    {
      'judul': 'Pertemuan 4',
      'topik': 'Toast, Dialog & Sistem Feedback',
      'deskripsi':
          'Implementasi dialog konfirmasi modal, notifikasi toast melayang, lembar pilihan bawah, dan snackbar.',
      'kategori': 'Interaksi',
      'waktu': '15 Menit',
      'level': 'Menengah',
      'warna': AppColors.primary,
      'ikon': LucideIcons.messageSquare,
      'target': const TugasPertemuan4(),
    },
    {
      'judul': 'Pertemuan 5',
      'topik': 'Formulir & Validasi Input Reaktif',
      'deskripsi':
          'Pembangunan form pendaftaran dengan validasi teks waktu nyata, sakelar sandi, dan seleksi opsi minat.',
      'kategori': 'Interaksi',
      'waktu': '20 Menit',
      'level': 'Menengah',
      'warna': AppColors.primaryLight,
      'ikon': LucideIcons.fileEdit,
      'target': const TugasPertemuan5(),
    },
    {
      'judul': 'Pertemuan 6',
      'topik': 'Form Flutter & Pendaftaran Mahasiswa',
      'deskripsi':
          'Implementasi Form, TextFormField, validasi reaktif, Radio Button, Checkbox kelompok, dan visualisasi hasil pendaftaran.',
      'kategori': 'Interaksi',
      'waktu': '25 Menit',
      'level': 'Menengah',
      'warna': AppColors.primary,
      'ikon': LucideIcons.fileSpreadsheet,
      'target': const TugasPertemuan6(),
    },
    {
      'judul': 'Pertemuan 7',
      'topik': 'State Management & Keranjang Belanja',
      'deskripsi':
          'Manajemen mutable state aplikasi dengan kalkulasi kuantitas produk, pajak PPN 11%, dan alur pembayaran ringkas.',
      'kategori': 'Kompleks',
      'waktu': '30 Menit',
      'level': 'Lanjutan',
      'warna': AppColors.success,
      'ikon': LucideIcons.shoppingBag,
      'target': const TugasPertemuan7(),
    },
    {
      'judul': 'Pertemuan 8',
      'topik': 'Navigasi TabBar & Dashboard Analitik',
      'deskripsi':
          'Arsitektur multi-halaman dengan transisi tab geser, daftar centang capaian, dan visualisasi distribusi materi.',
      'kategori': 'Kompleks',
      'waktu': '25 Menit',
      'level': 'Lanjutan',
      'warna': AppColors.secondary,
      'ikon': LucideIcons.barChart2,
      'target': const TugasPertemuan8(),
    },
  ];

  final List<String> _kategoriFilter = [
    'Semua',
    'Dasar',
    'Layout',
    'Interaksi',
    'Kompleks',
  ];

  List<Map<String, dynamic>> get _filteredMateri {
    final query = _searchController.text.toLowerCase().trim();
    return _materiList.where((item) {
      final matchesCategory = _selectedCategory == 'Semua' ||
          item['kategori'] == _selectedCategory;
      final matchesSearch = query.isEmpty ||
          (item['judul'] as String).toLowerCase().contains(query) ||
          (item['topik'] as String).toLowerCase().contains(query) ||
          (item['deskripsi'] as String).toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final items = _filteredMateri;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar Materi & Tugas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                letterSpacing: -0.3,
              ),
            ),
            Text(
              '8 Modul Praktikum Mobile Programming',
              style: TextStyle(
                fontSize: 11,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.full),
                boxShadow: isDark
                    ? []
                    : [
                        BoxShadow(
                          color: const Color(0xFF0F172A).withAlpha(8),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Cari topik, materi, atau kata kunci...',
                  prefixIcon: const Icon(LucideIcons.search, size: 18),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(LucideIcons.x, size: 16),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: isDark ? AppColors.surfaceDark : Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.full),
                    borderSide: BorderSide(
                      color: isDark ? AppColors.borderDark : AppColors.border,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.full),
                    borderSide: BorderSide(
                      color: isDark ? AppColors.borderDark : AppColors.border,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.full),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 1.6,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
            child: Row(
              children: _kategoriFilter.map((kat) {
                final isSelected = _selectedCategory == kat;
                return Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: AnimatedPressable(
                    scaleDown: 0.94,
                    onTap: () {
                      setState(() {
                        _selectedCategory = kat;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : (isDark ? AppColors.surfaceDark : Colors.white),
                        borderRadius: BorderRadius.circular(AppRadius.full),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : (isDark ? AppColors.borderDark : AppColors.border),
                          width: 1.2,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withAlpha(50),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: Text(
                        kat,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Expanded(
            child: items.isEmpty
                ? AppEmptyState(
                    icon: LucideIcons.searchX,
                    title: 'Materi Tidak Ditemukan',
                    description: 'Silakan periksa kata kunci pencarian atau pilih filter kategori lainnya.',
                    actionLabel: 'Reset Pencarian',
                    onAction: () {
                      _searchController.clear();
                      setState(() {
                        _selectedCategory = 'Semua';
                      });
                    },
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.sm,
                      AppSpacing.lg,
                      100,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final Color warna = item['warna'] as Color;

                      return StaggeredEntrance(
                        index: index,
                        child: AppCard(
                          margin: const EdgeInsets.only(bottom: AppSpacing.md),
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => item['target'] as Widget,
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: warna.withAlpha(25),
                                      borderRadius: BorderRadius.circular(AppRadius.md),
                                      border: Border.all(
                                        color: warna.withAlpha(50),
                                        width: 1.2,
                                      ),
                                    ),
                                    child: Icon(
                                      item['ikon'] as IconData,
                                      color: warna,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.md),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item['judul'] as String,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: warna,
                                                letterSpacing: 0.2,
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(AppSpacing.xs),
                                              decoration: BoxDecoration(
                                                color: isDark ? AppColors.surfaceDark : AppColors.background,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                LucideIcons.arrowUpRight,
                                                size: 15,
                                                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          item['topik'] as String,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                                            letterSpacing: -0.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                item['deskripsi'] as String,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.md),
                              const Divider(),
                              const SizedBox(height: AppSpacing.sm),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      AppBadge(
                                        label: item['kategori'] as String,
                                        backgroundColor: warna.withAlpha(20),
                                        textColor: warna,
                                      ),
                                      const SizedBox(width: AppSpacing.sm),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppSpacing.sm,
                                          vertical: AppSpacing.xs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isDark ? AppColors.surfaceDark : AppColors.background,
                                          borderRadius: BorderRadius.circular(AppRadius.full),
                                          border: Border.all(
                                            color: isDark ? AppColors.borderDark : AppColors.border,
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              LucideIcons.clock,
                                              size: 11,
                                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              item['waktu'] as String,
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Buka Modul',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: warna,
                                        ),
                                      ),
                                      const SizedBox(width: 2),
                                      Icon(
                                        LucideIcons.arrowRight,
                                        size: 13,
                                        color: warna,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
