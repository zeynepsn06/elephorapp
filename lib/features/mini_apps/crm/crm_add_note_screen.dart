import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import 'models/crm_model.dart';

class CrmAddNoteScreen extends StatefulWidget {
  final String customerId;
  final String type; // 'Note', 'Meeting', 'Offer', 'Sale'
  const CrmAddNoteScreen({super.key, required this.customerId, required this.type});

  @override
  State<CrmAddNoteScreen> createState() => _CrmAddNoteScreenState();
}

class _CrmAddNoteScreenState extends State<CrmAddNoteScreen> {
  late CrmActivityType _type;
  
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.type == 'Meeting') _type = CrmActivityType.meeting;
    else if (widget.type == 'Offer') _type = CrmActivityType.offer;
    else if (widget.type == 'Sale') _type = CrmActivityType.sale;
    else _type = CrmActivityType.note;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String pageTitle = 'Not Ekle';
    Color primaryColor = AppColors.textHint;
    
    if (_type == CrmActivityType.meeting) {
      pageTitle = 'Görüşme Ekle';
      primaryColor = AppColors.categoryOperasyon;
    } else if (_type == CrmActivityType.offer) {
      pageTitle = 'Teklif Ekle';
      primaryColor = AppColors.warning;
    } else if (_type == CrmActivityType.sale) {
      pageTitle = 'Satış Ekle';
      primaryColor = AppColors.success;
    }

    final isFinancial = _type == CrmActivityType.offer || _type == CrmActivityType.sale;

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        title: Text(
          pageTitle,
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
          // Tip Seçici
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.borderLight.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTypeTab('Görüşme', CrmActivityType.meeting, AppColors.categoryOperasyon),
                  _buildTypeTab('Teklif', CrmActivityType.offer, AppColors.warning),
                  _buildTypeTab('Satış', CrmActivityType.sale, AppColors.success),
                  _buildTypeTab('Not', CrmActivityType.note, AppColors.textHint),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          _FormSection(
            title: 'Detaylar',
            child: Column(
              children: [
                _buildTextField(
                  controller: _titleCtrl,
                  hintText: 'Başlık (Örn: Tanışma Toplantısı)',
                  icon: Icons.title_rounded,
                  focusColor: primaryColor,
                ),
                const SizedBox(height: 16),
                
                GestureDetector(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate ?? DateTime.now(),
                      firstDate: DateTime.now().subtract(const Duration(days: 365)),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) setState(() => _selectedDate = picked);
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
                        const Icon(Icons.calendar_today_outlined,
                            color: AppColors.textHint, size: 22),
                        const SizedBox(width: 16),
                        Text(
                          _selectedDate != null
                              ? '${_selectedDate!.day}.${_selectedDate!.month}.${_selectedDate!.year}'
                              : 'Tarih seçin',
                          style: TextStyle(
                            color: _selectedDate != null
                                ? AppColors.textPrimary
                                : AppColors.textHint,
                            fontSize: 15,
                            fontWeight: _selectedDate != null ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                if (isFinancial) ...[
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _amountCtrl,
                    hintText: 'Tutar (₺)',
                    icon: Icons.monetization_on_outlined,
                    keyboardType: TextInputType.number,
                    focusColor: primaryColor,
                  ),
                ],
                
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _descCtrl,
                  hintText: 'Açıklama veya Görüşme Notları',
                  icon: Icons.notes_rounded,
                  maxLines: 4,
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Başarıyla eklendi!'),
                    backgroundColor: primaryColor != AppColors.textHint ? primaryColor : AppColors.categoryMusteri,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                context.pop();
              },
              icon: const Icon(Icons.check_rounded, size: 22),
              label: const Text('Kaydet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor != AppColors.textHint ? primaryColor : AppColors.categoryMusteri,
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

  Widget _buildTypeTab(String label, CrmActivityType type, Color activeColor) {
    final isSelected = _type == type;
    return GestureDetector(
      onTap: () => setState(() => _type = type),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected ? [
            BoxShadow(color: AppColors.black900.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
          ] : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? activeColor : AppColors.textSecondary,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
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
          borderSide: BorderSide(color: focusColor != AppColors.textHint ? focusColor : AppColors.categoryMusteri, width: 2),
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
