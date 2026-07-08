import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/status_badge.dart';
import 'vardiya_add_modal.dart';

class VardiyaListScreen extends StatefulWidget {
  const VardiyaListScreen({super.key});

  @override
  State<VardiyaListScreen> createState() => _VardiyaListScreenState();
}

class _VardiyaListScreenState extends State<VardiyaListScreen> {
  String _filter = 'Tümü';
  final _filters = ['Tümü', 'Aktif', 'Geç Kalan', 'Çıkış Yapıldı'];

  final _allRecords = [
    _VardiyaRecord(name: 'Ahmet Yılmaz', entry: '09:05', exit: null, isLate: true, status: 'Aktif'),
    _VardiyaRecord(name: 'Zeynep Kaya', entry: '09:00', exit: null, isLate: false, status: 'Aktif'),
    _VardiyaRecord(name: 'Murat Demir', entry: '08:55', exit: null, isLate: false, status: 'Aktif'),
    _VardiyaRecord(name: 'Selin Arslan', entry: '09:02', exit: null, isLate: false, status: 'Aktif'),
    _VardiyaRecord(name: 'Can Yıldız', entry: '08:00', exit: '17:00', isLate: false, status: 'Çıkış Yapıldı'),
    _VardiyaRecord(name: 'Elif Şahin', entry: '09:30', exit: '18:00', isLate: true, status: 'Çıkış Yapıldı'),
  ];

  @override
  Widget build(BuildContext context) {
    final records = _filter == 'Tümü'
        ? _allRecords
        : _allRecords.where((r) {
            if (_filter == 'Geç Kalan') return r.isLate;
            return r.status == _filter;
          }).toList();

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Vardiya Listesi',
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
              onPressed: () {
                VardiyaAddModal.show(context);
              },
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text('Ekle', style: TextStyle(fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.categoryPersonel,
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
          // Filter chips
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
                        color: selected ? AppColors.categoryPersonel : AppColors.bgCard,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selected ? AppColors.categoryPersonel : AppColors.borderLight.withOpacity(0.5),
                        ),
                        boxShadow: selected ? [
                          BoxShadow(
                            color: AppColors.categoryPersonel.withOpacity(0.2),
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
            child: records.isEmpty
                ? Center(
                    child: Text(
                      'Kayıt bulunamadı',
                      style: TextStyle(color: AppColors.textHint, fontWeight: FontWeight.w500),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(24),
                    itemCount: records.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (ctx, i) => _RecordCard(record: records[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _VardiyaRecord {
  final String name;
  final String entry;
  final String? exit;
  final bool isLate;
  final String status;

  const _VardiyaRecord({
    required this.name,
    required this.entry,
    required this.exit,
    required this.isLate,
    required this.status,
  });
}

class _RecordCard extends StatelessWidget {
  final _VardiyaRecord record;
  const _RecordCard({required this.record});

  @override
  Widget build(BuildContext context) {
    final isActive = record.exit == null;
    final duration = isActive ? 'Devam ediyor' : '9 saat';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black900.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.categoryPersonel.withOpacity(0.2),
                      AppColors.categoryPersonel.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    record.name.split(' ').map((e) => e[0]).take(2).join(),
                    style: const TextStyle(
                      color: AppColors.categoryPersonel,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          record.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (record.isLate)
                          StatusBadge(label: 'Geç Kaldı', type: BadgeType.warning, small: true),
                      ],
                    ),
                    const SizedBox(height: 4),
                    StatusBadge(
                      label: record.status,
                      type: isActive ? BadgeType.success : BadgeType.neutral,
                      small: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.gray50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _TimeColumn(
                  icon: Icons.login_rounded,
                  label: 'Giriş',
                  value: record.entry,
                  color: AppColors.success,
                ),
                Container(width: 1, height: 24, color: AppColors.borderLight),
                _TimeColumn(
                  icon: Icons.logout_rounded,
                  label: 'Çıkış',
                  value: record.exit ?? '--:--',
                  color: isActive ? AppColors.textHint : AppColors.warning,
                ),
                Container(width: 1, height: 24, color: AppColors.borderLight),
                _TimeColumn(
                  icon: Icons.timer_outlined,
                  label: 'Süre',
                  value: duration,
                  color: AppColors.primaryGreen,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _TimeColumn extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _TimeColumn({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: AppColors.textHint),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

