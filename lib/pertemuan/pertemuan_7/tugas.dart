import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_badge.dart';
import '../../widgets/app_card.dart';
import '../../widgets/animated_pressable.dart';

class TugasPertemuan7 extends StatefulWidget {
  const TugasPertemuan7({super.key});

  @override
  State<TugasPertemuan7> createState() => _TugasPertemuan7State();
}

class _TugasPertemuan7State extends State<TugasPertemuan7> {
  final List<Map<String, dynamic>> _cartItems = [
    {
      'id': '1',
      'nama': 'Buku Pemrograman Flutter & Dart',
      'harga': 120000,
      'qty': 1,
      'ikon': LucideIcons.bookOpen,
    },
    {
      'id': '2',
      'nama': 'Kursus Online Arsitektur Mobile',
      'harga': 250000,
      'qty': 1,
      'ikon': LucideIcons.video,
    },
    {
      'id': '3',
      'nama': 'Stiker Developer Pack Eksklusif',
      'harga': 25000,
      'qty': 2,
      'ikon': LucideIcons.sparkles,
    },
  ];

  int get _subtotal {
    int total = 0;
    for (var item in _cartItems) {
      total += (item['harga'] as int) * (item['qty'] as int);
    }
    return total;
  }

  int get _tax => (_subtotal * 0.11).round();

  int get _grandTotal => _subtotal + _tax;

  String _formatRupiah(int nominal) {
    return 'Rp ${nominal.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  void _showCheckoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          icon: const Icon(LucideIcons.checkCircle2, color: AppColors.success, size: 40),
          title: const Text('Pembayaran Berhasil!'),
          content: Text(
            'Simulasi transaksi senilai ${_formatRupiah(_grandTotal)} telah sukses diproses.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  for (var item in _cartItems) {
                    item['qty'] = 1;
                  }
                });
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas 7: State Management & Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                        colors: [Color(0xFF059669), Color(0xFF047857)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: AppShadows.medium,
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBadge(
                          label: 'Pertemuan 7 • setState & Reaktifitas Keranjang',
                          icon: LucideIcons.shoppingBag,
                          backgroundColor: Colors.white24,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: AppSpacing.md),
                        Text(
                          'Simulasi State Keranjang Belanja',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: AppSpacing.xs),
                        Text(
                          'Perubahan jumlah item memicu kalkulasi ulang subtotal, pajak PPN 11%, dan total pembayaran secara real-time.',
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
                    'Daftar Barang Belanja',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ..._cartItems.map((item) {
                    final int qty = item['qty'] as int;
                    final int harga = item['harga'] as int;

                    return AppCard(
                      margin: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            decoration: BoxDecoration(
                              color: AppColors.successSubtle,
                              borderRadius: BorderRadius.circular(AppRadius.md),
                            ),
                            child: Icon(item['ikon'] as IconData, color: AppColors.success, size: 22),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['nama'] as String,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _formatRupiah(harga),
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              AnimatedPressable(
                                scaleDown: 0.85,
                                onTap: qty > 0
                                    ? () {
                                        setState(() {
                                          item['qty'] = qty - 1;
                                        });
                                      }
                                    : null,
                                child: Container(
                                  padding: const EdgeInsets.all(AppSpacing.sm),
                                  decoration: BoxDecoration(
                                    color: qty > 0 ? AppColors.primarySubtle : Colors.grey.withAlpha(40),
                                    borderRadius: BorderRadius.circular(AppRadius.md),
                                  ),
                                  child: Icon(
                                    LucideIcons.minus,
                                    size: 16,
                                    color: qty > 0 ? AppColors.primary : Colors.grey,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm + 2),
                                child: Text(
                                  '$qty',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                              ),
                              AnimatedPressable(
                                scaleDown: 0.85,
                                onTap: () {
                                  setState(() {
                                    item['qty'] = qty + 1;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(AppSpacing.sm),
                                  decoration: BoxDecoration(
                                    color: AppColors.primarySubtle,
                                    borderRadius: BorderRadius.circular(AppRadius.md),
                                  ),
                                  child: const Icon(
                                    LucideIcons.plus,
                                    size: 16,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: AppSpacing.md),
                  AppCard(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal Produk',
                              style: TextStyle(
                                fontSize: 13,
                                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                              ),
                            ),
                            Text(_formatRupiah(_subtotal), style: const TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'PPN (11%)',
                              style: TextStyle(
                                fontSize: 13,
                                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                              ),
                            ),
                            Text(_formatRupiah(_tax), style: const TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                        const Divider(height: AppSpacing.xl),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Tagihan',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              _formatRupiah(_grandTotal),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.primary,
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
          ),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : Colors.white,
              border: Border(
                top: BorderSide(
                  color: isDark ? AppColors.borderDark : AppColors.border,
                ),
              ),
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _grandTotal > 0 ? _showCheckoutDialog : null,
                  icon: const Icon(LucideIcons.shoppingBag, size: 18),
                  label: Text('Checkout (${_formatRupiah(_grandTotal)})'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
