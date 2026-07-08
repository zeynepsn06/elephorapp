import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import 'models/alacak_borc_model.dart';

final _mockIslemler = [
  AlacakBorcIslem(id: 't1', cariId: 'c1', cariName: 'Ahmet Yılmaz', type: TransactionType.alacak, amount: 5000, vadeTarihi: DateTime.now().subtract(const Duration(days: 2)), status: TransactionStatus.bekliyor),
  AlacakBorcIslem(id: 't2', cariId: 'c2', cariName: 'Mavi Reklam', type: TransactionType.borc, amount: 3000, vadeTarihi: DateTime.now().add(const Duration(days: 5)), status: TransactionStatus.bekliyor),
  AlacakBorcIslem(id: 't3', cariId: 'c3', cariName: 'ABC Teknoloji', type: TransactionType.alacak, amount: 8500, vadeTarihi: DateTime.now().subtract(const Duration(days: 10)), status: TransactionStatus.tahsilEdildi),
  AlacakBorcIslem(id: 't4', cariId: 'c1', cariName: 'Ahmet Yılmaz', type: TransactionType.borc, amount: 1200, vadeTarihi: DateTime.now().subtract(const Duration(days: 1)), status: TransactionStatus.odendi),
];

class AlacakBorcReportsScreen extends StatefulWidget {
  const AlacakBorcReportsScreen({super.key});

  @override
  State<AlacakBorcReportsScreen> createState() => _AlacakBorcReportsScreenState();
}

class _AlacakBorcReportsScreenState extends State<AlacakBorcReportsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: Text(
          'Alacak & Borç Raporları',
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
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PDF olarak indiriliyor...')));
            },
            icon: const Icon(Icons.picture_as_pdf_rounded, color: AppColors.textPrimary),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.categoryFinans,
          indicatorWeight: 3,
          labelColor: AppColors.categoryFinans,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          tabs: const [
            Tab(text: 'Tüm Hareketler'),
            Tab(text: 'Geciken Ödemeler'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildList(_mockIslemler),
          _buildList(_mockIslemler.where((i) => i.isGecikmis).toList()),
        ],
      ),
    );
  }

  Widget _buildList(List<AlacakBorcIslem> items) {
    if (items.isEmpty) {
      return const Center(child: Text('Kayıt bulunamadı.', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (ctx, i) {
        final islem = items[i];
        final isAlacak = islem.type == TransactionType.alacak;
        final isGecikmis = islem.isGecikmis;
        final isCompleted = islem.status == TransactionStatus.odendi || islem.status == TransactionStatus.tahsilEdildi;

        Color borderColor = AppColors.borderLight;
        if (isGecikmis) borderColor = AppColors.danger.withOpacity(0.5);
        if (isCompleted) borderColor = AppColors.success.withOpacity(0.5);

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor, width: (isGecikmis || isCompleted) ? 1.5 : 1),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isAlacak ? AppColors.success.withOpacity(0.1) : AppColors.danger.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(isAlacak ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded, 
                  color: isAlacak ? AppColors.success : AppColors.danger, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(islem.cariName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text(
                      'Vade: ${islem.vadeTarihi.day}.${islem.vadeTarihi.month}.${islem.vadeTarihi.year}', 
                      style: TextStyle(color: AppColors.textHint, fontSize: 12, fontWeight: FontWeight.w700)
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('₺${islem.amount.toStringAsFixed(0)}', style: TextStyle(
                    color: isAlacak ? AppColors.success : AppColors.danger, 
                    fontWeight: FontWeight.w800, 
                    fontSize: 16,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  )),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isCompleted ? AppColors.success.withOpacity(0.1) : (isGecikmis ? AppColors.danger.withOpacity(0.1) : AppColors.bgPage),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      isCompleted ? 'Tamamlandı' : (isGecikmis ? 'Gecikti' : 'Bekliyor'),
                      style: TextStyle(
                        color: isCompleted ? AppColors.success : (isGecikmis ? AppColors.danger : AppColors.textHint),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
