import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';

class VardiyaPlanScreen extends StatefulWidget {
  final int initialTab;
  const VardiyaPlanScreen({super.key, this.initialTab = 0});

  @override
  State<VardiyaPlanScreen> createState() => _VardiyaPlanScreenState();
}

class _VardiyaPlanScreenState extends State<VardiyaPlanScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialTab);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Vardiya Planı',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primaryGreen,
          labelColor: AppColors.primaryGreen,
          unselectedLabelColor: AppColors.textHint,
          labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          tabs: const [
            Tab(text: 'Haftalık Görünüm'),
            Tab(text: 'Aylık Görünüm'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _WeeklyPlanTab(),
          _MonthlyPlanTab(),
        ],
      ),
    );
  }
}

class _WeeklyPlanTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '14 - 20 Temmuz 2026',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.black900),
            ),
            IconButton(
              icon: const Icon(Icons.calendar_month_rounded, color: AppColors.primaryGreen),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildDayPlan(context, 'Pazartesi', '14 Temmuz', [
          _ShiftAssignment(name: 'Ahmet Yılmaz', time: '09:00 - 18:00'),
          _ShiftAssignment(name: 'Zeynep Kaya', time: '09:00 - 18:00'),
        ]),
        _buildDayPlan(context, 'Salı', '15 Temmuz', [
          _ShiftAssignment(name: 'Ahmet Yılmaz', time: '09:00 - 18:00'),
          _ShiftAssignment(name: 'Murat Demir', time: '14:00 - 22:00'),
        ]),
        _buildDayPlan(context, 'Çarşamba', '16 Temmuz', [
          _ShiftAssignment(name: 'Zeynep Kaya', time: '09:00 - 18:00'),
          _ShiftAssignment(name: 'Selin Arslan', time: '14:00 - 22:00'),
        ]),
      ],
    );
  }

  Widget _buildDayPlan(BuildContext context, String day, String date, List<_ShiftAssignment> shifts) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: AppColors.black900.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(0.05),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              border: const Border(bottom: BorderSide(color: AppColors.borderLight)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  day,
                  style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primaryGreen),
                ),
                Text(
                  date,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: shifts.map((s) => _buildShiftItem(s)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftItem(_ShiftAssignment assignment) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.person_rounded, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              Text(assignment.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
          Text(assignment.time, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _MonthlyPlanTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_month_rounded, size: 64, color: AppColors.primaryGreen.withOpacity(0.3)),
          const SizedBox(height: 16),
          const Text(
            'Aylık Görünüm',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.black900),
          ),
          const SizedBox(height: 8),
          const Text(
            'Aylık vardiya takvimi burada listelenecektir.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _ShiftAssignment {
  final String name;
  final String time;
  _ShiftAssignment({required this.name, required this.time});
}
