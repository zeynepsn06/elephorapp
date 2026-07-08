import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/status_badge.dart';

class _Rezervasyon {
  final String musteri;
  final String saat;
  final String hizmet;
  final String durum;
  final String personel;
  final DateTime tarih;

  const _Rezervasyon({
    required this.musteri,
    required this.saat,
    required this.hizmet,
    required this.durum,
    required this.personel,
    required this.tarih,
  });
}

final _today = DateTime.now();
final _mockRezervasyonlar = [
  _Rezervasyon(musteri: 'Ayşe Demir', saat: '10:00', hizmet: 'Saç Kesimi', durum: 'Onaylı', personel: 'Zeynep K.', tarih: _today),
  _Rezervasyon(musteri: 'Burak Yılmaz', saat: '11:30', hizmet: 'Masaj', durum: 'Onaylı', personel: 'Ahmet Y.', tarih: _today),
  _Rezervasyon(musteri: 'Canan Şahin', saat: '14:00', hizmet: 'Cilt Bakımı', durum: 'Bekliyor', personel: 'Zeynep K.', tarih: _today),
  _Rezervasyon(musteri: 'Deniz Kaya', saat: '16:00', hizmet: 'Saç Boyama', durum: 'İptal', personel: 'Ahmet Y.', tarih: _today),
  _Rezervasyon(musteri: 'Emre Çelik', saat: '09:00', hizmet: 'Masaj', durum: 'Onaylı', personel: 'Murat D.', tarih: _today.add(const Duration(days: 1))),
];

class RezervasyonHomeScreen extends StatefulWidget {
  const RezervasyonHomeScreen({super.key});

  @override
  State<RezervasyonHomeScreen> createState() => _RezervasyonHomeScreenState();
}

class _RezervasyonHomeScreenState extends State<RezervasyonHomeScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  List<_Rezervasyon> get _todaysRezervasyonlar {
    return _mockRezervasyonlar
        .where((r) =>
            r.tarih.year == _selectedDay.year &&
            r.tarih.month == _selectedDay.month &&
            r.tarih.day == _selectedDay.day)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final reservations = _todaysRezervasyonlar;
    final onayliCount = reservations.where((r) => r.durum == 'Onaylı').length;
    final iptalCount = reservations.where((r) => r.durum == 'İptal').length;

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.bgPage,
            surfaceTintColor: Colors.transparent,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.textPrimary),
              onPressed: () => context.pop(),
            ),
            title: Text(
              'Rezervasyon Yönetimi',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: ElevatedButton.icon(
                  onPressed: () => context.push('/mini-apps/rezervasyon/add'),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('Yeni', style: TextStyle(fontWeight: FontWeight.w700)),
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
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Calendar Container
                Container(
                  margin: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black900.withOpacity(0.02),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: TableCalendar(
                      firstDay: DateTime.now().subtract(const Duration(days: 365)),
                      lastDay: DateTime.now().add(const Duration(days: 365)),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (d) => isSameDay(d, _selectedDay),
                      calendarFormat: _calendarFormat,
                      onFormatChanged: (f) => setState(() => _calendarFormat = f),
                      onDaySelected: (selected, focused) {
                        setState(() {
                          _selectedDay = selected;
                          _focusedDay = focused;
                        });
                      },
                      eventLoader: (day) => _mockRezervasyonlar
                          .where((r) =>
                              r.tarih.year == day.year &&
                              r.tarih.month == day.month &&
                              r.tarih.day == day.day)
                          .toList(),
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textSecondary, fontSize: 13),
                        weekendStyle: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textSecondary, fontSize: 13),
                      ),
                      calendarStyle: CalendarStyle(
                        selectedDecoration: const BoxDecoration(
                          color: AppColors.categoryMusteri,
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: AppColors.categoryMusteri.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        todayTextStyle: const TextStyle(color: AppColors.categoryMusteri, fontWeight: FontWeight.w700),
                        markerDecoration: const BoxDecoration(
                          color: AppColors.primaryGreen,
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                        weekendTextStyle: const TextStyle(color: AppColors.textSecondary),
                        defaultTextStyle: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: true,
                        titleCentered: true,
                        titleTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                        formatButtonDecoration: BoxDecoration(
                          color: AppColors.categoryMusteri.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        formatButtonTextStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.categoryMusteri),
                        leftChevronIcon: const Icon(Icons.chevron_left_rounded, color: AppColors.textPrimary),
                        rightChevronIcon: const Icon(Icons.chevron_right_rounded, color: AppColors.textPrimary),
                      ),
                    ),
                  ),
                ),

                // Summary bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: _SummaryPill(
                          label: '${reservations.length} Toplam',
                          color: AppColors.categoryMusteri,
                          icon: Icons.assignment_rounded,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _SummaryPill(
                          label: '$onayliCount Onaylı',
                          color: AppColors.success,
                          icon: Icons.check_circle_rounded,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _SummaryPill(
                          label: '$iptalCount İptal',
                          color: AppColors.danger,
                          icon: Icons.cancel_rounded,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),

                // Hızlı İşlemler Butonları
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'İşlemler',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _ActionButton(
                            icon: Icons.add_alarm_rounded,
                            label: 'Randevu Ekle',
                            onTap: () => context.push('/mini-apps/rezervasyon/add'),
                          ),
                          _ActionButton(
                            icon: Icons.calendar_month_rounded,
                            label: 'Takvime Git',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Takvim görünümü açılıyor...')));
                            },
                          ),
                          _ActionButton(
                            icon: Icons.person_add_alt_1_rounded,
                            label: 'Müşteri Seç',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Müşteri seçme ekranı...')));
                            },
                          ),
                          _ActionButton(
                            icon: Icons.badge_outlined,
                            label: 'Personel Seç',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Personel atama ekranı...')));
                            },
                          ),
                          _ActionButton(
                            icon: Icons.fact_check_rounded,
                            label: 'Onayla',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bekleyen randevular listesi...')));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                
                // Content Section Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bugünün Randevuları',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.push('/mini-apps/rezervasyon/list'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.categoryMusteri,
                          textStyle: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        child: const Text('Tümünü Gör'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // List
          if (reservations.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.bgCard,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: AppColors.black900.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))
                        ]
                      ),
                      child: const Icon(Icons.event_available_rounded, size: 48, color: AppColors.textHint),
                    ),
                    const SizedBox(height: 24),
                    Text('Randevu Yok', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    const Text('Seçilen güne ait randevu bulunamadı.', style: TextStyle(color: AppColors.textSecondary)),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _RezervasyonCard(rezervasyon: reservations[index]),
                  ),
                  childCount: reservations.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SummaryPill extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;

  const _SummaryPill({required this.label, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
                color: color, fontSize: 13, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _RezervasyonCard extends StatelessWidget {
  final _Rezervasyon rezervasyon;
  const _RezervasyonCard({required this.rezervasyon});

  BadgeType get _badgeType {
    switch (rezervasyon.durum) {
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
          color: rezervasyon.durum == 'İptal'
              ? AppColors.danger.withOpacity(0.3)
              : AppColors.borderLight.withOpacity(0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: rezervasyon.durum == 'İptal' 
                ? AppColors.danger.withOpacity(0.05) 
                : AppColors.black900.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          // Time column
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.categoryMusteri.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  rezervasyon.saat.split(':')[0],
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.categoryMusteri,
                        fontWeight: FontWeight.w800,
                        height: 1,
                      ),
                ),
                Text(
                  rezervasyon.saat.split(':')[1],
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
                        rezervasyon.musteri,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        )
                      ),
                    ),
                    StatusBadge(
                        label: rezervasyon.durum,
                        type: _badgeType,
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
                          Text(rezervasyon.hizmet,
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
                          Text(rezervasyon.personel,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (rezervasyon.durum == 'Bekliyor') ...[
                      _SmallActionButton(
                        icon: Icons.check_circle_outline_rounded,
                        label: 'Onayla',
                        color: AppColors.success,
                        onTap: () {},
                      ),
                      const SizedBox(width: 8),
                    ],
                    if (rezervasyon.durum != 'İptal') ...[
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

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (MediaQuery.of(context).size.width - 60) / 2, // 2 columns, considering padding 24+24 and spacing 12
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [
            BoxShadow(
              color: AppColors.black900.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.categoryMusteri.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.categoryMusteri, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
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

