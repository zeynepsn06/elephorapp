import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import 'models/siparis_model.dart';

// Mock data
final _initialSiparisler = [
  SiparisModel(
    id: 's1',
    siparisNo: 'SP-1001',
    musteriId: 'm1',
    musteriAdi: 'Ahmet Yılmaz',
    tarih: DateTime.now().subtract(const Duration(hours: 2)),
    durum: SiparisDurumu.yeniSiparis,
    urunler: [
      const SiparisUrun(urunAdi: 'Laptop', adet: 1, birimFiyat: 25000),
      const SiparisUrun(urunAdi: 'Mouse', adet: 2, birimFiyat: 500),
    ],
  ),
  SiparisModel(
    id: 's2',
    siparisNo: 'SP-1002',
    musteriId: 'm2',
    musteriAdi: 'Mavi Reklam Ajansı',
    tarih: DateTime.now().subtract(const Duration(days: 1)),
    durum: SiparisDurumu.hazirlaniyor,
    urunler: [
      const SiparisUrun(urunAdi: 'Monitör 24"', adet: 4, birimFiyat: 3500),
    ],
  ),
  SiparisModel(
    id: 's3',
    siparisNo: 'SP-1003',
    musteriId: 'm3',
    musteriAdi: 'Zeynep Kaya',
    tarih: DateTime.now().subtract(const Duration(days: 2)),
    durum: SiparisDurumu.kargoda,
    kargoTakipNo: '123456789',
    urunler: [
      const SiparisUrun(urunAdi: 'Klavye', adet: 1, birimFiyat: 1200),
    ],
  ),
];

class SiparisHomeScreen extends StatefulWidget {
  const SiparisHomeScreen({super.key});

  @override
  State<SiparisHomeScreen> createState() => _SiparisHomeScreenState();
}

class _SiparisHomeScreenState extends State<SiparisHomeScreen> {
  List<SiparisModel> _siparisler = [];
  String _selectedFilter = 'Tümü';
  
  final List<String> _filters = ['Tümü', 'Yeni Sipariş', 'Hazırlanıyor', 'Kargoda', 'Teslim Edildi'];

  @override
  void initState() {
    super.initState();
    _siparisler = List.from(_initialSiparisler);
  }

  @override
  Widget build(BuildContext context) {
    int aktifSiparisSayisi = _siparisler.where((s) => s.durum != SiparisDurumu.teslimEdildi && s.durum != SiparisDurumu.iptalEdildi).length;

    List<SiparisModel> filteredList = _siparisler.where((s) {
      if (_selectedFilter == 'Tümü') return true;
      if (_selectedFilter == 'Yeni Sipariş') return s.durum == SiparisDurumu.yeniSiparis;
      if (_selectedFilter == 'Hazırlanıyor') return s.durum == SiparisDurumu.hazirlaniyor;
      if (_selectedFilter == 'Kargoda') return s.durum == SiparisDurumu.kargoda;
      if (_selectedFilter == 'Teslim Edildi') return s.durum == SiparisDurumu.teslimEdildi;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Sipariş Takibi',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: _SummaryCard(title: 'Aktif Siparişler', count: aktifSiparisSayisi, color: AppColors.categoryOperasyon, icon: Icons.shopping_bag_rounded),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => context.push('/mini-apps/siparis/reports'),
                    child: const _SummaryCard(title: 'Raporlar', count: 0, color: AppColors.textSecondary, icon: Icons.bar_chart_rounded, showCount: false),
                  ),
                ),
              ],
            ),
          ),
          
          // Filtreler
          SizedBox(
            height: 48,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (ctx, i) {
                final isSelected = _selectedFilter == _filters[i];
                return GestureDetector(
                  onTap: () => setState(() => _selectedFilter = _filters[i]),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.categoryOperasyon : AppColors.bgCard,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: isSelected ? AppColors.categoryOperasyon : AppColors.borderLight),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _filters[i],
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Liste
          Expanded(
            child: filteredList.isEmpty
                ? const Center(child: Text('Bu duruma ait sipariş bulunamadı.', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)))
                : ListView.separated(
                    padding: const EdgeInsets.all(24),
                    itemCount: filteredList.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (ctx, i) {
                      final siparis = filteredList[i];
                      return GestureDetector(
                        onTap: () {
                          // Detaya git ve dönünce listeyi güncelle
                          context.push('/mini-apps/siparis/detail/${siparis.id}');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.bgCard,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.borderLight),
                            boxShadow: [BoxShadow(color: AppColors.black900.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(siparis.siparisNo, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: siparis.durumColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      siparis.durumText,
                                      style: TextStyle(color: siparis.durumColor, fontSize: 11, fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(Icons.person_outline_rounded, size: 18, color: AppColors.textHint),
                                  const SizedBox(width: 8),
                                  Text(siparis.musteriAdi, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${siparis.urunler.length} Çeşit Ürün', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w600)),
                                  Text('₺${siparis.toplamTutar.toStringAsFixed(2)}', style: const TextStyle(color: AppColors.categoryOperasyon, fontWeight: FontWeight.w800, fontSize: 16)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/mini-apps/siparis/add'),
        backgroundColor: AppColors.categoryOperasyon,
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final IconData icon;
  final bool showCount;

  const _SummaryCard({required this.title, required this.count, required this.color, required this.icon, this.showCount = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [BoxShadow(color: color.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600, fontSize: 13)),
          if (showCount) ...[
            const SizedBox(height: 4),
            Text(count.toString(), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
          ]
        ],
      ),
    );
  }
}
