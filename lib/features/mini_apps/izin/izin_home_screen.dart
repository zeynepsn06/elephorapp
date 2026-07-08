import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import 'models/izin_model.dart';

final _initialTalepler = [
  IzinTalebi(
    id: 'i1',
    personelId: 'p1',
    personelName: 'Ahmet Yılmaz',
    izinTuru: 'Yıllık İzin',
    baslangicTarihi: DateTime.now().add(const Duration(days: 2)),
    bitisTarihi: DateTime.now().add(const Duration(days: 6)),
    aciklama: 'Yaz tatili için memlekete gideceğim.',
    talepTarihi: DateTime.now().subtract(const Duration(days: 1)),
  ),
  IzinTalebi(
    id: 'i2',
    personelId: 'p2',
    personelName: 'Zeynep Kaya',
    izinTuru: 'Mazeret İzni',
    baslangicTarihi: DateTime.now().add(const Duration(days: 1)),
    bitisTarihi: DateTime.now().add(const Duration(days: 1)),
    aciklama: 'Kişisel işlerim nedeniyle 1 gün izin rica ediyorum.',
    talepTarihi: DateTime.now().subtract(const Duration(hours: 5)),
  ),
];

class IzinHomeScreen extends StatefulWidget {
  const IzinHomeScreen({super.key});

  @override
  State<IzinHomeScreen> createState() => _IzinHomeScreenState();
}

class _IzinHomeScreenState extends State<IzinHomeScreen> {
  List<IzinTalebi> _talepler = [];

  @override
  void initState() {
    super.initState();
    _talepler = List.from(_initialTalepler);
  }

  void _onayla(String id) {
    setState(() {
      final idx = _talepler.indexWhere((t) => t.id == id);
      if (idx != -1) {
        final old = _talepler[idx];
        _talepler[idx] = IzinTalebi(
          id: old.id,
          personelId: old.personelId,
          personelName: old.personelName,
          izinTuru: old.izinTuru,
          baslangicTarihi: old.baslangicTarihi,
          bitisTarihi: old.bitisTarihi,
          aciklama: old.aciklama,
          talepTarihi: old.talepTarihi,
          durum: IzinDurumu.onaylandi,
        );
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('İzin talebi onaylandı.'), backgroundColor: AppColors.success));
  }

  void _reddet(String id) {
    final _redCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.bgPage,
        title: const Text('İzni Reddet', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
        content: TextField(
          controller: _redCtrl,
          decoration: InputDecoration(
            hintText: 'Reddetme nedeni (Opsiyonel)',
            filled: true,
            fillColor: AppColors.bgCard,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('İptal', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                final idx = _talepler.indexWhere((t) => t.id == id);
                if (idx != -1) {
                  final old = _talepler[idx];
                  _talepler[idx] = IzinTalebi(
                    id: old.id,
                    personelId: old.personelId,
                    personelName: old.personelName,
                    izinTuru: old.izinTuru,
                    baslangicTarihi: old.baslangicTarihi,
                    bitisTarihi: old.bitisTarihi,
                    aciklama: old.aciklama,
                    talepTarihi: old.talepTarihi,
                    durum: IzinDurumu.reddedildi,
                    redNedeni: _redCtrl.text,
                  );
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('İzin talebi reddedildi.'), backgroundColor: AppColors.danger));
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Text('Reddet', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bekleyenler = _talepler.where((t) => t.durum == IzinDurumu.bekliyor).toList();
    final onaylananCount = _talepler.where((t) => t.durum == IzinDurumu.onaylandi).length;

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'İzin Yönetimi',
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
          Row(
            children: [
              Expanded(child: _SummaryCard(title: 'Bekleyen Talep', count: bekleyenler.length, color: AppColors.warning, icon: Icons.hourglass_top_rounded)),
              const SizedBox(width: 16),
              Expanded(child: _SummaryCard(title: 'Bugün İzinli', count: onaylananCount, color: AppColors.success, icon: Icons.event_available_rounded)),
            ],
          ),
          const SizedBox(height: 24),
          
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _ActionChip(icon: Icons.add_rounded, label: 'İzin Talebi Oluştur', color: AppColors.categoryOperasyon, onTap: () => context.push('/mini-apps/izin/add')),
                const SizedBox(width: 12),
                _ActionChip(icon: Icons.calendar_month_rounded, label: 'İzin Takvimi', color: Colors.blue, onTap: () => context.push('/mini-apps/izin/calendar')),
                const SizedBox(width: 12),
                _ActionChip(icon: Icons.pie_chart_rounded, label: 'İzin Raporu', color: AppColors.textSecondary, onTap: () => context.push('/mini-apps/izin/reports')),
              ],
            ),
          ),
          const SizedBox(height: 32),

          Text(
            'Onay Bekleyen Talepler',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
          ),
          const SizedBox(height: 16),

          if (bekleyenler.isEmpty)
            const Center(child: Padding(
              padding: EdgeInsets.all(32),
              child: Text('Onay bekleyen izin talebi yok.', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
            ))
          else
            ...bekleyenler.map((talep) {
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.bgCard,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.warning.withOpacity(0.5)),
                  boxShadow: [BoxShadow(color: AppColors.black900.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.categoryOperasyon.withOpacity(0.2),
                          child: Text(talep.personelName[0], style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.categoryOperasyon)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(talep.personelName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                              Text('${talep.izinTuru} • ${talep.gunSayisi} Gün', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        Text(
                          '${talep.baslangicTarihi.day}.${talep.baslangicTarihi.month} - ${talep.bitisTarihi.day}.${talep.bitisTarihi.month}',
                          style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.textPrimary, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.bgPage,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Açıklama: ${talep.aciklama}',
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _reddet(talep.id),
                            icon: const Icon(Icons.close_rounded, size: 18),
                            label: const Text('Reddet'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.danger,
                              side: BorderSide(color: AppColors.danger.withOpacity(0.3)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _onayla(talep.id),
                            icon: const Icon(Icons.check_rounded, size: 18),
                            label: const Text('Onayla'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.success,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final IconData icon;

  const _SummaryCard({required this.title, required this.count, required this.color, required this.icon});

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
          const SizedBox(height: 4),
          Text(count.toString(), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
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
