import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import 'models/gelir_gider_model.dart';

class GelirGiderAddScreen extends StatefulWidget {
  const GelirGiderAddScreen({super.key});

  @override
  State<GelirGiderAddScreen> createState() => _GelirGiderAddScreenState();
}

class _GelirGiderAddScreenState extends State<GelirGiderAddScreen> {
  final _amountCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  DateTime? _selectedDate = DateTime.now();
  String _selectedCategory = 'Diğer';
  TransactionType _type = TransactionType.income;

  final _incomeCategories = ['Satışlar', 'Hizmetler', 'Yatırım', 'Kira', 'Diğer'];
  final _expenseCategories = ['Malzeme', 'Kira', 'Fatura', 'Maaş', 'Vergi', 'Diğer'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final queryParams = GoRouterState.of(context).uri.queryParameters;
      if (queryParams['type'] == 'expense') {
        setState(() {
          _type = TransactionType.expense;
        });
      }
    });
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeCategories = _type == TransactionType.income ? _incomeCategories : _expenseCategories;
    if (!activeCategories.contains(_selectedCategory)) {
      _selectedCategory = activeCategories.first;
    }

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Yeni İşlem Ekle',
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
          // İşlem Tipi (Gelir/Gider)
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
                    onTap: () => setState(() => _type = TransactionType.income),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _type == TransactionType.income ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: _type == TransactionType.income ? [
                          BoxShadow(color: AppColors.black900.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
                        ] : [],
                      ),
                      child: Center(
                        child: Text('Gelir', style: TextStyle(
                          color: _type == TransactionType.income ? AppColors.success : AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        )),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _type = TransactionType.expense),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _type == TransactionType.expense ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: _type == TransactionType.expense ? [
                          BoxShadow(color: AppColors.black900.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
                        ] : [],
                      ),
                      child: Center(
                        child: Text('Gider', style: TextStyle(
                          color: _type == TransactionType.expense ? AppColors.danger : AppColors.textSecondary,
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
                _buildTextField(
                  controller: _amountCtrl,
                  hintText: 'Tutar (₺)',
                  icon: Icons.monetization_on_outlined,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  onChanged: (v) => setState(() => _selectedCategory = v!),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary),
                  style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary, fontSize: 15),
                  decoration: InputDecoration(
                    hintText: 'Kategori Seçin',
                    hintStyle: const TextStyle(color: AppColors.textHint, fontWeight: FontWeight.w500),
                    prefixIcon: const Icon(Icons.category_outlined, color: AppColors.textHint, size: 22),
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
                      borderSide: const BorderSide(color: AppColors.categoryFinans, width: 2),
                    ),
                  ),
                  items: activeCategories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
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
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _descCtrl,
                  hintText: 'Açıklama (isteğe bağlı)',
                  icon: Icons.notes_rounded,
                  maxLines: 3,
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
                    content: Text('${_type == TransactionType.income ? 'Gelir' : 'Gider'} başarıyla eklendi!'),
                    backgroundColor: _type == TransactionType.income ? AppColors.success : AppColors.danger,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                context.pop();
              },
              icon: const Icon(Icons.check_rounded, size: 22),
              label: const Text('Kaydet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                backgroundColor: _type == TransactionType.income ? AppColors.success : AppColors.danger,
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
          borderSide: const BorderSide(color: AppColors.categoryFinans, width: 2),
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
