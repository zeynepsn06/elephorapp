import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../core/theme/app_colors.dart';
import '../../state/app_state.dart';
import '../../models/mini_app_model.dart';
import '../../shared/widgets/state_widgets.dart';

class AppDetailScreen extends StatefulWidget {
  final String appId;
  const AppDetailScreen({super.key, required this.appId});

  @override
  State<AppDetailScreen> createState() => _AppDetailScreenState();
}

class _AppDetailScreenState extends State<AppDetailScreen>
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
    final appState = context.watch<AppState>();
    final app = appState.getAppById(widget.appId);

    if (app == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const ErrorStateWidget(message: 'Uygulama bulunamadı.'),
      );
    }

    // Determine an active color based on app category or a default primary.
    // The design shows a deep blue/purple (like categoryPersonel).
    final Color activeColor = app.iconColor;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // App Header
            SliverAppBar(
              backgroundColor: AppColors.bgLight,
              foregroundColor: AppColors.textPrimary,
              elevation: 0,
              pinned: true,
              expandedHeight: 240,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () => context.pop(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        activeColor.withValues(alpha: 0.2),
                        AppColors.bgLight,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: activeColor.withValues(alpha: 0.15),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Icon(app.icon, color: activeColor, size: 40),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        app.name,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        app.category,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: activeColor, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Custom Tab Bar
            SliverPersistentHeader(
              pinned: true,
              delegate: _TabBarDelegate(
                tabController: _tabController,
                activeColor: activeColor,
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // 1. Genel Bakış
            _GenelBakisTab(app: app),
            // 2. Raporlar
            const _PlaceholderTab(
                title: 'Raporlar',
                message: 'Rapor özellikleri yakında burada olacak.'),
            // 3. Ekip İzinleri
            _EkipIzinleriTab(app: app),
            // 4. Ayarlar
            const _PlaceholderTab(
                title: 'Ayarlar',
                message: 'Uygulama ayarları yakında burada olacak.'),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        decoration: BoxDecoration(
          color: AppColors.bgLight,
          border: Border(
            top: BorderSide(color: AppColors.borderLight.withValues(alpha: 0.5)),
          ),
        ),
        child: _buildActionButton(context, app, appState),
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, MiniAppModel app, AppState state) {
    switch (app.status) {
      case MiniAppStatus.added:
        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  state.removeApp(app.id);
                  context.pop();
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  foregroundColor: AppColors.danger,
                  side: const BorderSide(color: AppColors.danger),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Kaldır',
                    style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.pop();
                  context.push(app.route);
                },
                icon: const Icon(Icons.open_in_new_rounded),
                label: const Text('Aç',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: app.iconColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
          ],
        );
      case MiniAppStatus.premium:
        return Container(
          decoration: BoxDecoration(
            gradient: AppColors.premiumGradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ElevatedButton.icon(
            onPressed: () => context.push('/subscription'),
            icon: const Icon(Icons.workspace_premium_rounded),
            label: const Text('Pro ile Kullan',
                style: TextStyle(fontWeight: FontWeight.w700)),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.white,
            ),
          ),
        );
      case MiniAppStatus.comingSoon:
        return ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: AppColors.bgSurface,
            foregroundColor: AppColors.textSecondary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text('Yakında Kullanılabilir',
              style: TextStyle(fontWeight: FontWeight.w700)),
        );
      default:
        return ElevatedButton.icon(
          onPressed: () {
            state.addApp(app.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${app.name} ana sayfanıza eklendi!'),
                backgroundColor: AppColors.primaryGreen,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            );
          },
          icon: const Icon(Icons.add_rounded),
          label: const Text('Uygulamayı Ekle',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: app.iconColor, // Adapt button color to app
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            elevation: 0,
          ),
        );
    }
  }
}

// ── Tab Bar Delegate ────────────────────────────────────────────────────────

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;
  final Color activeColor;

  _TabBarDelegate({required this.tabController, required this.activeColor});

  @override
  double get minExtent => 90;
  @override
  double get maxExtent => 90;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.bgLight,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      alignment: Alignment.center,
      child: Container(
        height: 74,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.black900.withValues(alpha: 0.04),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TabBar(
          controller: tabController,
          indicator: const BoxDecoration(), // Hide default indicator
          dividerColor: Colors.transparent,
          labelPadding: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          tabs: [
            _buildTab(0, 'Genel Bakış', Icons.diamond_outlined, true),
            _buildTab(1, 'Raporlar', Icons.insert_drive_file_outlined, false),
            _buildTab(2, 'Ekip İzinleri', Icons.people_outline_rounded, false),
            _buildTab(3, 'Ayarlar', Icons.settings_outlined, false),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(int index, String label, IconData icon, bool useDiamond) {
    return AnimatedBuilder(
      animation: tabController,
      builder: (context, _) {
        final isSelected = tabController.index == index;
        return Tab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSelected && useDiamond)
                Transform.rotate(
                  angle: math.pi / 4,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: activeColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                )
              else
                Icon(
                  icon,
                  color: isSelected ? activeColor : AppColors.textHint,
                  size: 22,
                ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? activeColor : AppColors.textHint,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool shouldRebuild(covariant _TabBarDelegate oldDelegate) {
    return oldDelegate.tabController != tabController ||
        oldDelegate.activeColor != activeColor;
  }
}

// ── Tab Views ───────────────────────────────────────────────────────────────

class _GenelBakisTab extends StatelessWidget {
  final MiniAppModel app;
  const _GenelBakisTab({required this.app});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // About
        _Section(
          title: 'Uygulama Hakkında',
          child: Text(
            app.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
          ),
        ),
        const SizedBox(height: 20),

        // Features
        if (app.features.isNotEmpty)
          _Section(
            title: 'Özellikler',
            child: Column(
              children:
                  app.features.map((f) => _FeatureRow(label: f)).toList(),
            ),
          ),
      ],
    );
  }
}

class _EkipIzinleriTab extends StatelessWidget {
  final MiniAppModel app;
  const _EkipIzinleriTab({required this.app});

  @override
  Widget build(BuildContext context) {
    if (app.permissions.isEmpty) {
      return const _PlaceholderTab(
        title: 'Ekip İzinleri',
        message: 'Bu uygulama için tanımlı özel ekip izni bulunmuyor.',
      );
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _Section(
          title: 'Rol ve İzinler',
          subtitle: 'Bu uygulama ekip üyeleriyle kullanılabilir.',
          child: Column(
            children: app.permissions
                .map((p) => _PermissionRow(label: p, color: app.iconColor))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  final String title;
  final String message;

  const _PlaceholderTab({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline_rounded,
              size: 48, color: AppColors.textHint.withValues(alpha: 0.5)),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textHint,
                ),
          ),
        ],
      ),
    );
  }
}

// ── Reusable Components ──────────────────────────────────────────────────────

class _Section extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;

  const _Section({required this.title, this.subtitle, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: AppColors.black900.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.textSecondary),
            ),
          ],
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final String label;
  const _FeatureRow({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFF4F46E5).withValues(alpha: 0.12), // match purple tick
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.check_rounded,
                color: Color(0xFF4F46E5), size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

class _PermissionRow extends StatelessWidget {
  final String label;
  final Color color;
  const _PermissionRow({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.shield_outlined, color: color, size: 14),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
