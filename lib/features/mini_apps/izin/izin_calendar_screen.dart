import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import 'models/izin_model.dart';

// Mock datalar: Hangi gün kim izinli?
final _mockIzinliler = {
  DateTime(DateTime.now().year, DateTime.now().month, 10): ['Ahmet Yılmaz'],
  DateTime(DateTime.now().year, DateTime.now().month, 11): ['Ahmet Yılmaz', 'Zeynep Kaya'],
  DateTime(DateTime.now().year, DateTime.now().month, 12): ['Zeynep Kaya'],
};

class IzinCalendarScreen extends StatefulWidget {
  const IzinCalendarScreen({super.key});

  @override
  State<IzinCalendarScreen> createState() => _IzinCalendarScreenState();
}

class _IzinCalendarScreenState extends State<IzinCalendarScreen> {
  DateTime _currentMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime _selectedDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  List<String> _getIzinlilerForDate(DateTime date) {
    for (final key in _mockIzinliler.keys) {
      if (key.year == date.year && key.month == date.month && key.day == date.day) {
        return _mockIzinliler[key]!;
      }
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'İzin Takvimi',
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
          // Takvim
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.borderLight),
              boxShadow: [
                BoxShadow(color: AppColors.black900.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
              ],
            ),
            child: Column(
              children: [
                // Ay Seçici
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left_rounded, color: AppColors.textPrimary),
                      onPressed: () {
                        setState(() => _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1));
                      },
                    ),
                    Text(
                      '${_ayAdi(_currentMonth.month)} ${_currentMonth.year}',
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right_rounded, color: AppColors.textPrimary),
                      onPressed: () {
                        setState(() => _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Haftanın Günleri
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ['Pt', 'Sa', 'Ça', 'Pe', 'Cu', 'Ct', 'Pz'].map((d) => SizedBox(
                    width: 32,
                    child: Center(child: Text(d, style: const TextStyle(color: AppColors.textHint, fontWeight: FontWeight.w700, fontSize: 13))),
                  )).toList(),
                ),
                const SizedBox(height: 12),
                
                // Günler Grid'i
                _buildCalendarGrid(),
              ],
            ),
          ),
          const SizedBox(height: 32),
          
          Text(
            '${_selectedDate.day} ${_ayAdi(_selectedDate.month)} - İzinli Personeller',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
          ),
          const SizedBox(height: 16),

          _buildIzinlilerList(_selectedDate),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final daysInMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final firstDayOfWeek = DateTime(_currentMonth.year, _currentMonth.month, 1).weekday;

    List<Widget> gridItems = [];

    // Boş günler
    for (int i = 1; i < firstDayOfWeek; i++) {
      gridItems.add(const SizedBox(width: 36, height: 36));
    }

    // Ayın günleri
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(_currentMonth.year, _currentMonth.month, day);
      final isSelected = date.year == _selectedDate.year && date.month == _selectedDate.month && date.day == _selectedDate.day;
      final izinliSayisi = _getIzinlilerForDate(date).length;
      final isToday = date.year == DateTime.now().year && date.month == DateTime.now().month && date.day == DateTime.now().day;

      gridItems.add(
        GestureDetector(
          onTap: () => setState(() => _selectedDate = date),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.categoryOperasyon : Colors.transparent,
              shape: BoxShape.circle,
              border: isToday && !isSelected ? Border.all(color: AppColors.categoryOperasyon, width: 2) : null,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  day.toString(),
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                    fontSize: 14,
                  ),
                ),
                if (izinliSayisi > 0 && !isSelected)
                  Positioned(
                    bottom: 2,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.warning,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                if (izinliSayisi > 0 && isSelected)
                  Positioned(
                    bottom: 2,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 12,
      alignment: WrapAlignment.start,
      children: gridItems,
    );
  }

  Widget _buildIzinlilerList(DateTime date) {
    final izinliler = _getIzinlilerForDate(date);

    if (izinliler.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.bgPage,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight, width: 1, style: BorderStyle.solid),
        ),
        child: const Center(
          child: Text('Bu tarihte izinli personel bulunmuyor.', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
        ),
      );
    }

    return Column(
      children: izinliler.map((isim) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.categoryOperasyon.withOpacity(0.2),
                child: Text(isim[0], style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.categoryOperasyon)),
              ),
              const SizedBox(width: 16),
              Text(isim, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            ],
          ),
        );
      }).toList(),
    );
  }

  String _ayAdi(int month) {
    const aylar = ['', 'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran', 'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'];
    return aylar[month];
  }
}
