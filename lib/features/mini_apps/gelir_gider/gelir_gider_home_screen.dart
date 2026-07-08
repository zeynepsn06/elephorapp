import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_colors.dart';
import 'models/gelir_gider_model.dart';

final _mockTransactions = [
  GelirGiderTransaction(
    id: '1',
    type: TransactionType.income,
    amount: 12500,
    category: 'Satışlar',
    date: DateTime.now(),
    description: 'Günlük Hizmet Geliri',
  ),
  GelirGiderTransaction(
    id: '2',
    type: TransactionType.expense,
    amount: 1500,
    category: 'Malzeme',
    date: DateTime.now().subtract(const Duration(hours: 2)),
    description: 'Şampuan ve Kozmetik Alımı',
  ),
  GelirGiderTransaction(
    id: '3',
    type: TransactionType.expense,
    amount: 350,
    category: 'Fatura',
    date: DateTime.now().subtract(const Duration(days: 1)),
    description: 'Elektrik Faturası',
  ),
  GelirGiderTransaction(
    id: '4',
    type: TransactionType.income,
    amount: 8200,
    category: 'Satışlar',
    date: DateTime.now().subtract(const Duration(days: 1)),
  ),
  GelirGiderTransaction(
    id: '5',
    type: TransactionType.expense,
    amount: 1200,
    category: 'Kira',
    date: DateTime.now().subtract(const Duration(days: 2)),
  ),
];

class GelirGiderHomeScreen extends StatelessWidget {
  const GelirGiderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Hesaplamalar
    double totalIncome = _mockTransactions
        .where((t) => t.type == TransactionType.income)
        .fold(0, (sum, t) => sum + t.amount);
    double totalExpense = _mockTransactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0, (sum, t) => sum + t.amount);
    double balance = totalIncome - totalExpense;

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
              'Gelir-Gider Takibi',
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
                  onPressed: () => context.push('/mini-apps/gelir-gider/add'),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('İşlem', style: TextStyle(fontWeight: FontWeight.w700)),
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
                  // Bakiye Kartı
                  _buildBalanceCard(context, balance, totalIncome, totalExpense),
                  const SizedBox(height: 32),
                  
                  // İşlemler Grid
                  Text(
                    'İşlemler',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _ActionButton(
                        icon: Icons.add_circle_outline_rounded,
                        label: 'Gelir Ekle',
                        color: AppColors.success,
                        onTap: () => context.push('/mini-apps/gelir-gider/add?type=income'),
                      ),
                      _ActionButton(
                        icon: Icons.remove_circle_outline_rounded,
                        label: 'Gider Ekle',
                        color: AppColors.danger,
                        onTap: () => context.push('/mini-apps/gelir-gider/add?type=expense'),
                      ),
                      _ActionButton(
                        icon: Icons.category_outlined,
                        label: 'Kategori Ekle',
                        color: AppColors.warning,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Kategori Ekle modalı açılıyor...')));
                        },
                      ),
                      _ActionButton(
                        icon: Icons.bar_chart_rounded,
                        label: 'Rapor Al',
                        color: AppColors.categoryFinans,
                        onTap: () => context.push('/mini-apps/gelir-gider/reports'),
                      ),
                      _ActionButton(
                        icon: Icons.file_download_outlined,
                        label: 'Excel Aktar',
                        color: Colors.green,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Veriler Excel\'e aktarılıyor...')));
                        },
                      ),
                      _ActionButton(
                        icon: Icons.picture_as_pdf_outlined,
                        label: 'PDF Aktar',
                        color: Colors.redAccent,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Veriler PDF\'e aktarılıyor...')));
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),
                  
                  // Nakit Akışı Grafiği (BarChart)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Haftalık Nakit Akışı',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.3,
                            ),
                      ),
                      TextButton(
                        onPressed: () => context.push('/mini-apps/gelir-gider/reports'),
                        child: const Text('Detaylar', style: TextStyle(color: AppColors.categoryFinans, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildChartCard(),

                  const SizedBox(height: 32),

                  // Son İşlemler
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Son İşlemler',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.3,
                            ),
                      ),
                      TextButton(
                        onPressed: () => context.push('/mini-apps/gelir-gider/reports'),
                        child: const Text('Tümü', style: TextStyle(color: AppColors.categoryFinans, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ..._mockTransactions.take(5).map((t) => _TransactionCard(transaction: t)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context, double balance, double inc, double exp) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.categoryFinans,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.categoryFinans.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            'Güncel Bakiye',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '₺${balance.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_downward_rounded, color: Colors.white, size: 16),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Gelir', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12, fontWeight: FontWeight.w500)),
                          Text('₺${inc.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_upward_rounded, color: Colors.white, size: 16),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Gider', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12, fontWeight: FontWeight.w500)),
                          Text('₺${exp.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard() {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: AppColors.black900.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 15000,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600, fontSize: 11);
                  String text = '';
                  switch (value.toInt()) {
                    case 0: text = 'Pzt'; break;
                    case 1: text = 'Sal'; break;
                    case 2: text = 'Çar'; break;
                    case 3: text = 'Per'; break;
                    case 4: text = 'Cum'; break;
                    case 5: text = 'Cmt'; break;
                    case 6: text = 'Paz'; break;
                  }
                  return Padding(padding: const EdgeInsets.only(top: 8), child: Text(text, style: style));
                },
              ),
            ),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            _buildBar(0, 8000, 2000),
            _buildBar(1, 12000, 1500),
            _buildBar(2, 6000, 3500),
            _buildBar(3, 10000, 1200),
            _buildBar(4, 15000, 5000),
            _buildBar(5, 5000, 800),
            _buildBar(6, 4000, 1000),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _buildBar(int x, double inc, double exp) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: inc,
          color: AppColors.success,
          width: 8,
          borderRadius: BorderRadius.circular(4),
        ),
        BarChartRodData(
          toY: exp,
          color: AppColors.danger,
          width: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (MediaQuery.of(context).size.width - 60) / 2,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [
            BoxShadow(
              color: AppColors.black900.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final GelirGiderTransaction transaction;

  const _TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isInc = transaction.type == TransactionType.income;
    final color = isInc ? AppColors.success : AppColors.danger;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isInc ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.category,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                if (transaction.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    transaction.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isInc ? '+' : '-'}₺${transaction.amount.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                '${transaction.date.day}/${transaction.date.month}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.textHint,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
