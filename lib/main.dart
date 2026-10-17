import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'theme/app_theme.dart';
import 'pages/home.dart';
import 'pages/materi.dart';
import 'pages/profile.dart';
import 'widgets/animated_pressable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum MP',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: MainNavigation(
        isDarkMode: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool>? onToggleTheme;

  const MainNavigation({
    super.key,
    this.isDarkMode = false,
    this.onToggleTheme,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Widget> pages = [
      HomePage(onNavigateTab: _onItemTapped),
      const MateriPage(),
      ProfilePage(
        isDarkMode: widget.isDarkMode,
        onToggleTheme: widget.onToggleTheme,
      ),
    ];

    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 280),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.015, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: KeyedSubtree(
          key: ValueKey<int>(_selectedIndex),
          child: pages[_selectedIndex],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(AppSpacing.xl, 0, AppSpacing.xl, AppSpacing.md),
          height: 66,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B).withAlpha(240) : Colors.white.withAlpha(240),
            borderRadius: BorderRadius.circular(33),
            border: Border.all(
              color: isDark ? AppColors.borderDark.withAlpha(120) : AppColors.border.withAlpha(160),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: (isDark ? Colors.black : const Color(0xFF0F172A)).withAlpha(20),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                icon: LucideIcons.home,
                label: 'Home',
                isDark: isDark,
              ),
              _buildNavItem(
                index: 1,
                icon: LucideIcons.bookOpen,
                label: 'Materi',
                isDark: isDark,
              ),
              _buildNavItem(
                index: 2,
                icon: LucideIcons.user,
                label: 'Profile',
                isDark: isDark,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    required bool isDark,
  }) {
    final isSelected = _selectedIndex == index;

    return AnimatedPressable(
      onTap: () => _onItemTapped(index),
      scaleDown: 0.92,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? AppSpacing.lg : AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColors.primaryLight.withAlpha(40) : AppColors.primarySubtle)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.15 : 1.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutBack,
              child: Icon(
                icon,
                size: 20,
                color: isSelected
                    ? (isDark ? AppColors.primaryLight : AppColors.primary)
                    : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
              ),
            ),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 200),
              crossFadeState: isSelected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              firstChild: Padding(
                padding: const EdgeInsets.only(left: AppSpacing.xs + 2),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.primaryLight : AppColors.primary,
                  ),
                ),
              ),
              secondChild: const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
