import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedFilter = 'Tümü';

  // ── Hardcoded rich mock data matching the design ──────────────────────────
  final List<_NotifData> _important = [
    _NotifData(
      id: 'i1',
      icon: Icons.account_balance_wallet_rounded,
      iconBg: AppColors.danger.withOpacity(0.1),
      iconColor: AppColors.danger,
      title: 'Geciken Ödeme',
      body: '2 müşterinizin ödemesi gecikmeli.',
      time: '10:24',
      dot: AppColors.danger,
      badge: 'Önemli',
      badgeBg: AppColors.danger.withOpacity(0.1),
      badgeColor: AppColors.danger,
    ),
    _NotifData(
      id: 'i2',
      icon: Icons.people_rounded,
      iconBg: AppColors.warning.withOpacity(0.1),
      iconColor: AppColors.warning,
      title: 'Vardiya Hatırlatması',
      body: 'Bugün 4 vardiya planlandı.',
      time: '09:15',
      dot: AppColors.warning,
      badge: 'Uyarı',
      badgeBg: AppColors.warning.withOpacity(0.1),
      badgeColor: AppColors.warning,
    ),
    _NotifData(
      id: 'i3',
      icon: Icons.calendar_month_rounded,
      iconBg: AppColors.success.withOpacity(0.1),
      iconColor: AppColors.success,
      title: 'Yeni Rezervasyon',
      body: 'Bugün 7 yeni rezervasyon alındı.',
      time: '08:40',
      dot: AppColors.success,
      badge: 'Bilgi',
      badgeBg: AppColors.success.withOpacity(0.1),
      badgeColor: AppColors.success,
    ),
  ];

  final List<_NotifData> _today = [
    _NotifData(
      id: 't1',
      icon: Icons.person_add_outlined,
      iconBg: Color(0xFFF3F4F6),
      iconColor: Color(0xFF6B7280),
      title: 'Yeni Ekip Üyesi',
      body: 'Ahmet Yılmaz ekibinize katıldı.',
      time: '11:32',
      dot: AppColors.black900,
      badge: null,
      badgeBg: Colors.transparent,
      badgeColor: Colors.transparent,
    ),
    _NotifData(
      id: 't2',
      icon: Icons.bar_chart_rounded,
      iconBg: Color(0xFFF3F4F6),
      iconColor: Color(0xFF6B7280),
      title: 'Rapor Hazır',
      body: 'Günlük satış raporunuz hazır.',
      time: '11:05',
      dot: AppColors.black900,
      badge: null,
      badgeBg: Colors.transparent,
      badgeColor: Colors.transparent,
    ),
    _NotifData(
      id: 't3',
      icon: Icons.receipt_long_rounded,
      iconBg: Color(0xFFF3F4F6),
      iconColor: Color(0xFF6B7280),
      title: 'Fatura Oluşturuldu',
      body: 'INV-2024-125 numaralı fatura oluşturuldu.',
      time: '10:18',
      dot: AppColors.black900,
      badge: null,
      badgeBg: Colors.transparent,
      badgeColor: Colors.transparent,
    ),
    _NotifData(
      id: 't4',
      icon: Icons.notifications_outlined,
      iconBg: Color(0xFFF3F4F6),
      iconColor: Color(0xFF6B7280),
      title: 'Sistem Duyurusu',
      body: 'Elephor+ sistem güncellemesi tamamlandı.',
      time: '09:45',
      dot: AppColors.black900,
      badge: null,
      badgeBg: Colors.transparent,
      badgeColor: Colors.transparent,
    ),
  ];

  final List<_NotifData> _yesterday = [
    _NotifData(
      id: 'y1',
      icon: Icons.account_balance_wallet_rounded,
      iconBg: Color(0xFFEEFFF6),
      iconColor: Color(0xFF10B981),
      title: 'Ödeme Alındı',
      body: 'Müşteri ödemesi alındı. 5.250 TL',
      time: 'Dün 17:45',
      dot: AppColors.black900,
      badge: null,
      badgeBg: Colors.transparent,
      badgeColor: Colors.transparent,
    ),
    _NotifData(
      id: 'y2',
      icon: Icons.people_rounded,
      iconBg: Color(0xFFFFF7E6),
      iconColor: Color(0xFFF59E0B),
      title: 'Vardiya Tamamlandı',
      body: 'Akşam vardiyası tamamlandı.',
      time: 'Dün 22:10',
      dot: AppColors.black900,
      badge: null,
      badgeBg: Colors.transparent,
      badgeColor: Colors.transparent,
    ),
    _NotifData(
      id: 'y3',
      icon: Icons.inventory_2_rounded,
      iconBg: Color(0xFFFFEEEE),
      iconColor: Color(0xFFEF4444),
      title: 'Stok Uyarısı',
      body: '3 ürün stok sınırının altına düştü.',
      time: 'Dün 15:30',
      dot: AppColors.black900,
      badge: null,
      badgeBg: Colors.transparent,
      badgeColor: Colors.transparent,
    ),
  ];

  static const _filters = ['Tümü', 'Okunmamış', 'Önemli', 'Arşiv'];
  static const _filterCounts = {'Tümü': 24, 'Okunmamış': 8, 'Önemli': 5};
  static const _filterIcons = {
    'Tümü': Icons.star_outline_rounded,
    'Okunmamış': Icons.mark_email_unread_outlined,
    'Önemli': Icons.star_outline_rounded,
    'Arşiv': Icons.archive_outlined,
  };

  @override
  Widget build(BuildContext context) {
    List<_NotifData> currentImportant = [];
    List<_NotifData> currentToday = [];
    List<_NotifData> currentYesterday = [];

    if (_selectedFilter == 'Tümü') {
      currentImportant = _important;
      currentToday = _today;
      currentYesterday = _yesterday;
    } else if (_selectedFilter == 'Okunmamış') {
      currentImportant = _important.take(2).toList();
      currentToday = _today.take(2).toList();
      currentYesterday = [];
    } else if (_selectedFilter == 'Önemli') {
      currentImportant = _important;
      currentToday = [];
      currentYesterday = [];
    } else if (_selectedFilter == 'Arşiv') {
      currentImportant = [];
      currentToday = [];
      currentYesterday = _yesterday;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Header ─────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bildirimler',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: AppColors.black900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Tüm bildirimlerini ve güncellemelerin burada.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Filter tabs
                    SizedBox(
                      height: 36,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _filters.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, i) {
                          final f = _filters[i];
                          final isSelected = f == _selectedFilter;
                          final count = _filterCounts[f];
                          final icon = _filterIcons[f];
                          return GestureDetector(
                            onTap: () => setState(() => _selectedFilter = f),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.black900 : Colors.transparent,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: isSelected ? AppColors.black900 : AppColors.border,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    icon,
                                    size: 13,
                                    color: isSelected ? Colors.white : AppColors.textSecondary,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    count != null ? '$f  $count' : f,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected ? Colors.white : AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // ── Önemli Bildirimler ──────────────────────────────────────
            if (currentImportant.isNotEmpty)
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.star_outline_rounded, size: 15, color: AppColors.black900),
                              SizedBox(width: 6),
                              Text(
                                'Önemli Bildirimler',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.black900,
                                ),
                              ),
                            ],
                          ),
                          Row(
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Important notification list
                    ...(currentImportant.map((n) => _ImportantTile(notif: n))),
                  ],
                ),
              ),

            // ── Bugün ───────────────────────────────────────────────────
            if (currentToday.isNotEmpty)
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: Text(
                        'Bugün',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    ...(currentToday.map((n) => _StandardTile(notif: n))),
                  ],
                ),
              ),

            // ── Dün ─────────────────────────────────────────────────────
            if (currentYesterday.isNotEmpty)
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: Text(
                        'Dün',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    ...(currentYesterday.map((n) => _StandardTile(notif: n))),
                  ],
                ),
              ),

            // ── Date footer ─────────────────────────────────────────────
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(
                    '20 Mayıs 2024',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textHint,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}

// ── Data model ────────────────────────────────────────────────────────────
class _NotifData {
  final String id;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String body;
  final String time;
  final Color dot;
  final String? badge;
  final Color badgeBg;
  final Color badgeColor;

  const _NotifData({
    required this.id,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.body,
    required this.time,
    required this.dot,
    required this.badge,
    required this.badgeBg,
    required this.badgeColor,
  });
}

// ── Important Tile ─────────────────────────────────────────────────────────
class _ImportantTile extends StatelessWidget {
  final _NotifData notif;
  const _ImportantTile({required this.notif});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Container(
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
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Colored icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: notif.iconBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(notif.icon, color: notif.iconColor, size: 22),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          notif.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black900,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          Text(
                            notif.time,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textHint,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: notif.dot,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notif.body,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  if (notif.badge != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: notif.badgeBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        notif.badge!,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: notif.badgeColor,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Standard Tile ──────────────────────────────────────────────────────────
class _StandardTile extends StatelessWidget {
  final _NotifData notif;
  const _StandardTile({required this.notif});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Container(
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
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: notif.iconBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(notif.icon, color: notif.iconColor, size: 22),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          notif.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black900,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          Text(
                            notif.time,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textHint,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: notif.dot,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notif.body,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
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

