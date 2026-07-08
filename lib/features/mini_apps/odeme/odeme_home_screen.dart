import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/status_badge.dart';

class _Payment {
  final String name;
  final double amount;
  final String dueDate;
  final String status; // 'Bekliyor' | 'Ödendi' | 'Gecikti'

  const _Payment({
    required this.name,
    required this.amount,
    required this.dueDate,
    required this.status,
  });
}

final _mockPayments = [
  _Payment(name: 'ABC Müşterisi', amount: 12500, dueDate: 'Bugün', status: 'Bekliyor'),
  _Payment(name: 'XYZ Ltd.', amount: 8200, dueDate: '3 gün önce', status: 'Gecikti'),
  _Payment(name: 'Mehmet Yıldız', amount: 3500, dueDate: 'Dün', status: 'Gecikti'),
  _Payment(name: 'Demir İnşaat', amount: 22000, dueDate: '15 Tem', status: 'Bekliyor'),
  _Payment(name: 'Selin Kafe', amount: 1800, dueDate: '10 Tem', status: 'Ödendi'),
  _Payment(name: 'Teknoloji A.Ş.', amount: 9400, dueDate: '5 Tem', status: 'Ödendi'),
];

class OdemeHomeScreen extends StatelessWidget {
  const OdemeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pending = _mockPayments.where((p) => p.status == 'Bekliyor').toList();
    final overdue = _mockPayments.where((p) => p.status == 'Gecikti').toList();
    final paid = _mockPayments.where((p) => p.status == 'Ödendi').toList();

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.bgPage,
            surfaceTintColor: Colors.transparent,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.textPrimary),
              onPressed: () => context.pop(),
            ),
            title: Text(
              'Ödeme Takibi',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: ElevatedButton.icon(
                  onPressed: () => context.push('/mini-apps/odeme/add'),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('Ekle', style: TextStyle(fontWeight: FontWeight.w700)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.categoryFinans,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary Banner
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF10B981), Color(0xFF059669)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF10B981).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Bu Ay Toplam Tahsilat',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9), 
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.trending_up_rounded, color: Colors.white, size: 16),
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          '₺57.400,00',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _PayStat(label: 'Bekleyen', value: '₺34.500', color: Colors.white),
                              Container(width: 1, height: 30, color: Colors.white.withOpacity(0.2)),
                              _PayStat(label: 'Geciken', value: '₺11.700', color: const Color(0xFFFFD700)),
                              Container(width: 1, height: 30, color: Colors.white.withOpacity(0.2)),
                              _PayStat(label: 'Ödenen', value: '₺11.200', color: Colors.white.withOpacity(0.9)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (overdue.isNotEmpty) ...[
                    const SizedBox(height: 32),
                    _SectionHeader(
                      title: 'Geciken Ödemeler',
                      count: overdue.length,
                      color: AppColors.danger,
                      onSeeAll: () => context.push('/mini-apps/odeme/list'),
                    ),
                    const SizedBox(height: 16),
                    ...overdue.map((p) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _PaymentCard(payment: p),
                        )),
                  ],

                  const SizedBox(height: 32),
                  _SectionHeader(
                    title: 'Yaklaşan Ödemeler',
                    count: pending.length,
                    color: AppColors.warning,
                    onSeeAll: () => context.push('/mini-apps/odeme/list'),
                  ),
                  const SizedBox(height: 16),
                  ...pending.map((p) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _PaymentCard(payment: p),
                      )),

                  const SizedBox(height: 32),
                  _SectionHeader(
                    title: 'Son İşlemler',
                    count: paid.length,
                    color: AppColors.success,
                    onSeeAll: () => context.push('/mini-apps/odeme/list'),
                  ),
                  const SizedBox(height: 16),
                  ...paid.take(2).map((p) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _PaymentCard(payment: p),
                      )),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PayStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _PayStat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(value, style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 16)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final VoidCallback onSeeAll;

  const _SectionHeader({
    required this.title,
    required this.count,
    required this.color,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title, 
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            )
          ),
        ),
        TextButton(
          onPressed: onSeeAll, 
          style: TextButton.styleFrom(
            foregroundColor: AppColors.categoryFinans,
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
          child: const Text('Tümünü Gör'),
        ),
      ],
    );
  }
}

class _PaymentCard extends StatelessWidget {
  final _Payment payment;
  const _PaymentCard({required this.payment});

  BadgeType get _badgeType {
    switch (payment.status) {
      case 'Ödendi':
        return BadgeType.success;
      case 'Gecikti':
        return BadgeType.danger;
      default:
        return BadgeType.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: payment.status == 'Gecikti'
              ? AppColors.danger.withOpacity(0.3)
              : AppColors.borderLight.withOpacity(0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: payment.status == 'Gecikti' 
                ? AppColors.danger.withOpacity(0.05) 
                : AppColors.black900.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.categoryFinans.withOpacity(0.2),
                  AppColors.categoryFinans.withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.account_balance_wallet_rounded,
                color: AppColors.categoryFinans, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payment.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  )
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 14, 
                      color: payment.status == 'Gecikti' ? AppColors.danger : AppColors.textHint
                    ),
                    const SizedBox(width: 6),
                    Text(
                      payment.dueDate,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: payment.status == 'Gecikti' ? AppColors.danger : AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      )
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₺${payment.amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              StatusBadge(
                  label: payment.status, type: _badgeType, small: true),
            ],
          ),
        ],
      ),
    );
  }
}

