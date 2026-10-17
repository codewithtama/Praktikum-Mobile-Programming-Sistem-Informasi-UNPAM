import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_badge.dart';
import '../../widgets/app_card.dart';

class TugasPertemuan5 extends StatefulWidget {
  const TugasPertemuan5({super.key});

  @override
  State<TugasPertemuan5> createState() => _TugasPertemuan5State();
}

class _TugasPertemuan5State extends State<TugasPertemuan5> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _agreeTerms = false;
  bool _isSubmitting = false;
  String _selectedCategory = 'Mobile Development';

  final List<String> _categories = [
    'Mobile Development',
    'Web Engineering',
    'UI/UX Design',
    'Cloud Computing',
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (!_agreeTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.error,
            content: Text('Anda harus menyetujui syarat & ketentuan terlebih dahulu.'),
          ),
        );
        return;
      }

      setState(() {
        _isSubmitting = true;
      });

      Future.delayed(const Duration(milliseconds: 700), () {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                ),
                icon: const Icon(LucideIcons.checkCircle2, color: AppColors.success, size: 40),
                title: const Text('Registrasi Berhasil!'),
                content: Text(
                  'Data formulir untuk ${_namaController.text} (${_emailController.text}) pada peminatan $_selectedCategory berhasil divalidasi.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13, height: 1.4),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _formKey.currentState!.reset();
                      _namaController.clear();
                      _emailController.clear();
                      _passwordController.clear();
                      setState(() {
                        _agreeTerms = false;
                      });
                    },
                    child: const Text('Selesai'),
                  ),
                ],
              );
            },
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas 5: Form & Validasi Input'),
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
                  colors: [Colors.purple, Color(0xFF6B21A8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: AppShadows.medium,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBadge(
                    label: 'Pertemuan 5 • Form, TextFormField & Validasi',
                    icon: LucideIcons.fileEdit,
                    backgroundColor: Colors.white24,
                    textColor: Colors.white,
                  ),
                  SizedBox(height: AppSpacing.md),
                  Text(
                    'Formulir Registrasi Mahasiswa',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    'Validasi input data formulir reaktif dengan feedback error visual yang presisi.',
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
            AppCard(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama Lengkap',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    TextFormField(
                      controller: _namaController,
                      decoration: const InputDecoration(
                        hintText: 'Contoh: DIMAS ALFA PRATAMA',
                        prefixIcon: Icon(LucideIcons.user, size: 18),
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Nama lengkap tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'Alamat Email',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'dimas@unpam.ac.id',
                        prefixIcon: Icon(LucideIcons.mail, size: 18),
                      ),
                      validator: (val) {
                        if (val == null || !val.contains('@')) {
                          return 'Masukkan alamat email yang valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'Kata Sandi',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Minimal 6 karakter',
                        prefixIcon: const Icon(LucideIcons.lock, size: 18),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? LucideIcons.eyeOff : LucideIcons.eye,
                            size: 18,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (val) {
                        if (val == null || val.length < 6) {
                          return 'Kata sandi minimal 6 karakter';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'Peminatan Praktikum',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedCategory,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(LucideIcons.layers, size: 18),
                      ),
                      items: _categories.map((cat) {
                        return DropdownMenuItem(
                          value: cat,
                          child: Text(cat, style: const TextStyle(fontSize: 14)),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _selectedCategory = val;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      value: _agreeTerms,
                      onChanged: (val) => setState(() => _agreeTerms = val ?? false),
                      title: const Text(
                        'Saya menyetujui seluruh tata tertib dan pedoman praktikum.',
                        style: TextStyle(fontSize: 12),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isSubmitting ? null : _submitForm,
                        child: _isSubmitting
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Kirim Formulir Pendaftaran'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
