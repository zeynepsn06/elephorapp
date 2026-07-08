import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../state/app_state.dart';
import '../../models/mini_app_model.dart';
import '../../core/constants/app_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 20,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/elephor-mark.png',
              width: 28,
              height: 28,
              color: AppColors.black900,
            ),
            const SizedBox(width: 8),
            const Text(
              'Elephor+',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: AppColors.black900,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              appState.themeMode == ThemeMode.dark
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              color: AppColors.black900,
            ),
            onPressed: () => appState.toggleThemeMode(),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: AppColors.black900),
            onPressed: () => context.push('/notifications'),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16, left: 4),
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: AppColors.black900,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'EA',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // ── Greeting + Date Filter ───────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Merhaba Eren',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Bugün işletmende\nneler oluyor?',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: AppColors.black900,
                            height: 1.15,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Date chip
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.bgCard,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.black900),
                        SizedBox(width: 6),
                        Text(
                          'Bugün',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black900,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: AppColors.black900),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ── Summary Cards ────────────────────────────────────────────
            if (appState.addedApps.isNotEmpty)
              SizedBox(
                height: 155,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  clipBehavior: Clip.none,
                  itemCount: appState.addedApps.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, i) {
                    final app = appState.addedApps[i];
                    return GestureDetector(
                      onTap: () => context.push(app.route),
                      child: Container(
                        width: 130,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.bgCard,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppColors.border),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Black rounded icon
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: app.iconBgColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(app.icon, color: app.iconColor, size: 20),
                            ),
                            const Spacer(),
                            // Value
                            Text(
                              app.summaryValue ?? '-',
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                                color: AppColors.black900,
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Title row with chevron
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    app.summaryTitle ?? app.name,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.black900,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Icon(Icons.chevron_right_rounded, size: 14, color: AppColors.black900),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              app.summarySubtitle ?? '',
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              const SizedBox.shrink(),

            const SizedBox(height: 32),

            // ── Uygulamalarım ────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Uygulamalarım',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.black900,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.go('/apps'),
                    child: Row(
                      children: const [
                        Text(
                          'Tümünü Gör',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(width: 2),
                        Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.textSecondary),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Horizontal app cards
            if (appState.addedApps.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.add_to_home_screen_rounded, size: 40, color: AppColors.textHint.withValues(alpha: 0.5)),
                        const SizedBox(height: 12),
                        const Text(
                          'Henüz Uygulama Eklenmedi',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Uygulamalar sekmesinden ihtiyacınız olan uygulamaları ekleyebilirsiniz.',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => context.go('/apps'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.black900,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Uygulamalara Git', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              SizedBox(
                height: 235,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  clipBehavior: Clip.none,
                  itemCount: appState.addedApps.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, i) {
                    final app = appState.addedApps[i];
                    return _MyAppCard(
                      app: app,
                      stat: app.dailySummary ?? 'Veri yok',
                      statIcon: Icons.analytics_outlined,
                      onTap: () => context.push('/apps/detail/${app.id}'),
                      onOpen: () => context.push(app.route),
                    );
                  },
                ),
              ),

            if (appState.addedApps.isNotEmpty) ...[
              const SizedBox(height: 32),
              _buildRecentActivities(appState),
            ],

            const SizedBox(height: 32),

            // ── Önerilen Uygulamalar ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Önerilen Uygulamalar',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.black900,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.go('/apps'),
                    child: Row(
                      children: const [
                        Text(
                          'Tümünü Gör',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(width: 2),
                        Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.textSecondary),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Suggested list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _SuggestedAppTile(
                    icon: Icons.bar_chart_rounded,
                    name: 'Raporlama',
                    description: 'İşletmenize dair detaylı raporlar ve analizler alın.',
                    status: MiniAppStatus.notAdded,
                    onTap: () {},
                    onAction: () {},
                  ),
                  const SizedBox(height: 1),
                  _SuggestedAppTile(
                    icon: Icons.people_rounded,
                    name: 'Müşteri Yönetimi',
                    description: 'Müşteri bilgilerini düzenli tutun ve erişiminizi artırın.',
                    status: MiniAppStatus.premium,
                    onTap: () {},
                    onAction: () {},
                  ),
                  const SizedBox(height: 1),
                  _SuggestedAppTile(
                    icon: Icons.inventory_2_rounded,
                    name: 'Stok Yönetimi',
                    description: 'Stok giriş-çıkışlarını takip edin ve envanterinizi kontrol altında tutun.',
                    status: MiniAppStatus.notAdded,
                    onTap: () {},
                    onAction: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivities(AppState appState) {
    // Generate some mock activities based on active apps
    final mockActivities = <Map<String, dynamic>>[];
    
    if (appState.hasApp('vardiya')) {
      mockActivities.add({'app': 'Vardiya Takip', 'icon': Icons.schedule_rounded, 'color': AppColors.categoryPersonel, 'text': 'Ahmet Yılmaz vardiyaya giriş yaptı.', 'time': '10 dk önce'});
    }
    if (appState.hasApp('siparis')) {
      mockActivities.add({'app': 'Sipariş Takibi', 'icon': Icons.local_shipping_rounded, 'color': AppColors.categoryOperasyon, 'text': 'Yeni sipariş (SP-1001) oluşturuldu.', 'time': '1 saat önce'});
      mockActivities.add({'app': 'Sipariş Takibi', 'icon': Icons.inventory_2_rounded, 'color': AppColors.categoryOperasyon, 'text': 'SP-0999 teslim edildi.', 'time': '2 saat önce'});
    }
    if (appState.hasApp('izin')) {
      mockActivities.add({'app': 'İzin Yönetimi', 'icon': Icons.event_busy_rounded, 'color': AppColors.categoryOperasyon, 'text': 'Ayşe Kaya izin talebi gönderdi.', 'time': '3 saat önce'});
    }
    if (appState.hasApp('gelir_gider')) {
      mockActivities.add({'app': 'Gelir-Gider', 'icon': Icons.account_balance_rounded, 'color': AppColors.categoryFinans, 'text': 'Kasaya 15.000 ₺ gelir eklendi.', 'time': '4 saat önce'});
    }
    if (appState.hasApp('gorev')) {
      mockActivities.add({'app': 'Görev', 'icon': Icons.task_alt_rounded, 'color': AppColors.categoryOperasyon, 'text': 'Yeni görev eklendi: Pazar Analizi', 'time': '4 saat önce'});
    }
    if (appState.hasApp('crm')) {
      mockActivities.add({'app': 'CRM', 'icon': Icons.groups_rounded, 'color': AppColors.categoryMusteri, 'text': 'Müşteri görüşmesi eklendi.', 'time': '5 saat önce'});
    }

    if (mockActivities.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Son Aktiviteler',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.black900,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: mockActivities.map((act) {
                final isLast = mockActivities.last == act;
                return Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: (act['color'] as Color).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(act['icon'] as IconData, size: 16, color: act['color'] as Color),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              act['text'] as String,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black900,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${act['app']} • ${act['time']}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textHint,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Data class ─────────────────────────────────────────────────────────────
class _SummaryData {
  final IconData icon;
  final String value;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _SummaryData({
    required this.icon,
    required this.value,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}

// ── My App Card (vertical, horizontal scroll) ───────────────────────────────
class _MyAppCard extends StatelessWidget {
  final MiniAppModel app;
  final String stat;
  final IconData statIcon;
  final VoidCallback onTap;
  final VoidCallback onOpen;

  const _MyAppCard({
    required this.app,
    required this.stat,
    required this.statIcon,
    required this.onTap,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: icon + menu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.black900,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(app.icon, color: Colors.white, size: 22),
                ),
                const Icon(Icons.more_horiz_rounded, color: AppColors.textHint, size: 20),
              ],
            ),
            const SizedBox(height: 12),
            // App name
            Text(
              app.name,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: AppColors.black900,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            // Description
            Expanded(
              child: Text(
                app.shortDescription,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 10),
            // Bottom: Günlük Özet
            Row(
              children: [
                Icon(Icons.analytics_outlined, size: 12, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    app.dailySummary ?? stat,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Hızlı işlem ve Detaylar Butonları
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: GestureDetector(
                    onTap: () {
                      if (app.quickActionRoute != null) {
                        context.push(app.quickActionRoute!);
                      } else {
                        onOpen();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.black900,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          app.quickActionText ?? 'İşlem',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 4,
                  child: GestureDetector(
                    onTap: onTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.bgCard,
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Detaylar',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Suggested App Tile ───────────────────────────────────────────────────────
class _SuggestedAppTile extends StatelessWidget {
  final IconData icon;
  final String name;
  final String description;
  final MiniAppStatus status;
  final VoidCallback onTap;
  final VoidCallback onAction;

  const _SuggestedAppTile({
    required this.icon,
    required this.name,
    required this.description,
    required this.status,
    required this.onTap,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.borderLight)),
        ),
        child: Row(
          children: [
            // Gray icon background
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.gray100,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: AppColors.black900, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black900,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            _buildActionButton(),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textHint, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    switch (status) {
      case MiniAppStatus.premium:
        return GestureDetector(
          onTap: onAction,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              gradient: AppColors.premiumGradient,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.workspace_premium_rounded, size: 12, color: Colors.white),
                SizedBox(width: 4),
                Text('Pro', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
              ],
            ),
          ),
        );
      case MiniAppStatus.comingSoon:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.gray100,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.access_time_rounded, size: 12, color: AppColors.textHint),
              SizedBox(width: 4),
              Text('Yakında', style: TextStyle(fontSize: 11, color: AppColors.textHint, fontWeight: FontWeight.w600)),
            ],
          ),
        );
      default:
        return GestureDetector(
          onTap: onAction,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              'Ekle',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.black900),
            ),
          ),
        );
    }
  }
}
