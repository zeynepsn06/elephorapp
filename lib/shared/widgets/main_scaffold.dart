import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';
import '../../core/theme/app_colors.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  static const _items = [
    _NavItem(icon: Icons.home_rounded, label: 'Ana Sayfa', path: '/'),
    _NavItem(
        icon: Icons.grid_view_rounded, label: 'Uygulamalar', path: '/apps'),
    _NavItem(icon: Icons.add, label: '', path: ''),
    _NavItem(
        icon: Icons.notifications_rounded,
        label: 'Bildirimler',
        path: '/notifications'),
    _NavItem(icon: Icons.person_rounded, label: 'Profil', path: '/profile'),
  ];

  int _getIndex(String location) {
    if (location.startsWith('/apps')) return 1;
    if (location.startsWith('/notifications')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  void _showQuickActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgPage,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Hızlı İşlemler',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black900,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _QuickActionItem(
                    icon: Icons.people_outline_rounded,
                    label: 'Yeni Vardiya',
                    color: AppColors.categoryPersonel,
                    onTap: () {
                      Navigator.pop(context);
                      context.push('/mini-apps/vardiya');
                    },
                  ),
                  _QuickActionItem(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Yeni Ödeme',
                    color: AppColors.categoryFinans,
                    onTap: () {
                      Navigator.pop(context);
                      context.push('/mini-apps/odeme');
                    },
                  ),
                  _QuickActionItem(
                    icon: Icons.calendar_today_outlined,
                    label: 'Rezervasyon',
                    color: AppColors.categoryMusteri,
                    onTap: () {
                      Navigator.pop(context);
                      context.push('/mini-apps/rezervasyon');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.bgSurface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.grid_view_rounded, color: AppColors.black900),
                ),
                title: const Text('Yeni Uygulama Ekle', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.black900)),
                subtitle: const Text('İşletmeniz için yeni araçlar keşfedin', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
                onTap: () {
                  Navigator.pop(context);
                  context.go('/apps');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _getIndex(location);
    final unread =
        context.select<AppState, int>((s) => s.unreadCount);

    return Scaffold(
      body: child,
      floatingActionButton: GestureDetector(
        onTap: () => _showQuickActionSheet(context),
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.black900,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.black900.withOpacity(0.3),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 32),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: 72,
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          border: const Border(
            top: BorderSide(
              color: AppColors.border,
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              if (i == 2) {
                // Empty space for FAB
                return const SizedBox(width: 64);
              }

              final isActive = (i < 2 ? i : i - 1) == currentIndex ||
                  (i == 0 && currentIndex == 0) ||
                  (i == 1 && currentIndex == 1) ||
                  (i == 3 && currentIndex == 3) ||
                  (i == 4 && currentIndex == 4);

              final activeCheck = {0: 0, 1: 1, 3: 3, 4: 4}[i] == currentIndex;

              return Expanded(
                child: GestureDetector(
                  onTap: () => context.go(item.path),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            item.icon,
                            size: 26,
                            color: activeCheck
                                ? AppColors.black900
                                : AppColors.textSecondary,
                          ),

                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: activeCheck ? FontWeight.w600 : FontWeight.w500,
                          color: activeCheck
                              ? AppColors.black900
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final String path;
  const _NavItem(
      {required this.icon, required this.label, required this.path});
}

class _QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        hoverColor: AppColors.bgSurface.withValues(alpha: 0.5),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
