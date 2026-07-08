import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import 'models/siparis_model.dart';

final _mockGecmisSiparisler = [
  SiparisModel(
    id: 's4',
    siparisNo: 'SP-0999',
    musteriId: 'm4',
    musteriAdi: 'Efe Turizm',
    tarih: DateTime.now().subtract(const Duration(days: 3)),
    durum: SiparisDurumu.teslimEdildi,
    urunler: [
      const SiparisUrun(urunAdi: 'Web Sitesi Paketi', adet: 1, birimFiyat: 15000),
    ],
  ),
  SiparisModel(
    id: 's5',
    siparisNo: 'SP-0998',
    musteriId: 'm1',
    musteriAdi: 'Ahmet Yılmaz',
    tarih: DateTime.now().subtract(const Duration(days: 5)),
    durum: SiparisDurumu.iptalEdildi,
    notlar: 'Müşteri vazgeçti.',
    urunler: [
      const SiparisUrun(urunAdi: 'SEO Danışmanlığı', adet: 1, birimFiyat: 5000),
    ],
  ),
  SiparisModel(
    id: 's6',
    siparisNo: 'SP-0997',
    musteriId: 'm5',
    musteriAdi: 'Beta Lojistik',
    tarih: DateTime.now().subtract(const Duration(days: 10)),
    durum: SiparisDurumu.teslimEdildi,
    urunler: [
      const SiparisUrun(urunAdi: 'Sunucu Kurulumu', adet: 1, birimFiyat: 8000),
      const SiparisUrun(urunAdi: 'Yıllık Bakım', adet: 1, birimFiyat: 12000),
    ],
  ),
];

class SiparisReportsScreen extends StatelessWidget {
  const SiparisReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double toplamKazanc = 0;
    int iptalSayisi = 0;
    int teslimSayisi = 0;

    for (var s in _mockGecmisSiparisler) {
      if (s.durum == SiparisDurumu.teslimEdildi) {
        toplamKazanc += s.toplamTutar;
        teslimSayisi++;
      } else if (s.durum == SiparisDurumu.iptalEdildi) {
        iptalSayisi++;
      }
    }

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Sipariş Raporu',
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
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Rapor Excel olarak indiriliyor...')));
            },
            icon: const Icon(Icons.download_rounded, color: AppColors.textPrimary),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Özet Kartı
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.borderLight),
              boxShadow: [BoxShadow(color: AppColors.categoryOperasyon.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.bar_chart_rounded, color: AppColors.categoryOperasyon),
                    SizedBox(width: 8),
                    Text('Aylık Sipariş Özeti', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _StatItem(title: 'Teslim Edilen', value: '$teslimSayisi', color: AppColors.success),
                    _StatItem(title: 'İptal Edilen', value: '$iptalSayisi', color: AppColors.danger),
                    _StatItem(title: 'Toplam Kazanç', value: '₺${(toplamKazanc / 1000).toStringAsFixed(1)}K', color: AppColors.textPrimary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          Text('Sipariş Geçmişi', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.3)),
          const SizedBox(height: 16),

          ..._mockGecmisSiparisler.map((siparis) {
            final isIptal = siparis.durum == SiparisDurumu.iptalEdildi;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.bgCard,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isIptal ? AppColors.danger.withOpacity(0.3) : AppColors.success.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(siparis.siparisNo, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                      Text(
                        isIptal ? 'İptal Edildi' : 'Teslim Edildi',
                        style: TextStyle(
                          color: isIptal ? AppColors.danger : AppColors.success,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.person_outline_rounded, size: 16, color: AppColors.textHint),
                      const SizedBox(width: 6),
                      Text(siparis.musteriAdi, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${siparis.tarih.day}.${siparis.tarih.month}.${siparis.tarih.year}', style: const TextStyle(color: AppColors.textHint, fontSize: 13, fontWeight: FontWeight.w600)),
                      Text('₺${siparis.toplamTutar.toStringAsFixed(2)}', style: TextStyle(color: isIptal ? AppColors.textHint : AppColors.textPrimary, fontWeight: FontWeight.w800, fontSize: 15, decoration: isIptal ? TextDecoration.lineThrough : null)),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _StatItem({required this.title, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.w900)),
      ],
    );
  }
}
