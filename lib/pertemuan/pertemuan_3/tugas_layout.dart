import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_badge.dart';
import '../../widgets/app_card.dart';
import '../../widgets/app_empty_state.dart';
import '../../widgets/animated_pressable.dart';
import '../../widgets/staggered_entrance.dart';

class TugasLayoutPertemuan3 extends StatefulWidget {
  final VoidCallback? onToggleTheme;

  const TugasLayoutPertemuan3({super.key, this.onToggleTheme});

  @override
  State<TugasLayoutPertemuan3> createState() => _TugasLayoutPertemuan3State();
}

class _TugasLayoutPertemuan3State extends State<TugasLayoutPertemuan3> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Semua';
  final Set<String> _favorites = {'1', '3'};

  final List<Map<String, dynamic>> _daftarMakanan = [
    {
      'id': '1',
      'nama': 'Nasi Goreng Spesial',
      'kategori': 'Nasi',
      'deskripsi':
          'Nasi goreng dengan bumbu rempah pilihan, telur mata sapi setengah matang, suwiran ayam gurih, dan kerupuk udang.',
      'harga': 'Rp 20.000',
      'hargaNum': 20000,
      'rating': '4.8',
      'waktu': '15 Menit',
      'ikon': LucideIcons.utensils,
      'warna': Colors.orange,
    },
    {
      'id': '2',
      'nama': 'Mie Ayam Bakso Urat',
      'kategori': 'Mie & Bakso',
      'deskripsi':
          'Mie kenyal buatan tangan dengan potongan ayam kecap manis gurih, bakso urat lezat, dan kuah kaldu rempah.',
      'harga': 'Rp 18.000',
      'hargaNum': 18000,
      'rating': '4.7',
      'waktu': '10 Menit',
      'ikon': LucideIcons.utensilsCrossed,
      'warna': Colors.amber,
    },
    {
      'id': '3',
      'nama': 'Sate Ayam Madura Asli',
      'kategori': 'Panggangan',
      'deskripsi':
          'Daging ayam empuk dibakar arang dengan siraman bumbu kacang kental khas Madura, bawang merah, dan kecap manis.',
      'harga': 'Rp 25.000',
      'hargaNum': 25000,
      'rating': '4.9',
      'waktu': '20 Menit',
      'ikon': LucideIcons.flame,
      'warna': Colors.deepOrange,
    },
    {
      'id': '4',
      'nama': 'Bakso Sapi Urat Jumbo',
      'kategori': 'Kuah / Sup',
      'deskripsi':
          'Bakso sapi urat tekstur kasar kenyal, tahu bakso gurih, bihun sutra, daun bawang, dan kuah kaldu sumsum.',
      'harga': 'Rp 22.000',
      'hargaNum': 22000,
      'rating': '4.8',
      'waktu': '12 Menit',
      'ikon': LucideIcons.soup,
      'warna': Colors.redAccent,
    },
    {
      'id': '5',
      'nama': 'Ayam Bakar Taliwang',
      'kategori': 'Panggangan',
      'deskripsi':
          'Ayam muda bakar bumbu pedas rempah Lombok autentik lengkap dengan sambal terasi plecing kangkung.',
      'harga': 'Rp 28.000',
      'hargaNum': 28000,
      'rating': '4.9',
      'waktu': '25 Menit',
      'ikon': LucideIcons.flame,
      'warna': Colors.red,
    },
    {
      'id': '6',
      'nama': 'Soto Betawi Kuah Susu',
      'kategori': 'Kuah / Sup',
      'deskripsi':
          'Potongan daging sapi empuk dalam kuah susu santan gurih kaya rempah pala kapulaga, kentang, dan emping melinjo.',
      'harga': 'Rp 30.000',
      'hargaNum': 30000,
      'rating': '4.8',
      'waktu': '15 Menit',
      'ikon': LucideIcons.soup,
      'warna': Colors.teal,
    },
  ];

  final List<String> _kategoriList = [
    'Semua',
    'Nasi',
    'Mie & Bakso',
    'Panggangan',
    'Kuah / Sup',
  ];

  List<Map<String, dynamic>> get _filteredMakanan {
    return _daftarMakanan.where((item) {
      final matchesCategory = _selectedCategory == 'Semua' ||
          item['kategori'] == _selectedCategory;
      final query = _searchController.text.toLowerCase().trim();
      final matchesSearch = query.isEmpty ||
          (item['nama'] as String).toLowerCase().contains(query) ||
          (item['deskripsi'] as String).toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _toggleFavorite(String id) {
    setState(() {
      if (_favorites.contains(id)) {
        _favorites.remove(id);
      } else {
        _favorites.add(id);
      }
    });
  }

  void _openOrderSheet(Map<String, dynamic> item) {
    int quantity = 1;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xxl)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final int hargaNum = item['hargaNum'] as int;
            final int total = hargaNum * quantity;

            return Padding(
              padding: EdgeInsets.only(
                left: AppSpacing.xxl,
                right: AppSpacing.xxl,
                top: AppSpacing.xxl,
                bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xxl,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: (item['warna'] as Color).withAlpha(35),
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                        ),
                        child: Icon(
                          item['ikon'] as IconData,
                          color: item['warna'] as Color,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['nama'] as String,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              item['harga'] as String,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(LucideIcons.x, size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const Text(
                    'Jumlah Porsi',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      AnimatedPressable(
                        onTap: quantity > 1 ? () => setSheetState(() => quantity--) : null,
                        child: Container(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          decoration: BoxDecoration(
                            color: quantity > 1 ? AppColors.primarySubtle : Colors.grey.withAlpha(40),
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                          child: Icon(
                            LucideIcons.minus,
                            color: quantity > 1 ? AppColors.primary : Colors.grey,
                            size: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                        child: Text(
                          '$quantity',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      AnimatedPressable(
                        onTap: () => setSheetState(() => quantity++),
                        child: Container(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          decoration: BoxDecoration(
                            color: AppColors.primarySubtle,
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                          child: const Icon(
                            LucideIcons.plus,
                            color: AppColors.primary,
                            size: 18,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Rp ${total.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: AppColors.primaryDark,
                            content: Text(
                              'Pesanan disimulasikan: $quantity x ${item['nama']} berhasil!',
                            ),
                          ),
                        );
                      },
                      child: const Text('Konfirmasi & Pesan'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final items = _filteredMakanan;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas 3: Layout Kuliner Populer'),
        actions: [
          if (widget.onToggleTheme != null)
            IconButton(
              icon: Icon(
                isDark ? LucideIcons.sun : LucideIcons.moon,
                size: 20,
              ),
              onPressed: widget.onToggleTheme,
              tooltip: isDark ? 'Mode Terang' : 'Mode Gelap',
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Cari menu makanan favorit...',
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
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
            child: Row(
              children: _kategoriList.map((kategori) {
                final isSelected = _selectedCategory == kategori;
                return Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: AnimatedPressable(
                    scaleDown: 0.94,
                    onTap: () {
                      setState(() {
                        _selectedCategory = kategori;
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
                            ? Colors.deepOrange
                            : (isDark ? AppColors.surfaceDark : Colors.white),
                        borderRadius: BorderRadius.circular(AppRadius.full),
                        border: Border.all(
                          color: isSelected
                              ? Colors.deepOrange
                              : (isDark ? AppColors.borderDark : AppColors.border),
                          width: 1.2,
                        ),
                      ),
                      child: Text(
                        kategori,
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
                    icon: LucideIcons.utensils,
                    title: 'Menu Tidak Ditemukan',
                    description: 'Tidak ada makanan yang cocok dengan pencarian atau filter saat ini.',
                    actionLabel: 'Reset Pencarian',
                    onAction: () {
                      _searchController.clear();
                      setState(() {
                        _selectedCategory = 'Semua';
                      });
                    },
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    physics: const BouncingScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final makanan = items[index];
                      final Color warnaIkon = makanan['warna'] as Color;
                      final isFav = _favorites.contains(makanan['id']);

                      return StaggeredEntrance(
                        index: index,
                        child: AppCard(
                          margin: const EdgeInsets.only(bottom: AppSpacing.md),
                          onTap: () => _openOrderSheet(makanan),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: warnaIkon.withAlpha(30),
                                      borderRadius: BorderRadius.circular(AppRadius.lg),
                                    ),
                                    child: Icon(
                                      makanan['ikon'] as IconData,
                                      color: warnaIkon,
                                      size: 26,
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.md),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          makanan['nama'] as String,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        AppBadge(
                                          label: makanan['kategori'] as String,
                                          backgroundColor: warnaIkon.withAlpha(25),
                                          textColor: warnaIkon,
                                        ),
                                      ],
                                    ),
                                  ),
                                  AnimatedPressable(
                                    scaleDown: 0.8,
                                    onTap: () => _toggleFavorite(makanan['id'] as String),
                                    child: Container(
                                      padding: const EdgeInsets.all(AppSpacing.sm),
                                      decoration: BoxDecoration(
                                        color: isFav ? AppColors.errorSubtle : (isDark ? AppColors.surfaceDark : AppColors.background),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        LucideIcons.heart,
                                        color: isFav ? AppColors.error : AppColors.textMuted,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.md),
                              Text(
                                makanan['deskripsi'] as String,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isDark
                                      ? AppColors.textSecondaryDark
                                      : AppColors.textSecondary,
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
                                      const Icon(
                                        LucideIcons.star,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        makanan['rating'] as String,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(width: AppSpacing.md),
                                      Icon(
                                        LucideIcons.clock,
                                        size: 15,
                                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        makanan['waktu'] as String,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppSpacing.md,
                                      vertical: AppSpacing.xs + 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primarySubtle,
                                      borderRadius: BorderRadius.circular(AppRadius.full),
                                    ),
                                    child: Text(
                                      makanan['harga'] as String,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: AppColors.primaryDark,
                                      ),
                                    ),
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
