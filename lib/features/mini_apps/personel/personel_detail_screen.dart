import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import 'models/personel_model.dart';

final _mockPersonel = Personel(
  id: 'p1', 
  name: 'Ayşe Demir', 
  title: 'Müşteri Temsilcisi', 
  department: 'Satış', 
  phone: '0533 111 2233', 
  email: 'ayse@sirket.com', 
  salary: 35000, 
  startDate: DateTime(2022, 5, 10),
);

final _mockEvraklar = [
  PersonelEvrak(id: 'e1', personelId: 'p1', title: 'Kimlik Fotokopisi', fileName: 'kimlik.pdf', uploadDate: DateTime(2022, 5, 10)),
  PersonelEvrak(id: 'e2', personelId: 'p1', title: 'Sağlık Raporu', fileName: 'saglik_raporu.pdf', uploadDate: DateTime(2022, 5, 12)),
  PersonelEvrak(id: 'e3', personelId: 'p1', title: 'İş Sözleşmesi', fileName: 'sozlesme.docx', uploadDate: DateTime(2022, 5, 15)),
];

final _mockPerformans = [
  PersonelPerformans(id: 'pf1', personelId: 'p1', evaluatorName: 'Ali Yılmaz', score: 4.5, note: 'Satış hedeflerini %120 oranında tutturdu, harika bir çeyrek geçirdi.', date: DateTime(2023, 10, 15)),
  PersonelPerformans(id: 'pf2', personelId: 'p1', evaluatorName: 'Ali Yılmaz', score: 4.0, note: 'Müşteri memnuniyet anketlerinde en yüksek puanı aldı.', date: DateTime(2023, 4, 10)),
];

class PersonelDetailScreen extends StatefulWidget {
  final String id;
  const PersonelDetailScreen({super.key, required this.id});

  @override
  State<PersonelDetailScreen> createState() => _PersonelDetailScreenState();
}

class _PersonelDetailScreenState extends State<PersonelDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Gerçekte API/Stateten gelecek.
    final p = _mockPersonel;
    
    return Scaffold(
      backgroundColor: AppColors.bgPage,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: AppColors.bgPage,
              surfaceTintColor: Colors.transparent,
              pinned: true,
              expandedHeight: 280,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.textPrimary),
                onPressed: () => context.pop(),
              ),
              title: Text(
                'Personel Detayı',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_rounded, color: AppColors.textPrimary),
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.only(top: 100, left: 24, right: 24),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          p.name.substring(0, 1),
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        p.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${p.title} • ${p.department}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: p.isActive ? AppColors.success.withOpacity(0.1) : AppColors.danger.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              p.isActive ? 'Aktif Çalışan' : 'Eski Çalışan',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: p.isActive ? AppColors.success : AppColors.danger,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Colors.deepPurple,
                indicatorWeight: 3,
                labelColor: Colors.deepPurple,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                tabs: const [
                  Tab(text: 'Özet'),
                  Tab(text: 'Evraklar'),
                  Tab(text: 'Performans'),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildOzetTab(p),
            _EvraklarTab(evraklar: _mockEvraklar),
            _PerformansTab(notlar: _mockPerformans),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_tabController.index == 1) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Dosya Yöneticisi açılıyor...')));
          } else if (_tabController.index == 2) {
             _showPerformansDialog(context);
          } else {
             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Performans notu eklemek için Performans sekmesine geçiniz.')));
          }
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
      ),
    );
  }

  void _showPerformansDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        title: const Text('Performans Notu Ekle', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Değerlendirme Puanı (1-5)',
                hintStyle: const TextStyle(fontSize: 14),
                filled: true,
                fillColor: AppColors.bgCard,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Değerlendirme Notu',
                hintStyle: const TextStyle(fontSize: 14),
                filled: true,
                fillColor: AppColors.bgCard,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('İptal', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Performans notu eklendi!', style: TextStyle(color: Colors.white)), backgroundColor: Colors.deepPurple));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Kaydet', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _buildOzetTab(Personel p) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildInfoCard(
          title: 'İletişim Bilgileri',
          icon: Icons.contact_phone_rounded,
          color: Colors.blue,
          items: [
            {'T': 'Telefon', 'V': p.phone},
            {'T': 'E-Posta', 'V': p.email},
          ],
        ),
        const SizedBox(height: 16),
        _buildInfoCard(
          title: 'Özlük ve Maaş Bilgileri',
          icon: Icons.account_balance_wallet_rounded,
          color: AppColors.categoryFinans,
          items: [
            {'T': 'Aylık Maaş', 'V': '₺${p.salary.toStringAsFixed(0)}'},
            {'T': 'İşe Giriş Tarihi', 'V': '${p.startDate.day}.${p.startDate.month}.${p.startDate.year}'},
            if (p.endDate != null)
              {'T': 'İşten Çıkış Tarihi', 'V': '${p.endDate!.day}.${p.endDate!.month}.${p.endDate!.year}'},
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCard({required String title, required IconData icon, required Color color, required List<Map<String, String>> items}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 20),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(item['T']!, style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600, fontSize: 14)),
                ),
                Expanded(
                  flex: 3,
                  child: Text(item['V']!, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700, fontSize: 14)),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _EvraklarTab extends StatelessWidget {
  final List<PersonelEvrak> evraklar;
  const _EvraklarTab({required this.evraklar});

  @override
  Widget build(BuildContext context) {
    if (evraklar.isEmpty) return const Center(child: Text('Yüklenmiş evrak yok.'));
    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: evraklar.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (ctx, i) {
        final e = evraklar[i];
        final isPdf = e.fileName.endsWith('.pdf');
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (isPdf ? AppColors.danger : Colors.blue).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isPdf ? Icons.picture_as_pdf_rounded : Icons.description_rounded,
                  color: isPdf ? AppColors.danger : Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text('${e.uploadDate.day}.${e.uploadDate.month}.${e.uploadDate.year} • ${e.fileName}', style: const TextStyle(color: AppColors.textHint, fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.download_rounded, color: Colors.deepPurple),
              )
            ],
          ),
        );
      },
    );
  }
}

class _PerformansTab extends StatelessWidget {
  final List<PersonelPerformans> notlar;
  const _PerformansTab({required this.notlar});

  @override
  Widget build(BuildContext context) {
    if (notlar.isEmpty) return const Center(child: Text('Performans kaydı bulunmuyor.'));
    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: notlar.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (ctx, i) {
        final n = notlar[i];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: AppColors.warning, size: 20),
                      const SizedBox(width: 4),
                      Text('${n.score} Puan', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                    ],
                  ),
                  Text('${n.date.day}.${n.date.month}.${n.date.year}', style: const TextStyle(color: AppColors.textHint, fontSize: 12, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 12),
              Text(n.note, style: const TextStyle(color: AppColors.textSecondary, height: 1.4, fontSize: 13)),
              const SizedBox(height: 12),
              Text('Değerlendiren: ${n.evaluatorName}', style: const TextStyle(color: AppColors.textHint, fontSize: 11, fontWeight: FontWeight.w600)),
            ],
          ),
        );
      },
    );
  }
}
