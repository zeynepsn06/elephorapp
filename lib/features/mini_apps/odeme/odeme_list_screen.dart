import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/status_badge.dart';

class OdemeListScreen extends StatefulWidget {
  const OdemeListScreen({super.key});

  @override
  State<OdemeListScreen> createState() => _OdemeListScreenState();
}

class _OdemeListScreenState extends State<OdemeListScreen> {
  String _filter = 'Tümü';
  final _filters = ['Tümü', 'Bekliyor', 'Gecikti', 'Ödendi'];

  final _payments = [
    _OdemeItem(name: 'ABC Müşterisi', amount: 12500, dueDate: 'Bugün', status: 'Bekliyor'),
    _OdemeItem(name: 'XYZ Ltd.', amount: 8200, dueDate: '3 gün önce', status: 'Gecikti'),
    _OdemeItem(name: 'Mehmet Yıldız', amount: 3500, dueDate: 'Dün', status: 'Gecikti'),
    _OdemeItem(name: 'Demir İnşaat', amount: 22000, dueDate: '15 Tem', status: 'Bekliyor'),
    _OdemeItem(name: 'Selin Kafe', amount: 1800, dueDate: '10 Tem', status: 'Ödendi'),
    _OdemeItem(name: 'Teknoloji A.Ş.', amount: 9400, dueDate: '5 Tem', status: 'Ödendi'),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _filter == 'Tümü'
        ? _payments
        : _payments.where((p) => p.status == _filter).toList();

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Tüm Ödemeler',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
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
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.bgPage,
              border: Border(bottom: BorderSide(color: AppColors.borderLight.withOpacity(0.5))),
            ),
            child: SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                itemCount: _filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (ctx, i) {
                  final f = _filters[i];
                  final selected = f == _filter;
                  return GestureDetector(
                    onTap: () => setState(() => _filter = f),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.categoryFinans : AppColors.bgCard,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selected ? AppColors.categoryFinans : AppColors.borderLight.withOpacity(0.5),
                        ),
                        boxShadow: selected ? [
                          BoxShadow(
                            color: AppColors.categoryFinans.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ] : [],
                      ),
                      child: Center(
                        child: Text(
                          f,
                          style: TextStyle(
                            color: selected ? Colors.white : AppColors.textSecondary,
                            fontSize: 13,
                            fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text(
                      'Kayıt bulunamadı',
                      style: TextStyle(color: AppColors.textHint, fontWeight: FontWeight.w500),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(24),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (ctx, i) => _OdemeCard(item: filtered[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _OdemeItem {
  final String name;
  final double amount;
  final String dueDate;
  final String status;

  const _OdemeItem({
    required this.name,
    required this.amount,
    required this.dueDate,
    required this.status,
  });
}

class _OdemeCard extends StatelessWidget {
  final _OdemeItem item;
  const _OdemeCard({required this.item});

  BadgeType get _type {
    switch (item.status) {
      case 'Ödendi': return BadgeType.success;
      case 'Gecikti': return BadgeType.danger;
      default: return BadgeType.warning;
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
          color: item.status == 'Gecikti'
              ? AppColors.danger.withOpacity(0.3)
              : AppColors.borderLight.withOpacity(0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: item.status == 'Gecikti' 
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
                  item.name, 
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
                      color: item.status == 'Gecikti' ? AppColors.danger : AppColors.textHint
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item.dueDate,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: item.status == 'Gecikti' ? AppColors.danger : AppColors.textSecondary,
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
                '₺${item.amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              StatusBadge(label: item.status, type: _type, small: true),
            ],
          ),
        ],
      ),
    );
  }
}

