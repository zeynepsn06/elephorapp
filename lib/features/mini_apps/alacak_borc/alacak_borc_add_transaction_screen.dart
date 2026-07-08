import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import 'models/alacak_borc_model.dart';

class AlacakBorcAddTransactionScreen extends StatefulWidget {
  final String type; // 'alacak' or 'borc'
  const AlacakBorcAddTransactionScreen({super.key, required this.type});

  @override
  State<AlacakBorcAddTransactionScreen> createState() => _AlacakBorcAddTransactionScreenState();
}

class _AlacakBorcAddTransactionScreenState extends State<AlacakBorcAddTransactionScreen> {
  late TransactionType _type;
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  
  String? _selectedCari;
  final List<String> _cariler = ['Ahmet Yılmaz', 'Mavi Reklam', 'ABC Teknoloji'];
  
  DateTime? _vadeTarihi = DateTime.now().add(const Duration(days: 7));

  @override
  void initState() {
    super.initState();
    _type = widget.type == 'borc' ? TransactionType.borc : TransactionType.alacak;
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAlacak = _type == TransactionType.alacak;
    final primaryColor = isAlacak ? AppColors.success : AppColors.danger;

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        title: Text(
          isAlacak ? 'Yeni Alacak Ekle' : 'Yeni Borç Ekle',
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
          // Tip Seçici (Toggle)
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.borderLight.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _type = TransactionType.alacak),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isAlacak ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: isAlacak ? [BoxShadow(color: AppColors.black900.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))] : [],
                      ),
                      child: Center(
                        child: Text('Alacak Ekle', style: TextStyle(
                          color: isAlacak ? AppColors.success : AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        )),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _type = TransactionType.borc),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: !isAlacak ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: !isAlacak ? [BoxShadow(color: AppColors.black900.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))] : [],
                      ),
                      child: Center(
                        child: Text('Borç Ekle', style: TextStyle(
                          color: !isAlacak ? AppColors.danger : AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          _FormSection(
            title: 'İşlem Detayları',
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.bgPage,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderLight.withOpacity(0.5)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCari,
                      hint: const Text('Cari Seçiniz', style: TextStyle(color: AppColors.textHint, fontWeight: FontWeight.w500)),
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textHint),
                      dropdownColor: AppColors.bgCard,
                      items: _cariler.map((c) {
                        return DropdownMenuItem(
                          value: c,
                          child: Text(c, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() => _selectedCari = val);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _amountCtrl,
                  hintText: 'Tutar (₺)',
                  icon: Icons.monetization_on_outlined,
                  keyboardType: TextInputType.number,
                  focusColor: primaryColor,
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _vadeTarihi ?? DateTime.now(),
                      firstDate: DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) setState(() => _vadeTarihi = picked);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.bgPage,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.borderLight.withOpacity(0.5)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined, color: AppColors.textHint, size: 22),
                        const SizedBox(width: 16),
                        Text(
                          _vadeTarihi != null
                              ? 'Vade: ${_vadeTarihi!.day}.${_vadeTarihi!.month}.${_vadeTarihi!.year}'
                              : 'Vade Tarihi Seçiniz',
                          style: TextStyle(
                            color: _vadeTarihi != null ? AppColors.textPrimary : AppColors.textHint,
                            fontSize: 15,
                            fontWeight: _vadeTarihi != null ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _noteCtrl,
                  hintText: 'Açıklama (Opsiyonel)',
                  icon: Icons.notes_rounded,
                  maxLines: 3,
                  focusColor: primaryColor,
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_selectedCari == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lütfen bir cari seçiniz!'), backgroundColor: AppColors.danger));
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isAlacak ? 'Alacak başarıyla kaydedildi!' : 'Borç başarıyla kaydedildi!'),
                    backgroundColor: primaryColor,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                context.pop();
              },
              icon: const Icon(Icons.check_rounded, size: 22),
              label: const Text('Kaydet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    required Color focusColor,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary, fontSize: 15),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.textHint, fontWeight: FontWeight.w500),
        prefixIcon: Padding(
          padding: EdgeInsets.only(bottom: maxLines > 1 ? (maxLines * 12.0) : 0),
          child: Icon(icon, color: AppColors.textHint, size: 22),
        ),
        filled: true,
        fillColor: AppColors.bgPage,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.borderLight.withOpacity(0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.borderLight.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: focusColor, width: 2),
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
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}
