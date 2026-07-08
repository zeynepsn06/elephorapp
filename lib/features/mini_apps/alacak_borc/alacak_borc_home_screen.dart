import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import 'models/alacak_borc_model.dart';

// Mock Data
final _mockCariler = [
  CariHesap(id: 'c1', name: 'Ahmet Yılmaz', bakiye: 5000, createdAt: DateTime.now().subtract(const Duration(days: 10))),
  CariHesap(id: 'c2', name: 'Mavi Reklam', bakiye: -3000, createdAt: DateTime.now().subtract(const Duration(days: 20))),
];

final _initialIslemler = [
  AlacakBorcIslem(id: 't1', cariId: 'c1', cariName: 'Ahmet Yılmaz', type: TransactionType.alacak, amount: 5000, vadeTarihi: DateTime.now().subtract(const Duration(days: 2)), status: TransactionStatus.bekliyor),
  AlacakBorcIslem(id: 't2', cariId: 'c2', cariName: 'Mavi Reklam', type: TransactionType.borc, amount: 3000, vadeTarihi: DateTime.now().add(const Duration(days: 5)), status: TransactionStatus.bekliyor),
  AlacakBorcIslem(id: 't3', cariId: 'c1', cariName: 'Ahmet Yılmaz', type: TransactionType.alacak, amount: 2000, vadeTarihi: DateTime.now().add(const Duration(days: 1)), status: TransactionStatus.bekliyor),
];

class AlacakBorcHomeScreen extends StatefulWidget {
  const AlacakBorcHomeScreen({super.key});

  @override
  State<AlacakBorcHomeScreen> createState() => _AlacakBorcHomeScreenState();
}

class _AlacakBorcHomeScreenState extends State<AlacakBorcHomeScreen> {
  List<AlacakBorcIslem> _islemler = [];

  @override
  void initState() {
    super.initState();
    _islemler = List.from(_initialIslemler);
  }

  void _markAsCompleted(String id, TransactionType type) {
    setState(() {
      final idx = _islemler.indexWhere((i) => i.id == id);
      if (idx != -1) {
        final old = _islemler[idx];
        _islemler[idx] = AlacakBorcIslem(
          id: old.id,
          cariId: old.cariId,
          cariName: old.cariName,
          type: old.type,
          amount: old.amount,
          vadeTarihi: old.vadeTarihi,
          note: old.note,
          status: type == TransactionType.alacak ? TransactionStatus.tahsilEdildi : TransactionStatus.odendi,
        );
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(type == TransactionType.alacak ? 'Tahsil edildi olarak işaretlendi.' : 'Ödendi olarak işaretlendi.'),
        backgroundColor: AppColors.success,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalAlacak = 0;
    double totalBorc = 0;
    int gecikenSayisi = 0;

    for (var i in _islemler) {
      if (i.status == TransactionStatus.bekliyor) {
        if (i.type == TransactionType.alacak) totalAlacak += i.amount;
        if (i.type == TransactionType.borc) totalBorc += i.amount;
        if (i.isGecikmis) gecikenSayisi++;
      }
    }

    final activeList = _islemler.where((i) => i.status == TransactionStatus.bekliyor).toList()
      ..sort((a, b) => a.vadeTarihi.compareTo(b.vadeTarihi));

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Alacak & Borç Takibi',
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
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Özet Kartları
          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  title: 'Toplam Alacak',
                  amount: totalAlacak,
                  color: AppColors.success,
                  icon: Icons.arrow_downward_rounded,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _SummaryCard(
                  title: 'Toplam Borç',
                  amount: totalBorc,
                  color: AppColors.danger,
                  icon: Icons.arrow_upward_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Hızlı Aksiyonlar
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _ActionChip(icon: Icons.add_rounded, label: 'Alacak Ekle', color: AppColors.success, onTap: () => context.push('/mini-apps/alacak-borc/add-transaction?type=alacak')),
                const SizedBox(width: 12),
                _ActionChip(icon: Icons.remove_rounded, label: 'Borç Ekle', color: AppColors.danger, onTap: () => context.push('/mini-apps/alacak-borc/add-transaction?type=borc')),
                const SizedBox(width: 12),
                _ActionChip(icon: Icons.person_add_rounded, label: 'Cari Ekle', color: AppColors.categoryFinans, onTap: () => context.push('/mini-apps/alacak-borc/add-cari')),
                const SizedBox(width: 12),
                _ActionChip(icon: Icons.pie_chart_rounded, label: 'Rapor Al', color: AppColors.textSecondary, onTap: () => context.push('/mini-apps/alacak-borc/reports')),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Gecikenler Uyarısı
          if (gecikenSayisi > 0) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.danger.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.danger.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_rounded, color: AppColors.danger),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Geciken Ödemeler', style: TextStyle(color: AppColors.danger, fontWeight: FontWeight.w800, fontSize: 15)),
                        const SizedBox(height: 4),
                        Text('Vadesi geçmiş $gecikenSayisi adet işlem bulunuyor.', style: TextStyle(color: AppColors.danger.withOpacity(0.8), fontWeight: FontWeight.w600, fontSize: 13)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Hatırlatma bildirimleri gönderildi.')));
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.danger,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Hatırlat', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],

          Text(
            'Bekleyen İşlemler',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
          ),
          const SizedBox(height: 16),

          if (activeList.isEmpty)
            const Center(child: Padding(
              padding: EdgeInsets.all(32),
              child: Text('Bekleyen işlem bulunmuyor.', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
            ))
          else
            ...activeList.map((islem) {
              final isAlacak = islem.type == TransactionType.alacak;
              final color = isAlacak ? AppColors.success : AppColors.danger;
              final isGecikmis = islem.isGecikmis;

              return Dismissible(
                key: Key(islem.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.only(right: 24),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(isAlacak ? 'Tahsil Et' : 'Öde', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                      const SizedBox(width: 8),
                      const Icon(Icons.check_circle_rounded, color: Colors.white),
                    ],
                  ),
                ),
                onDismissed: (_) => _markAsCompleted(islem.id, islem.type),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isGecikmis ? AppColors.danger.withOpacity(0.5) : AppColors.borderLight, width: isGecikmis ? 1.5 : 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(isAlacak ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded, color: color, size: 20),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(islem.cariName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                            const SizedBox(height: 4),
                            Text(
                              isGecikmis ? 'Gecikti: ${islem.vadeTarihi.day}.${islem.vadeTarihi.month}.${islem.vadeTarihi.year}' : 'Vade: ${islem.vadeTarihi.day}.${islem.vadeTarihi.month}.${islem.vadeTarihi.year}', 
                              style: TextStyle(color: isGecikmis ? AppColors.danger : AppColors.textHint, fontSize: 12, fontWeight: FontWeight.w700)
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('₺${islem.amount.toStringAsFixed(0)}', style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 16)),
                          const SizedBox(height: 4),
                          Text(isAlacak ? 'Alacak' : 'Borç', style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            
            const SizedBox(height: 24),
            const Center(
              child: Text('Sola kaydırarak işlemi tamamlayabilirsiniz.', style: TextStyle(color: AppColors.textHint, fontSize: 12, fontWeight: FontWeight.w600)),
            ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final double amount;
  final Color color;
  final IconData icon;

  const _SummaryCard({required this.title, required this.amount, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '₺${amount.toStringAsFixed(0)}',
            style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 22, letterSpacing: -0.5),
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionChip({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
