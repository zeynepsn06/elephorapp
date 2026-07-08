import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import 'models/izin_model.dart';

final _mockKalanIzinler = [
  KalanIzinRapor(personelId: 'p1', personelName: 'Ahmet Yılmaz', yillikIzinHakki: 14, kullanilanIzin: 5),
  KalanIzinRapor(personelId: 'p2', personelName: 'Zeynep Kaya', yillikIzinHakki: 14, kullanilanIzin: 0),
  KalanIzinRapor(personelId: 'p3', personelName: 'Ali Vefa', yillikIzinHakki: 20, kullanilanIzin: 20), // İzni bitmiş
];

class IzinReportsScreen extends StatefulWidget {
  const IzinReportsScreen({super.key});

  @override
  State<IzinReportsScreen> createState() => _IzinReportsScreenState();
}

class _IzinReportsScreenState extends State<IzinReportsScreen> with SingleTickerProviderStateMixin {
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
          'İzin Raporları',
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
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PDF Raporu indiriliyor...')));
            },
            icon: const Icon(Icons.picture_as_pdf_rounded, color: AppColors.textPrimary),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.categoryOperasyon,
          indicatorWeight: 3,
          labelColor: AppColors.categoryOperasyon,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          tabs: const [
            Tab(text: 'Kalan İzinler'),
            Tab(text: 'İzin Geçmişi'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildKalanIzinlerList(),
          _buildIzinGecmisiList(),
        ],
      ),
    );
  }

  Widget _buildKalanIzinlerList() {
    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: _mockKalanIzinler.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (ctx, i) {
        final rapor = _mockKalanIzinler[i];
        final isTukendi = rapor.kalanIzin <= 0;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: isTukendi ? AppColors.danger.withOpacity(0.5) : AppColors.borderLight, width: isTukendi ? 1.5 : 1),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.categoryOperasyon.withOpacity(0.2),
                child: Text(rapor.personelName[0], style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.categoryOperasyon)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(rapor.personelName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text(
                      'Kullanılan: ${rapor.kullanilanIzin} / Hak: ${rapor.yillikIzinHakki}', 
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600)
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${rapor.kalanIzin} Gün', style: TextStyle(
                    color: isTukendi ? AppColors.danger : AppColors.textPrimary, 
                    fontWeight: FontWeight.w800, 
                    fontSize: 18,
                  )),
                  const SizedBox(height: 4),
                  Text('Kalan', style: TextStyle(color: isTukendi ? AppColors.danger : AppColors.textHint, fontSize: 11, fontWeight: FontWeight.w700)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIzinGecmisiList() {
    // Burada IzinHomeScreen'deki geçmiş taleplerin (onaylanan, reddedilen) mock halini oluşturuyoruz
    final gecmis = [
      IzinTalebi(id: 'g1', personelId: 'p3', personelName: 'Ali Vefa', izinTuru: 'Yıllık İzin', baslangicTarihi: DateTime.now().subtract(const Duration(days: 30)), bitisTarihi: DateTime.now().subtract(const Duration(days: 20)), talepTarihi: DateTime.now().subtract(const Duration(days: 40)), durum: IzinDurumu.onaylandi),
      IzinTalebi(id: 'g2', personelId: 'p2', personelName: 'Zeynep Kaya', izinTuru: 'Mazeret İzni', baslangicTarihi: DateTime.now().subtract(const Duration(days: 10)), bitisTarihi: DateTime.now().subtract(const Duration(days: 10)), talepTarihi: DateTime.now().subtract(const Duration(days: 12)), durum: IzinDurumu.reddedildi, redNedeni: 'İş yoğunluğu sebebiyle bu tarihte izin verilemiyor.'),
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: gecmis.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (ctx, i) {
        final talep = gecmis[i];
        final isOnay = talep.durum == IzinDurumu.onaylandi;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: isOnay ? AppColors.success.withOpacity(0.5) : AppColors.danger.withOpacity(0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(talep.personelName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isOnay ? AppColors.success.withOpacity(0.1) : AppColors.danger.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      isOnay ? 'Onaylandı' : 'Reddedildi',
                      style: TextStyle(
                        color: isOnay ? AppColors.success : AppColors.danger,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('${talep.izinTuru} • ${talep.gunSayisi} Gün', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(
                'Tarih: ${talep.baslangicTarihi.day}.${talep.baslangicTarihi.month}.${talep.baslangicTarihi.year} - ${talep.bitisTarihi.day}.${talep.bitisTarihi.month}.${talep.bitisTarihi.year}', 
                style: const TextStyle(color: AppColors.textHint, fontSize: 12, fontWeight: FontWeight.w700)
              ),
              if (talep.redNedeni != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: AppColors.danger.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline_rounded, color: AppColors.danger, size: 16),
                      const SizedBox(width: 8),
                      Expanded(child: Text('Red Nedeni: ${talep.redNedeni}', style: const TextStyle(color: AppColors.danger, fontSize: 12, height: 1.3))),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
