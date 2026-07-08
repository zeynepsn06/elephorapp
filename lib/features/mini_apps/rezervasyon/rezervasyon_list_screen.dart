import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/status_badge.dart';

class RezervasyonListScreen extends StatefulWidget {
  const RezervasyonListScreen({super.key});

  @override
  State<RezervasyonListScreen> createState() => _RezervasyonListScreenState();
}

class _RezervasyonListScreenState extends State<RezervasyonListScreen> {
  String _filter = 'Tümü';
  final _filters = ['Tümü', 'Onaylı', 'Bekliyor', 'İptal'];

  final _all = [
    _RezItem(musteri: 'Ayşe Demir', saat: '10:00', hizmet: 'Saç Kesimi', durum: 'Onaylı', personel: 'Zeynep K.', tarih: 'Bugün'),
    _RezItem(musteri: 'Burak Yılmaz', saat: '11:30', hizmet: 'Masaj', durum: 'Onaylı', personel: 'Ahmet Y.', tarih: 'Bugün'),
    _RezItem(musteri: 'Canan Şahin', saat: '14:00', hizmet: 'Cilt Bakımı', durum: 'Bekliyor', personel: 'Zeynep K.', tarih: 'Bugün'),
    _RezItem(musteri: 'Deniz Kaya', saat: '16:00', hizmet: 'Saç Boyama', durum: 'İptal', personel: 'Ahmet Y.', tarih: 'Bugün'),
    _RezItem(musteri: 'Emre Çelik', saat: '09:00', hizmet: 'Masaj', durum: 'Onaylı', personel: 'Murat D.', tarih: 'Yarın'),
    _RezItem(musteri: 'Fatma Arslan', saat: '13:00', hizmet: 'Cilt Bakımı', durum: 'Bekliyor', personel: 'Zeynep K.', tarih: 'Yarın'),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _filter == 'Tümü'
        ? _all
        : _all.where((r) => r.durum == _filter).toList();

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Tüm Rezervasyonlar',
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
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton.icon(
              onPressed: () => context.push('/mini-apps/rezervasyon/add'),
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text('Ekle', style: TextStyle(fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.categoryMusteri,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              ),
            ),
          ),
        ],
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
                        color: selected ? AppColors.categoryMusteri : AppColors.bgCard,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selected ? AppColors.categoryMusteri : AppColors.borderLight.withOpacity(0.5),
                        ),
                        boxShadow: selected ? [
                          BoxShadow(
                            color: AppColors.categoryMusteri.withOpacity(0.2),
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
            child: filtered.isEmpty
                ? Center(
                    child: Text(
                      'Kayıt bulunamadı',
                      style: TextStyle(color: AppColors.textHint, fontWeight: FontWeight.w500),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(24),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (ctx, i) => _RezCard(item: filtered[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _RezItem {
  final String musteri;
  final String saat;
  final String hizmet;
  final String durum;
  final String personel;
  final String tarih;

  const _RezItem({
    required this.musteri,
    required this.saat,
    required this.hizmet,
    required this.durum,
    required this.personel,
    required this.tarih,
  });
}

class _RezCard extends StatelessWidget {
  final _RezItem item;
  const _RezCard({required this.item});

  BadgeType get _type {
    switch (item.durum) {
      case 'Onaylı': return BadgeType.success;
      case 'İptal': return BadgeType.danger;
      default: return BadgeType.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: item.durum == 'İptal'
              ? AppColors.danger.withOpacity(0.3)
              : AppColors.borderLight.withOpacity(0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: item.durum == 'İptal' 
                ? AppColors.danger.withOpacity(0.05) 
                : AppColors.black900.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.categoryMusteri.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  item.saat.split(':')[0],
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.categoryMusteri,
                        fontWeight: FontWeight.w800,
                        height: 1,
                      ),
                ),
                Text(
                  item.saat.split(':')[1],
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.categoryMusteri.withOpacity(0.7),
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.musteri,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        )
                      ),
                    ),
                    StatusBadge(
                        label: item.durum,
                        type: _type,
                        small: true),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.bgSurface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.spa_outlined,
                              size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 6),
                          Text(item.hizmet,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.bgSurface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.person_outline_rounded,
                              size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 6),
                          Text(item.personel,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_rounded, size: 12, color: AppColors.textHint),
                    const SizedBox(width: 4),
                    Text(
                      item.tarih,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      )
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (item.durum == 'Bekliyor') ...[
                      _SmallActionButton(
                        icon: Icons.check_circle_outline_rounded,
                        label: 'Onayla',
                        color: AppColors.success,
                        onTap: () {},
                      ),
                      const SizedBox(width: 8),
                    ],
                    if (item.durum != 'İptal') ...[
                      _SmallActionButton(
                        icon: Icons.schedule_rounded,
                        label: 'Ertele',
                        color: AppColors.warning,
                        onTap: () {},
                      ),
                      const SizedBox(width: 8),
                      _SmallActionButton(
                        icon: Icons.cancel_outlined,
                        label: 'İptal',
                        color: AppColors.danger,
                        onTap: () {},
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _SmallActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
