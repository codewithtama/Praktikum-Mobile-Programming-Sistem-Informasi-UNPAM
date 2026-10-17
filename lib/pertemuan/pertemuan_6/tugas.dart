import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../theme/app_theme.dart';
import '../../widgets/animated_pressable.dart';
import '../../widgets/app_badge.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_card.dart';

// ============================================================================
// TUGAS PERTEMUAN 6: FORM PENDAFTARAN MAHASISWA
// Sesuai Spesifikasi Slide 23:
// - Minimal 4 TextFormField (Nama, NIM, Email, No HP, Prodi, Alamat)
// - Minimal 1 kelompok Radio Button (Jenis Kelamin & Jalur Kuliah)
// - Minimal 3 pilihan Checkbox (5 Bidang Peminatan & Persetujuan)
// - Menggunakan Form dan GlobalKey<FormState>
// - Menggunakan validator reaktif
// - Memiliki tombol Simpan
// - Menampilkan hasil input setelah Simpan ditekan (Modal Bukti & Riwayat)
// ============================================================================
class TugasPertemuan6 extends StatefulWidget {
  const TugasPertemuan6({super.key});

  @override
  State<TugasPertemuan6> createState() => _TugasPertemuan6State();
}

class _TugasPertemuan6State extends State<TugasPertemuan6> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _nimController = TextEditingController();
  final _emailController = TextEditingController();
  final _hpController = TextEditingController();
  final _alamatController = TextEditingController();

  String _jenisKelamin = 'Laki-laki';
  String _jalurKuliah = 'Reguler A (Pagi)';
  String _programStudi = 'Teknik Informatika';

  final List<String> _prodiList = [
    'Teknik Informatika',
    'Sistem Informasi',
    'Teknik Elektro',
    'Manajemen Informatika',
    'Sistem Komputer',
  ];

  final Map<String, bool> _peminatan = {
    'Mobile Application (Flutter & Android)': true,
    'Full-Stack Web Development': false,
    'UI/UX & Product Design': false,
    'Artificial Intelligence & Data Science': false,
    'Cyber Security & Cloud Computing': false,
  };

  bool _agreeTerms = true;
  bool _isSubmitting = false;
  String? _peminatanError;

  // Menyimpan riwayat data pendaftaran lokal
  final List<Map<String, dynamic>> _riwayatPendaftaran = [];

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _emailController.dispose();
    _hpController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  void _isiDataDemo() {
    setState(() {
      _namaController.text = 'Dimas Alfa Pratama';
      _nimController.text = '221011400892';
      _emailController.text = 'dimas.alfa@mahasiswa.unpam.ac.id';
      _hpController.text = '081298765432';
      _alamatController.text = 'Jl. Surya Kencana No. 1, Pamulang Barat';
      _programStudi = 'Teknik Informatika';
      _jenisKelamin = 'Laki-laki';
      _jalurKuliah = 'Reguler A (Pagi)';
      _peminatan['Mobile Application (Flutter & Android)'] = true;
      _peminatan['UI/UX & Product Design'] = true;
      _peminatan['Full-Stack Web Development'] = false;
      _peminatan['Artificial Intelligence & Data Science'] = false;
      _peminatan['Cyber Security & Cloud Computing'] = false;
      _agreeTerms = true;
      _peminatanError = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data demo pendaftaran berhasil dimuat ke formulir!'),
        backgroundColor: AppColors.info,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _namaController.clear();
    _nimController.clear();
    _emailController.clear();
    _hpController.clear();
    _alamatController.clear();

    setState(() {
      _jenisKelamin = 'Laki-laki';
      _jalurKuliah = 'Reguler A (Pagi)';
      _programStudi = 'Teknik Informatika';
      _peminatan.updateAll((key, value) => false);
      _peminatan['Mobile Application (Flutter & Android)'] = true;
      _agreeTerms = false;
      _peminatanError = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Formulir pendaftaran telah di-reset.'),
        backgroundColor: AppColors.textSecondary,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _submitForm() {
    final selectedPeminatan = _peminatan.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (selectedPeminatan.isEmpty) {
      setState(() {
        _peminatanError = 'Pilih minimal 1 bidang peminatan mahasiswa!';
      });
    } else {
      setState(() {
        _peminatanError = null;
      });
    }

    if (!_formKey.currentState!.validate() || _peminatanError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon periksa dan lengkapi input yang belum valid.'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap centang persetujuan kebenaran data mahasiswa.'),
          backgroundColor: AppColors.warning,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;

      final dataPendaftaran = {
        'id': 'REG-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        'nama': _namaController.text.trim(),
        'nim': _nimController.text.trim(),
        'email': _emailController.text.trim(),
        'hp': _hpController.text.trim(),
        'alamat': _alamatController.text.trim().isEmpty
            ? 'Tidak diisi'
            : _alamatController.text.trim(),
        'prodi': _programStudi,
        'jk': _jenisKelamin,
        'jalur': _jalurKuliah,
        'peminatan': selectedPeminatan,
        'waktu': DateTime.now(),
      };

      setState(() {
        _isSubmitting = false;
        _riwayatPendaftaran.insert(0, dataPendaftaran);
      });

      _tampilkanModalHasil(dataPendaftaran);
    });
  }

  void _tampilkanModalHasil(Map<String, dynamic> data) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final peminatanList = data['peminatan'] as List<String>;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xxl)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          maxChildSize: 0.95,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.lg,
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 5,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.borderDark : AppColors.border,
                        borderRadius: BorderRadius.circular(AppRadius.full),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            decoration: const BoxDecoration(
                              color: AppColors.successSubtle,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              LucideIcons.checkCircle2,
                              color: AppColors.success,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pendaftaran Berhasil!',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? AppColors.textPrimaryDark
                                      : AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                'Data telah divalidasi dan tersimpan.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark
                                      ? AppColors.textSecondaryDark
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(LucideIcons.x, size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.cardDark
                          : AppColors.primarySubtle.withAlpha(80),
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                      border: Border.all(
                        color: AppColors.primary.withAlpha(60),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'KARTU BUKTI PENDAFTARAN',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                color: isDark
                                    ? AppColors.primaryLight
                                    : AppColors.primaryDark,
                              ),
                            ),
                            AppBadge(
                              label: data['id'] as String,
                              backgroundColor: AppColors.primary,
                              textColor: Colors.white,
                              icon: LucideIcons.hash,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundColor: AppColors.primary,
                              child: Text(
                                (data['nama'] as String).isNotEmpty
                                    ? (data['nama'] as String)[0].toUpperCase()
                                    : 'M',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['nama'] as String,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'NIM: ${data['nim']} • ${data['prodi']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark
                                          ? AppColors.textSecondaryDark
                                          : AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _buildResultItem(
                    icon: LucideIcons.mail,
                    label: 'Alamat Email',
                    value: data['email'] as String,
                    isDark: isDark,
                  ),
                  _buildResultItem(
                    icon: LucideIcons.phone,
                    label: 'Nomor WhatsApp / HP',
                    value: data['hp'] as String,
                    isDark: isDark,
                  ),
                  _buildResultItem(
                    icon: LucideIcons.user,
                    label: 'Jenis Kelamin',
                    value: data['jk'] as String,
                    isDark: isDark,
                  ),
                  _buildResultItem(
                    icon: LucideIcons.graduationCap,
                    label: 'Jalur Perkuliahan',
                    value: data['jalur'] as String,
                    isDark: isDark,
                  ),
                  _buildResultItem(
                    icon: LucideIcons.mapPin,
                    label: 'Alamat Domisili',
                    value: data['alamat'] as String,
                    isDark: isDark,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Peminatan Terpilih (${peminatanList.length}):',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.xs,
                    children: peminatanList.map((item) {
                      return AppBadge(
                        label: item,
                        icon: LucideIcons.sparkles,
                        backgroundColor: AppColors.primarySubtle,
                        textColor: AppColors.primaryDark,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(LucideIcons.check, size: 18),
                      label: const Text('Tutup Ringkasan'),
                      onPressed: () => Navigator.pop(context),
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

  void _showInfoDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          icon: const Icon(LucideIcons.info, color: AppColors.primary, size: 32),
          title: const Text('Kriteria Tugas Pertemuan 6'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('• Minimal 4 TextFormField (Nama, NIM, Email, No HP)'),
              SizedBox(height: 6),
              Text('• Minimal 1 kelompok Radio Button (Jenis Kelamin & Jalur)'),
              SizedBox(height: 6),
              Text('• Minimal 3 pilihan Checkbox (Peminatan Mahasiswa)'),
              SizedBox(height: 6),
              Text('• Menggunakan Form & GlobalKey<FormState>'),
              SizedBox(height: 6),
              Text('• Menggunakan fungsi validator reaktif'),
              SizedBox(height: 6),
              Text('• Memiliki tombol Simpan dan Menampilkan hasil input'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Mengerti'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildResultItem({
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.xs + 2),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.background,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(
                color: isDark ? AppColors.borderDark : AppColors.border,
              ),
            ),
            child: Icon(icon, size: 16, color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas 6: Form Pendaftaran'),
        actions: [
          IconButton(
            tooltip: 'Kriteria Tugas',
            icon: const Icon(LucideIcons.info, size: 20),
            onPressed: _showInfoDialog,
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Modul Tugas 6
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.xl),
                color: isDark ? AppColors.surfaceDark : const Color(0xFF0F172A),
                border: Border.all(
                  color: isDark ? AppColors.borderDark : const Color(0xFF1E293B),
                ),
                boxShadow: AppShadows.card,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppBadge(
                    label: 'Tugas Pertemuan 6 • Form Pendaftaran Mahasiswa',
                    icon: LucideIcons.fileSpreadsheet,
                    backgroundColor: Colors.white24,
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const Text(
                    'Formulir Registrasi Mahasiswa Baru',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  const Text(
                    'Lengkapi 4 TextFormField minimal, kelompok Radio Button, dan 3 pilihan Checkbox berstatus validasi.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children: const [
                      AppBadge(
                        label: '4+ TextFormField',
                        icon: LucideIcons.check,
                        backgroundColor: Colors.white12,
                        textColor: Colors.white,
                      ),
                      AppBadge(
                        label: '2 Kelompok Radio',
                        icon: LucideIcons.check,
                        backgroundColor: Colors.white12,
                        textColor: Colors.white,
                      ),
                      AppBadge(
                        label: '5 Pilihan Checkbox',
                        icon: LucideIcons.check,
                        backgroundColor: Colors.white12,
                        textColor: Colors.white,
                      ),
                      AppBadge(
                        label: 'GlobalKey<FormState>',
                        icon: LucideIcons.check,
                        backgroundColor: Colors.white12,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Tombol Cepat: Pre-fill Dummy & Reset
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _isiDataDemo,
                    icon: const Icon(LucideIcons.sparkles, size: 16),
                    label: const Text('Isi Data Demo'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _resetForm,
                    icon: const Icon(LucideIcons.rotateCcw, size: 16),
                    label: const Text('Reset Form'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Form Utama
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section 1: Data Identitas Teks
                  _buildSectionHeader(
                    title: '1. Identitas Mahasiswa (TextFormField)',
                    subtitle: 'Wajib mengisi data teks dengan format yang tepat.',
                    icon: LucideIcons.user,
                    isDark: isDark,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppCard(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _namaController,
                          decoration: const InputDecoration(
                            labelText: 'Nama Lengkap Mahasiswa *',
                            hintText: 'Contoh: Dimas Alfa Pratama',
                            prefixIcon: Icon(LucideIcons.user, size: 18),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Nama lengkap wajib diisi!';
                            }
                            if (value.trim().length < 3) {
                              return 'Nama minimal terdiri dari 3 karakter.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _nimController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Nomor Induk Mahasiswa (NIM) *',
                            hintText: 'Contoh: 221011400892',
                            prefixIcon: Icon(LucideIcons.hash, size: 18),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'NIM wajib diisi!';
                            }
                            if (value.trim().length < 10) {
                              return 'NIM minimal berjumlah 10 digit angka.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email Kampus / Aktif *',
                            hintText: 'nama@mahasiswa.unpam.ac.id',
                            prefixIcon: Icon(LucideIcons.mail, size: 18),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email wajib diisi!';
                            }
                            final emailRegex =
                                RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                            if (!emailRegex.hasMatch(value.trim())) {
                              return 'Format email tidak valid (contoh: user@domain.com)';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _hpController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Nomor WhatsApp / HP *',
                            hintText: '081234567890',
                            prefixIcon: Icon(LucideIcons.phone, size: 18),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Nomor HP wajib diisi!';
                            }
                            if (value.trim().length < 10 ||
                                value.trim().length > 14) {
                              return 'Nomor HP harus antara 10 - 14 digit angka.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),
                        DropdownButtonFormField<String>(
                          initialValue: _programStudi,
                          decoration: const InputDecoration(
                            labelText: 'Program Studi *',
                            prefixIcon: Icon(LucideIcons.graduationCap, size: 18),
                          ),
                          items: _prodiList.map((prodi) {
                            return DropdownMenuItem(
                              value: prodi,
                              child: Text(prodi),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _programStudi = val;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _alamatController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: 'Alamat Domisili (Opsional)',
                            hintText: 'Jl. Surya Kencana, Pamulang',
                            prefixIcon: Icon(LucideIcons.mapPin, size: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Section 2: Radio Button
                  _buildSectionHeader(
                    title: '2. Pilihan Kategoris (Radio Button)',
                    subtitle: 'Pilih satu opsi dalam setiap kelompok opsi.',
                    icon: LucideIcons.checkCircle2,
                    isDark: isDark,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jenis Kelamin:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Row(
                          children: [
                            Expanded(
                              child: _buildRadioOption<String>(
                                label: 'Laki-laki',
                                value: 'Laki-laki',
                                groupValue: _jenisKelamin,
                                onChanged: (val) =>
                                    setState(() => _jenisKelamin = val),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: _buildRadioOption<String>(
                                label: 'Perempuan',
                                value: 'Perempuan',
                                groupValue: _jenisKelamin,
                                onChanged: (val) =>
                                    setState(() => _jenisKelamin = val),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: AppSpacing.xl),
                        Text(
                          'Jalur Perkuliahan Mahasiswa:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        _buildRadioOption<String>(
                          label: 'Reguler A (Kelas Pagi)',
                          value: 'Reguler A (Pagi)',
                          groupValue: _jalurKuliah,
                          onChanged: (val) => setState(() => _jalurKuliah = val),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        _buildRadioOption<String>(
                          label: 'Reguler B (Kelas Malam)',
                          value: 'Reguler B (Malam)',
                          groupValue: _jalurKuliah,
                          onChanged: (val) => setState(() => _jalurKuliah = val),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        _buildRadioOption<String>(
                          label: 'Reguler C (Kelas Eksekutif / Karyawan)',
                          value: 'Reguler C (Eksekutif)',
                          groupValue: _jalurKuliah,
                          onChanged: (val) => setState(() => _jalurKuliah = val),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Section 3: Checkbox Peminatan
                  _buildSectionHeader(
                    title: '3. Bidang Peminatan & Minat Bakat (Checkbox)',
                    subtitle: 'Pilih minimal 1 bidang keahlian di bawah ini.',
                    icon: LucideIcons.sparkles,
                    isDark: isDark,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._peminatan.keys.map((peminatanName) {
                          final isChecked = _peminatan[peminatanName] ?? false;
                          return CheckboxListTile(
                            title: Text(
                              peminatanName,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isChecked
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                            value: isChecked,
                            dense: true,
                            activeColor: AppColors.primary,
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (val) {
                              setState(() {
                                _peminatan[peminatanName] = val ?? false;
                                if (_peminatan.values.any((e) => e)) {
                                  _peminatanError = null;
                                }
                              });
                            },
                          );
                        }),
                        if (_peminatanError != null) ...[
                          const SizedBox(height: AppSpacing.xs),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.errorSubtle,
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Row(
                              children: [
                                const Icon(LucideIcons.alertCircle,
                                    color: AppColors.error, size: 16),
                                const SizedBox(width: AppSpacing.xs),
                                Text(
                                  _peminatanError!,
                                  style: const TextStyle(
                                    color: AppColors.error,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Checkbox Persetujuan Syarat
                  AppCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    child: CheckboxListTile(
                      title: const Text(
                        'Saya menyatakan bahwa data yang diisikan adalah benar dan valid sesuai identitas asli mahasiswa.',
                        style: TextStyle(fontSize: 12, height: 1.3),
                      ),
                      value: _agreeTerms,
                      dense: true,
                      activeColor: AppColors.primary,
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (val) {
                        setState(() {
                          _agreeTerms = val ?? false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Tombol Submit
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: AppButton(
                      label: 'Simpan Pendaftaran Mahasiswa',
                      icon: LucideIcons.send,
                      isLoading: _isSubmitting,
                      onPressed: _submitForm,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Riwayat Hasil Input (Tersimpan Lokal di Sesi Ini)
            if (_riwayatPendaftaran.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Data Tersimpan (${_riwayatPendaftaran.length})',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimary,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _riwayatPendaftaran.clear();
                      });
                    },
                    icon: const Icon(LucideIcons.trash2, size: 14),
                    label: const Text('Bersihkan'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.error,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              ..._riwayatPendaftaran.map((item) {
                return AppCard(
                  margin: const EdgeInsets.only(bottom: AppSpacing.md),
                  onTap: () => _tampilkanModalHasil(item),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.primarySubtle,
                        child: Text(
                          (item['nama'] as String)[0].toUpperCase(),
                          style: const TextStyle(
                            color: AppColors.primaryDark,
                            fontWeight: FontWeight.bold,
                          ),
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
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'NIM: ${item['nim']} • ${item['prodi']}',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(LucideIcons.chevronRight, size: 18),
                    ],
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption<T>({
    required String label,
    required T value,
    required T groupValue,
    required ValueChanged<T> onChanged,
  }) {
    final isSelected = value == groupValue;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedPressable(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 2,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColors.primary.withAlpha(50) : AppColors.primarySubtle)
              : (isDark ? AppColors.surfaceDark : Colors.transparent),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : (isDark ? AppColors.borderDark : AppColors.border),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 9,
                        height: 9,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected
                      ? (isDark ? AppColors.primaryLight : AppColors.primaryDark)
                      : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isDark,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.xs + 2),
          decoration: BoxDecoration(
            color: AppColors.primarySubtle,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Icon(icon, color: AppColors.primary, size: 18),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color:
                      isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
