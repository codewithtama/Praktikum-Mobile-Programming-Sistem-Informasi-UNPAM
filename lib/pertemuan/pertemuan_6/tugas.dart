import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../theme/app_theme.dart';
import '../../widgets/animated_pressable.dart';
import '../../widgets/app_badge.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_card.dart';

class TugasPertemuan6 extends StatefulWidget {
  const TugasPertemuan6({super.key});

  @override
  State<TugasPertemuan6> createState() => _TugasPertemuan6State();
}

class _TugasPertemuan6State extends State<TugasPertemuan6>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pertemuan 6: Form Flutter'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppColors.primary,
          unselectedLabelColor:
              isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          tabs: const [
            Tab(
              icon: Icon(LucideIcons.clipboardList, size: 18),
              text: 'Tugas Utama',
            ),
            Tab(
              icon: Icon(LucideIcons.userCheck, size: 18),
              text: 'Latihan 1: Biodata',
            ),
            Tab(
              icon: Icon(LucideIcons.fileSpreadsheet, size: 18),
              text: 'Latihan 2: Registrasi',
            ),
            Tab(
              icon: Icon(LucideIcons.info, size: 18),
              text: 'Alur & Konsep',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _TugasPendaftaranView(),
          _LatihanBiodataView(),
          _LatihanRegistrasiView(),
          _KesimpulanAlurView(),
        ],
      ),
    );
  }
}

// ============================================================================
// TAB 1: TUGAS UTAMA PERTEMUAN 6 (FORM PENDAFTARAN MAHASISWA)
// Sesuai Spesifikasi Slide 23:
// - Minimal 4 TextFormField
// - Minimal 1 kelompok Radio Button
// - Minimal 3 pilihan Checkbox
// - Menggunakan Form dan GlobalKey<FormState>
// - Menggunakan validator
// - Memiliki tombol Simpan
// - Menampilkan hasil input setelah Simpan ditekan
// ============================================================================
class _TugasPendaftaranView extends StatefulWidget {
  const _TugasPendaftaranView();

  @override
  State<_TugasPendaftaranView> createState() => _TugasPendaftaranViewState();
}

class _TugasPendaftaranViewState extends State<_TugasPendaftaranView> {
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

  // Menyimpan riwayat hasil submit lokal
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
        content: Text('Data demo mahasiswa berhasil dimuat ke formulir!'),
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
        content: Text('Formulir telah di-reset.'),
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
          content: Text('Mohon perbaiki kolom input yang belum valid.'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Centang persetujuan data sebelum menyimpan.'),
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

    return SingleChildScrollView(
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
              gradient: const LinearGradient(
                colors: [Color(0xFF0F766E), Color(0xFF1E3A8A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: AppShadows.medium,
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

// ============================================================================
// TAB 2: LATIHAN 1 (FORM BIODATA)
// Sesuai Spesifikasi Slide 22:
// 1. Buat aplikasi form biodata mahasiswa
// 2. Input minimal: nama lengkap, NIM, email, nomor HP
// 3. Jenis kelamin dengan Radio Button
// 4. Hobi dengan minimal tiga Checkbox
// 5. Nama, NIM, dan email wajib divalidasi
// 6. Tombol Simpan menampilkan hasil input
// ============================================================================
class _LatihanBiodataView extends StatefulWidget {
  const _LatihanBiodataView();

  @override
  State<_LatihanBiodataView> createState() => _LatihanBiodataViewState();
}

class _LatihanBiodataViewState extends State<_LatihanBiodataView> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _nimController = TextEditingController();
  final _emailController = TextEditingController();
  final _hpController = TextEditingController();

  String _jenisKelamin = 'Laki-laki';

  final Map<String, bool> _hobi = {
    'Membaca Buku': true,
    'Olahraga & Lari': true,
    'Bermain Musik': false,
    'Coding & Problem Solving': true,
    'Fotografi': false,
  };

  Map<String, dynamic>? _hasilBiodata;

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _emailController.dispose();
    _hpController.dispose();
    super.dispose();
  }

  void _simpanBiodata() {
    if (_formKey.currentState!.validate()) {
      final hobiTerpilih = _hobi.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

      if (hobiTerpilih.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pilihlah minimal 1 hobi Anda!'),
            backgroundColor: AppColors.warning,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      setState(() {
        _hasilBiodata = {
          'nama': _namaController.text.trim(),
          'nim': _nimController.text.trim(),
          'email': _emailController.text.trim(),
          'hp': _hpController.text.trim().isEmpty
              ? 'Tidak diisi'
              : _hpController.text.trim(),
          'jk': _jenisKelamin,
          'hobi': hobiTerpilih,
        };
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Hasil Biodata Mahasiswa Berhasil Ditampilkan!'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : Colors.blue.shade50,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBadge(
                  label: 'Slide 22 • Latihan 1: Form Biodata',
                  icon: LucideIcons.userCheck,
                  backgroundColor: AppColors.info,
                  textColor: Colors.white,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Formulir Biodata Mahasiswa',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textPrimaryDark : Colors.blue.shade900,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Input Nama, NIM, Email, No HP dengan validasi, Radio Button jenis kelamin, dan checkbox hobi.',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.textSecondaryDark : Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Form(
            key: _formKey,
            child: AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _namaController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Lengkap *',
                      prefixIcon: Icon(LucideIcons.user, size: 18),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Nama lengkap wajib divalidasi!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextFormField(
                    controller: _nimController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'NIM Mahasiswa *',
                      prefixIcon: Icon(LucideIcons.hash, size: 18),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'NIM wajib divalidasi!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Mahasiswa *',
                      prefixIcon: Icon(LucideIcons.mail, size: 18),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Email wajib divalidasi!';
                      }
                      if (!val.contains('@') || !val.contains('.')) {
                        return 'Format email tidak valid!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextFormField(
                    controller: _hpController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Nomor HP',
                      prefixIcon: Icon(LucideIcons.phone, size: 18),
                    ),
                  ),
                  const Divider(height: AppSpacing.xl),
                  Text(
                    'Jenis Kelamin (Radio Button):',
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
                        child: _buildRadioTile(
                          label: 'Laki-laki',
                          value: 'Laki-laki',
                          groupValue: _jenisKelamin,
                          onChanged: (val) =>
                              setState(() => _jenisKelamin = val),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: _buildRadioTile(
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
                    'Hobi Mahasiswa (Minimal Tiga Checkbox):',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  ..._hobi.keys.map((item) {
                    return CheckboxListTile(
                      title: Text(item, style: const TextStyle(fontSize: 13)),
                      value: _hobi[item],
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (val) {
                        setState(() {
                          _hobi[item] = val ?? false;
                        });
                      },
                    );
                  }),
                  const SizedBox(height: AppSpacing.lg),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(LucideIcons.save, size: 18),
                      label: const Text('Simpan Biodata'),
                      onPressed: _simpanBiodata,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Tampilan Hasil Input (Syarat 6: Tombol Simpan Menampilkan Hasil Input)
          if (_hasilBiodata != null) ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: isDark ? AppColors.cardDark : Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: AppColors.success, width: 1.5),
                boxShadow: AppShadows.soft,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(LucideIcons.checkCircle2,
                          color: AppColors.success, size: 20),
                      SizedBox(width: AppSpacing.xs),
                      Text(
                        'Hasil Input Biodata Mahasiswa',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: AppSpacing.lg),
                  _buildRowDetail('Nama Lengkap', _hasilBiodata!['nama'] as String),
                  _buildRowDetail('NIM', _hasilBiodata!['nim'] as String),
                  _buildRowDetail('Email', _hasilBiodata!['email'] as String),
                  _buildRowDetail('Nomor HP', _hasilBiodata!['hp'] as String),
                  _buildRowDetail('Jenis Kelamin', _hasilBiodata!['jk'] as String),
                  _buildRowDetail(
                    'Daftar Hobi',
                    (_hasilBiodata!['hobi'] as List<String>).join(', '),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRadioTile({
    required String label,
    required String value,
    required String groupValue,
    required ValueChanged<String> onChanged,
  }) {
    final isSelected = value == groupValue;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedPressable(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColors.primary.withAlpha(40) : AppColors.primarySubtle)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : (isDark ? AppColors.borderDark : AppColors.border),
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? LucideIcons.checkCircle2
                  : LucideIcons.circle,
              size: 16,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const Text(': ', style: TextStyle(fontSize: 12)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// TAB 3: LATIHAN 2 (FORM REGISTRASI)
// Sesuai Spesifikasi Slide 22:
// - TextFormField: Nama Lengkap, NIM, Program Studi
// - Radio Button: L/P, Semester 2 / 4 / 6 / 8
// - Checkbox: Coding, Membaca, Gaming, Olahraga
// - Tombol: DAFTAR
// - Setelah DAFTAR ditekan, tampilkan seluruh data yang dipilih atau dimasukkan.
// ============================================================================
class _LatihanRegistrasiView extends StatefulWidget {
  const _LatihanRegistrasiView();

  @override
  State<_LatihanRegistrasiView> createState() => _LatihanRegistrasiViewState();
}

class _LatihanRegistrasiViewState extends State<_LatihanRegistrasiView> {
  final _namaController = TextEditingController(text: 'Dimas Alfa Pratama');
  final _nimController = TextEditingController(text: '221011400892');
  final _prodiController = TextEditingController(text: 'Teknik Informatika');

  String _gender = 'L';
  String _semester = 'Semester 4';

  bool _coding = true;
  bool _membaca = false;
  bool _gaming = true;
  bool _olahraga = true;

  Map<String, dynamic>? _submittedData;

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _prodiController.dispose();
    super.dispose();
  }

  void _onDaftar() {
    final List<String> hobiDipilih = [];
    if (_coding) hobiDipilih.add('Coding');
    if (_membaca) hobiDipilih.add('Membaca');
    if (_gaming) hobiDipilih.add('Gaming');
    if (_olahraga) hobiDipilih.add('Olahraga');

    setState(() {
      _submittedData = {
        'nama': _namaController.text,
        'nim': _nimController.text,
        'prodi': _prodiController.text,
        'gender': _gender == 'L' ? 'L (Laki-laki)' : 'P (Perempuan)',
        'semester': _semester,
        'hobi': hobiDipilih.isEmpty
            ? 'Tidak ada hobi dipilih'
            : hobiDipilih.join(', '),
      };
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pendaftaran Latihan 2 Berhasil Diproses!'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : Colors.teal.shade50,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: Colors.teal.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBadge(
                  label: 'Slide 22 • Latihan 2: Form Registrasi',
                  icon: LucideIcons.fileSpreadsheet,
                  backgroundColor: AppColors.primary,
                  textColor: Colors.white,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Formulir Registrasi Mahasiswa (Latihan 2)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : Colors.teal.shade900,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'TextFormField: Nama, NIM, Prodi | Radio: L/P & Semester 2/4/6/8 | Checkbox: Coding, Membaca, Gaming, Olahraga.',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : Colors.teal.shade700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Card Form Sesuai Slide 22
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag TextFormField
                const AppBadge(
                  label: 'TextFormField',
                  backgroundColor: AppColors.primarySubtle,
                  textColor: AppColors.primaryDark,
                ),
                const SizedBox(height: AppSpacing.sm),
                TextField(
                  controller: _namaController,
                  decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                ),
                const SizedBox(height: AppSpacing.sm),
                TextField(
                  controller: _nimController,
                  decoration: const InputDecoration(labelText: 'NIM'),
                ),
                const SizedBox(height: AppSpacing.sm),
                TextField(
                  controller: _prodiController,
                  decoration: const InputDecoration(labelText: 'Program Studi'),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Tag Radio Button
                const AppBadge(
                  label: 'Radio Button',
                  backgroundColor: AppColors.warningSubtle,
                  textColor: AppColors.warning,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Jenis Kelamin:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    _buildRadioChip(
                      label: 'L',
                      value: 'L',
                      groupValue: _gender,
                      onChanged: (val) => setState(() => _gender = val),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    _buildRadioChip(
                      label: 'P',
                      value: 'P',
                      groupValue: _gender,
                      onChanged: (val) => setState(() => _gender = val),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Semester Pilihan:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.xs,
                  children: [
                    'Semester 2',
                    'Semester 4',
                    'Semester 6',
                    'Semester 8',
                  ].map((sem) {
                    return _buildRadioChip(
                      label: sem,
                      value: sem,
                      groupValue: _semester,
                      onChanged: (val) => setState(() => _semester = val),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.md),

                // Tag Checkbox
                const AppBadge(
                  label: 'Checkbox',
                  backgroundColor: AppColors.successSubtle,
                  textColor: AppColors.success,
                ),
                const SizedBox(height: AppSpacing.xs),
                Wrap(
                  spacing: AppSpacing.lg,
                  runSpacing: AppSpacing.xs,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: _coding,
                          onChanged: (v) =>
                              setState(() => _coding = v ?? false),
                        ),
                        const Text('Coding', style: TextStyle(fontSize: 13)),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: _membaca,
                          onChanged: (v) =>
                              setState(() => _membaca = v ?? false),
                        ),
                        const Text('Membaca', style: TextStyle(fontSize: 13)),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: _gaming,
                          onChanged: (v) =>
                              setState(() => _gaming = v ?? false),
                        ),
                        const Text('Gaming', style: TextStyle(fontSize: 13)),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: _olahraga,
                          onChanged: (v) =>
                              setState(() => _olahraga = v ?? false),
                        ),
                        const Text('Olahraga', style: TextStyle(fontSize: 13)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),

                // Tombol DAFTAR (Persis di slide 22 tombol bertuliskan DAFTAR)
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E40AF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                    ),
                    onPressed: _onDaftar,
                    child: const Text(
                      'DAFTAR',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Tampilan Hasil Input (Setelah DAFTAR ditekan, tampilkan seluruh data yang dipilih atau dimasukkan)
          if (_submittedData != null) ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: isDark ? AppColors.cardDark : Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: const Color(0xFF1E40AF), width: 1.5),
                boxShadow: AppShadows.soft,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(LucideIcons.checkCheck,
                          color: Color(0xFF1E40AF), size: 20),
                      SizedBox(width: AppSpacing.xs),
                      Text(
                        'Seluruh Data Mahasiswa Terdaftar',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E40AF),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: AppSpacing.lg),
                  _buildRegItem(
                      'Nama Lengkap', _submittedData!['nama'] as String),
                  _buildRegItem('NIM', _submittedData!['nim'] as String),
                  _buildRegItem(
                      'Program Studi', _submittedData!['prodi'] as String),
                  _buildRegItem(
                      'Jenis Kelamin', _submittedData!['gender'] as String),
                  _buildRegItem(
                      'Semester', _submittedData!['semester'] as String),
                  _buildRegItem(
                      'Hobi Dipilih', _submittedData!['hobi'] as String),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRadioChip({
    required String label,
    required String value,
    required String groupValue,
    required ValueChanged<String> onChanged,
  }) {
    final isSelected = value == groupValue;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedPressable(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF1E40AF)
              : (isDark ? AppColors.surfaceDark : Colors.grey.shade100),
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E40AF) : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected
                ? Colors.white
                : (isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimary),
          ),
        ),
      ),
    );
  }

  Widget _buildRegItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const Text(': ', style: TextStyle(fontSize: 12)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// TAB 4: KESIMPULAN & ALUR PIPELINE FORM FLUTTER
// Sesuai Spesifikasi Slide 24:
// TextFormField -> Controller -> Form + Key -> validator -> Checkbox / Radio
// -> setState() -> Submit & tampilkan
// ============================================================================
class _KesimpulanAlurView extends StatelessWidget {
  const _KesimpulanAlurView();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final steps = [
      {
        'step': '1',
        'title': 'TextFormField',
        'desc':
            'Kolom input teks pengguna dengan konfigurasi keyboard (email, phone, text), ikon, dan hint.',
        'icon': LucideIcons.fileText,
        'color': AppColors.info,
      },
      {
        'step': '2',
        'title': 'TextEditingController',
        'desc':
            'Objek controller untuk mengelola, membaca isi, serta mengosongkan nilai teks di memori program.',
        'icon': LucideIcons.code,
        'color': AppColors.secondary,
      },
      {
        'step': '3',
        'title': 'Form + GlobalKey<FormState>',
        'desc':
            'Wadah sentral yang mengelompokkan input dan memicu validasi serentak melalui _formKey.currentState!.validate().',
        'icon': LucideIcons.shieldCheck,
        'color': AppColors.primary,
      },
      {
        'step': '4',
        'title': 'validator Function',
        'desc':
            'Fungsi uji keabsahan format teks (regex email, angka NIM minimal 10 digit, batas karakter).',
        'icon': LucideIcons.alertCircle,
        'color': AppColors.warning,
      },
      {
        'step': '5',
        'title': 'Checkbox & Radio Button',
        'desc':
            'Komponen seleksi jamak (Checkbox) dan opsi tunggal (Radio Button) untuk data kategoris mahasiswa.',
        'icon': LucideIcons.checkSquare,
        'color': AppColors.success,
      },
      {
        'step': '6',
        'title': 'setState()',
        'desc':
            'Reaktivitas pembaruan status internal widget saat pengguna memilih opsi atau memicu perubahan data.',
        'icon': LucideIcons.rotateCw,
        'color': Colors.deepOrange,
      },
      {
        'step': '7',
        'title': 'Submit & Tampilkan',
        'desc':
            'Penyimpanan data yang berhasil divalidasi dan merendernya dalam dialog modal maupun kartu ringkasan.',
        'icon': LucideIcons.send,
        'color': const Color(0xFF1E40AF),
      },
    ];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Slide 24
          Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.xl),
              gradient: const LinearGradient(
                colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: AppShadows.medium,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBadge(
                  label: 'Slide 24 • Kesimpulan & Alur Arsitektur Form',
                  icon: LucideIcons.sparkles,
                  backgroundColor: Colors.white24,
                  textColor: Colors.white,
                ),
                SizedBox(height: AppSpacing.md),
                Text(
                  'Alur Lengkap Pembuatan Form Flutter',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  'Membangun form dari dasar: kolom teks, pilihan opsi, validasi reaktif, hingga menampilkan data output.',
                  style: TextStyle(
                      fontSize: 13, color: Colors.white70, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          Text(
            'Pipeline Alur 7 Tahap (Slide 24):',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Langkah Alur Step-by-Step
          ...steps.map((item) {
            final color = item['color'] as Color;
            return AppCard(
              margin: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: color.withAlpha(25),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: color.withAlpha(80)),
                    ),
                    child: Center(
                      child: Text(
                        item['step'] as String,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item['desc'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondary,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(item['icon'] as IconData, size: 20, color: color),
                ],
              ),
            );
          }),
          const SizedBox(height: AppSpacing.lg),

          // Card Konsep Dasar
          AppCard(
            backgroundColor: isDark
                ? AppColors.cardDark
                : AppColors.primarySubtle.withAlpha(60),
            border: Border.all(color: AppColors.primary.withAlpha(50)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(LucideIcons.info, size: 18, color: AppColors.primary),
                    SizedBox(width: AppSpacing.xs),
                    Text(
                      'Penerapan Konsep Ini ke Depan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                const Text(
                  'Pemahaman arsitektur Form dan validasi ini menjadi fondasi utama dalam pembuatan:',
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: const [
                    AppBadge(
                      label: 'Registrasi Mahasiswa',
                      icon: LucideIcons.userCheck,
                    ),
                    AppBadge(
                      label: 'Form Biodata',
                      icon: LucideIcons.fileText,
                    ),
                    AppBadge(
                      label: 'Autentikasi / Login',
                      icon: LucideIcons.shieldCheck,
                    ),
                    AppBadge(
                      label: 'Sistem Pemesanan',
                      icon: LucideIcons.shoppingBag,
                    ),
                    AppBadge(
                      label: 'Operasi CRUD Database & API',
                      icon: LucideIcons.database,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
