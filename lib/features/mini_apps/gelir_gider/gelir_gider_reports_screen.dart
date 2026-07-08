import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_colors.dart';
import 'models/gelir_gider_model.dart';

class GelirGiderReportsScreen extends StatefulWidget {
  const GelirGiderReportsScreen({super.key});

  @override
  State<GelirGiderReportsScreen> createState() => _GelirGiderReportsScreenState();
}

class _GelirGiderReportsScreenState extends State<GelirGiderReportsScreen> {
  String _filter = 'Aylık';
  final _filters = ['Günlük', 'Haftalık', 'Aylık'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Finans Raporları',
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
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(
                  '$_filter Nakit Akışı',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                      ),
                ),
                const SizedBox(height: 16),
                _buildLineChart(),
                const SizedBox(height: 32),
                
                Text(
                  'Özet',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                      ),
                ),
                const SizedBox(height: 16),
                _buildSummaryRow('Toplam Gelir', '42,500 ₺', AppColors.success),
                const SizedBox(height: 12),
                _buildSummaryRow('Toplam Gider', '18,200 ₺', AppColors.danger),
                const SizedBox(height: 12),
                _buildSummaryRow('Net Kazanç', '24,300 ₺', AppColors.primaryGreen),
                
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Rapor PDF olarak indiriliyor...')));
                    },
                    icon: const Icon(Icons.picture_as_pdf_outlined),
                    label: const Text('Bu Raporu İndir'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.categoryFinans,
                      side: const BorderSide(color: AppColors.categoryFinans),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600, fontSize: 15)),
          Text(value, style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildLineChart() {
    return Container(
      height: 250,
      padding: const EdgeInsets.only(right: 20, left: 10, top: 20, bottom: 10),
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
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 10000,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: AppColors.borderLight.withOpacity(0.5),
                strokeWidth: 1,
                dashArray: [5, 5],
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600, fontSize: 11);
                  String text = '';
                  switch (value.toInt()) {
                    case 1: text = '1.Hafta'; break;
                    case 2: text = '2.Hafta'; break;
                    case 3: text = '3.Hafta'; break;
                    case 4: text = '4.Hafta'; break;
                  }
                  return Padding(padding: const EdgeInsets.only(top: 10), child: Text(text, style: style));
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 10000,
                getTitlesWidget: (value, meta) {
                  return Text('${(value / 1000).toInt()}k', style: const TextStyle(color: AppColors.textHint, fontSize: 10, fontWeight: FontWeight.w600));
                },
                reservedSize: 30,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 1,
          maxX: 4,
          minY: 0,
          maxY: 40000,
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(1, 12000),
                FlSpot(2, 28000),
                FlSpot(3, 18000),
                FlSpot(4, 32000),
              ],
              isCurved: true,
              color: AppColors.success,
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: AppColors.success.withOpacity(0.1),
              ),
            ),
            LineChartBarData(
              spots: const [
                FlSpot(1, 8000),
                FlSpot(2, 12000),
                FlSpot(3, 9000),
                FlSpot(4, 15000),
              ],
              isCurved: true,
              color: AppColors.danger,
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: AppColors.danger.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
