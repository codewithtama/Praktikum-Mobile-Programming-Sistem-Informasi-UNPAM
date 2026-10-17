import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_badge.dart';
import '../../widgets/app_card.dart';

class TugasPertemuan4 extends StatelessWidget {
  const TugasPertemuan4({super.key});

  void _showModernToast(String message, {bool isSuccess = true}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: isSuccess ? const Color(0xFF0F766E) : const Color(0xFFEF4444),
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  void _showModernAlert(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xxl),
          ),
          icon: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: const BoxDecoration(
              color: AppColors.primarySubtle,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              LucideIcons.bell,
              color: AppColors.primary,
              size: 28,
            ),
          ),
          title: const Text(
            'Konfirmasi Aksi',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: Text(
            'Apakah Anda ingin melanjutkan proses simulasi data tugas pertemuan 4 ini?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                _showModernToast('Aksi berhasil dikonfirmasi!');
              },
              child: const Text('Lanjutkan'),
            ),
          ],
        );
      },
    );
  }

  void _showModernBottomSheet(BuildContext context) {
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
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.borderDark : AppColors.border,
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const Text(
                'Menu Pilihan Cepat',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Contoh komponen Modal Bottom Sheet yang modern dan elegan.',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.primarySubtle,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: const Icon(LucideIcons.share2, color: AppColors.primary, size: 18),
                ),
                title: const Text('Bagikan Tautan', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('Kirim link referensi tugas ke teman', style: TextStyle(fontSize: 12)),
                onTap: () {
                  Navigator.pop(context);
                  _showModernToast('Tautan berhasil disalin!');
                },
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
                  child: const Icon(LucideIcons.download, color: AppColors.info, size: 18),
                ),
                title: const Text('Unduh Materi', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('Simpan ringkasan PDF tugas', style: TextStyle(fontSize: 12)),
                onTap: () {
                  Navigator.pop(context);
                  _showModernToast('Unduhan disimulasikan');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showModernSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primaryDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        content: const Row(
          children: [
            Icon(LucideIcons.checkCircle2, color: Colors.white, size: 18),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                'Notifikasi SnackBar berhasil dipicu!',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          label: 'TUTUP',
          textColor: AppColors.accent,
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas 4: Dialog & Feedback'),
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
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: AppShadows.medium,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBadge(
                    label: 'Pertemuan 4 • Toast & Dialog',
                    icon: LucideIcons.messageSquare,
                    backgroundColor: Colors.white24,
                    textColor: Colors.white,
                  ),
                  SizedBox(height: AppSpacing.md),
                  Text(
                    'Sistem Feedback Interaktif',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    'Eksplorasi ragam komponen umpan balik pengguna: AlertDialog, Toast Notification, Bottom Sheet, dan Floating SnackBar.',
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
              'Uji Komponen Dialog & Toast',
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _showModernToast('Ini adalah notifikasi pesan toast.'),
                      icon: const Icon(LucideIcons.messageSquare, size: 16),
                      label: const Text('Tampilkan Toast Normal'),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _showModernAlert(context),
                      icon: const Icon(LucideIcons.info, size: 16),
                      label: const Text('Tampilkan Alert Dialog Modern'),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _showModernBottomSheet(context),
                      icon: const Icon(LucideIcons.layers, size: 16),
                      label: const Text('Tampilkan Modal Bottom Sheet'),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _showModernSnackBar(context),
                      icon: const Icon(LucideIcons.bell, size: 16),
                      label: const Text('Tampilkan Floating SnackBar'),
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
}
