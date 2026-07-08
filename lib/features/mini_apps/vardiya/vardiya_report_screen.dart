import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';

class VardiyaReportScreen extends StatefulWidget {
  const VardiyaReportScreen({super.key});

  @override
  State<VardiyaReportScreen> createState() => _VardiyaReportScreenState();
}

class _VardiyaReportScreenState extends State<VardiyaReportScreen> {
  String _period = 'Haftalık';
  final _periods = ['Günlük', 'Haftalık', 'Aylık'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Vardiya Raporları',
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
          IconButton(
            icon: const Icon(Icons.ios_share_rounded, color: AppColors.primaryGreen, size: 22),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Rapor dışa aktarılıyor...'),
                  backgroundColor: AppColors.primaryGreen,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Period selector
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.gray100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: _periods
                  .map((p) => Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _period = p),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _period == p
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: _period == p
                                  ? [
                                      BoxShadow(
                                        color: AppColors.black900.withOpacity(0.08),
                                        blurRadius: 10,
                                        offset: const Offset(0, 2),
                                      )
                                    ]
                                  : [],
                            ),
                            child: Text(
                              p,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: _period == p ? FontWeight.w800 : FontWeight.w600,
                                fontSize: 14,
                                color: _period == p
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),

          const SizedBox(height: 32),

          // Stats summary
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width - 64) / 2,
                child: const _StatCard(
                    label: 'Toplam Saat',
                    value: '168',
                    unit: 'saat',
                    color: AppColors.categoryPersonel),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 64) / 2,
                child: const _StatCard(
                    label: 'Fazla Mesai',
                    value: '12',
                    unit: 'saat',
                    color: AppColors.success),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 64) / 2,
                child: const _StatCard(
                    label: 'Geç Kalma',
                    value: '4',
                    unit: 'kez',
                    color: AppColors.warning),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 64) / 2,
                child: const _StatCard(
                    label: 'Devamsızlık',
                    value: '1',
                    unit: 'gün',
                    color: AppColors.danger),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Chart
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.borderLight.withOpacity(0.5)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black900.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Günlük Çalışma Saatleri',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    )),
                const SizedBox(height: 32),
                SizedBox(
                  height: 180,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 12,
                      barGroups: [
                        _bar(0, 8.5, AppColors.categoryPersonel),
                        _bar(1, 9.0, AppColors.categoryPersonel),
                        _bar(2, 7.5, AppColors.warning),
                        _bar(3, 9.2, AppColors.categoryPersonel),
                        _bar(4, 8.8, AppColors.categoryPersonel),
                        _bar(5, 6.0, AppColors.accentBlue),
                        _bar(6, 0, AppColors.bgSurface),
                      ],
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (v, _) => Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'][v.toInt()],
                                style: const TextStyle(
                                    fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      gridData: const FlGridData(show: false),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Top workers
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.borderLight.withOpacity(0.5)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black900.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Personel Performansı',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    )),
                const SizedBox(height: 20),
                ...[
                  ('Zeynep Kaya', 45.0, 0),
                  ('Ahmet Yılmaz', 42.5, 2),
                  ('Murat Demir', 40.0, 0),
                  ('Selin Arslan', 38.5, 1),
                ].map(
                  (e) => _PersonelRow(
                      name: e.$1, hours: e.$2, lateCount: e.$3),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  BarChartGroupData _bar(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 32,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 12,
            color: AppColors.gray50,
          )
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final Color color;

  const _StatCard(
      {required this.label,
      required this.value,
      required this.unit,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black900.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                    color: color),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(unit,
                    style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            label, 
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonelRow extends StatelessWidget {
  final String name;
  final double hours;
  final int lateCount;

  const _PersonelRow(
      {required this.name, required this.hours, required this.lateCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.categoryPersonel.withOpacity(0.2),
                  AppColors.categoryPersonel.withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                name.split(' ').map((e) => e[0]).take(2).join(),
                style: const TextStyle(
                  color: AppColors.categoryPersonel,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name, 
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  )
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('$hours saat',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        )),
                    if (lateCount > 0) ...[
                      const SizedBox(width: 8),
                      Text(
                        '$lateCount geç kalma',
                        style: const TextStyle(
                            color: AppColors.warning,
                            fontSize: 11,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: hours >= 40 ? AppColors.success.withOpacity(0.1) : AppColors.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${(hours / 45 * 100).round()}%',
              style: TextStyle(
                color: hours >= 40 ? AppColors.success : AppColors.warning,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

