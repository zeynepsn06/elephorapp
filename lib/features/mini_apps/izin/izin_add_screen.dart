import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';

class IzinAddScreen extends StatefulWidget {
  const IzinAddScreen({super.key});

  @override
  State<IzinAddScreen> createState() => _IzinAddScreenState();
}

class _IzinAddScreenState extends State<IzinAddScreen> {
  final _aciklamaCtrl = TextEditingController();
  
  String? _selectedPersonel;
  final List<String> _personeller = ['Ahmet Yılmaz', 'Zeynep Kaya', 'Ali Vefa', 'Ayşe Demir'];
  
  String? _selectedIzinTuru;
  final List<String> _izinTurleri = ['Yıllık İzin', 'Mazeret İzni', 'Sağlık İzni', 'Ücretsiz İzin', 'Babalık/Doğum İzni'];
  
  DateTime? _baslangicTarihi;
  DateTime? _bitisTarihi;

  @override
  void dispose() {
    _aciklamaCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.categoryOperasyon,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _baslangicTarihi = picked.start;
        _bitisTarihi = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int gunSayisi = 0;
    if (_baslangicTarihi != null && _bitisTarihi != null) {
      gunSayisi = _bitisTarihi!.difference(_baslangicTarihi!).inDays + 1;
    }

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Yeni İzin Talebi',
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
          _FormSection(
            title: 'Personel & İzin Türü',
            child: Column(
              children: [
                _buildDropdown(
                  value: _selectedPersonel,
                  items: _personeller,
                  hint: 'Personel Seçiniz',
                  onChanged: (val) => setState(() => _selectedPersonel = val),
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  value: _selectedIzinTuru,
                  items: _izinTurleri,
                  hint: 'İzin Türü Seçiniz',
                  onChanged: (val) => setState(() => _selectedIzinTuru = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          _FormSection(
            title: 'Tarih Aralığı',
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickDateRange,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.bgPage,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.borderLight.withOpacity(0.5)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.date_range_rounded, color: AppColors.categoryOperasyon, size: 22),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            _baslangicTarihi != null && _bitisTarihi != null
                                ? '${_baslangicTarihi!.day}.${_baslangicTarihi!.month}.${_baslangicTarihi!.year} - ${_bitisTarihi!.day}.${_bitisTarihi!.month}.${_bitisTarihi!.year}'
                                : 'Tarih aralığı seçiniz',
                            style: TextStyle(
                              color: _baslangicTarihi != null ? AppColors.textPrimary : AppColors.textHint,
                              fontSize: 15,
                              fontWeight: _baslangicTarihi != null ? FontWeight.w600 : FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (gunSayisi > 0) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.categoryOperasyon.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.info_outline_rounded, color: AppColors.categoryOperasyon, size: 18),
                        const SizedBox(width: 8),
                        Text('Toplam İzin Süresi: $gunSayisi Gün', style: const TextStyle(color: AppColors.categoryOperasyon, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),

          _FormSection(
            title: 'Açıklama',
            child: TextFormField(
              controller: _aciklamaCtrl,
              maxLines: 4,
              style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary, fontSize: 15),
              decoration: InputDecoration(
                hintText: 'İzin talebi için açıklama giriniz...',
                hintStyle: const TextStyle(color: AppColors.textHint, fontWeight: FontWeight.w500),
                filled: true,
                fillColor: AppColors.bgPage,
                contentPadding: const EdgeInsets.all(16),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: AppColors.borderLight.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: AppColors.borderLight.withOpacity(0.5))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.categoryOperasyon, width: 2)),
              ),
            ),
          ),
          const SizedBox(height: 40),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_selectedPersonel == null || _selectedIzinTuru == null || _baslangicTarihi == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lütfen tüm alanları doldurun!'), backgroundColor: AppColors.danger));
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('İzin talebi başarıyla oluşturuldu! Onay sürecine gönderildi.'),
                    backgroundColor: AppColors.categoryOperasyon,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                context.pop();
              },
              icon: const Icon(Icons.send_rounded, size: 22),
              label: const Text('Talebi Gönder', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.categoryOperasyon,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({required String? value, required List<String> items, required String hint, required Function(String?) onChanged}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.bgPage,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight.withOpacity(0.5)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint, style: const TextStyle(color: AppColors.textHint, fontWeight: FontWeight.w500)),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textHint),
          dropdownColor: AppColors.bgCard,
          items: items.map((i) => DropdownMenuItem(value: i, child: Text(i, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary)))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _FormSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: AppColors.black900.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.3)),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}
