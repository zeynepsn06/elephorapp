import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import 'models/stok_model.dart';

class StokMovementScreen extends StatefulWidget {
  const StokMovementScreen({super.key});

  @override
  State<StokMovementScreen> createState() => _StokMovementScreenState();
}

class _StokMovementScreenState extends State<StokMovementScreen> {
  StokMovementType _type = StokMovementType.inStock;
  String _selectedProduct = 'Premium Şampuan 500ml';
  final _quantityCtrl = TextEditingController(text: '1');
  final _noteCtrl = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  final _products = [
    'Premium Şampuan 500ml',
    'Saç Boyası (Kumral)',
    'Tıraş Köpüğü 200ml',
    'Keratin Bakım Seti',
    'Saç Spreyi Ekstra Sert'
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final queryParams = GoRouterState.of(context).uri.queryParameters;
      if (queryParams['type'] == 'out') {
        setState(() {
          _type = StokMovementType.outStock;
        });
      }
    });
  }

  @override
  void dispose() {
    _quantityCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Stok Hareketi',
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
          // İşlem Tipi
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
                    onTap: () => setState(() => _type = StokMovementType.inStock),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _type == StokMovementType.inStock ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: _type == StokMovementType.inStock ? [
                          BoxShadow(color: AppColors.black900.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
                        ] : [],
                      ),
                      child: Center(
                        child: Text('Stok Girişi', style: TextStyle(
                          color: _type == StokMovementType.inStock ? AppColors.success : AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        )),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _type = StokMovementType.outStock),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _type == StokMovementType.outStock ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: _type == StokMovementType.outStock ? [
                          BoxShadow(color: AppColors.black900.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
                        ] : [],
                      ),
                      child: Center(
                        child: Text('Stok Çıkışı', style: TextStyle(
                          color: _type == StokMovementType.outStock ? AppColors.danger : AppColors.textSecondary,
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
            title: 'Hareket Detayları',
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedProduct,
                  onChanged: (v) => setState(() => _selectedProduct = v!),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary),
                  style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary, fontSize: 15),
                  isExpanded: true,
                  decoration: InputDecoration(
                    hintText: 'Ürün Seçin',
                    hintStyle: const TextStyle(color: AppColors.textHint, fontWeight: FontWeight.w500),
                    prefixIcon: const Icon(Icons.inventory_2_outlined, color: AppColors.textHint, size: 22),
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
                      borderSide: BorderSide(
                        color: _type == StokMovementType.inStock ? AppColors.success : AppColors.danger,
                        width: 2,
                      ),
                    ),
                  ),
                  items: _products
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _quantityCtrl,
                  hintText: 'Miktar',
                  icon: Icons.numbers_rounded,
                  keyboardType: TextInputType.number,
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
                  controller: _noteCtrl,
                  hintText: 'Açıklama (Örn: Toptancı girişi, iade vb.)',
                  icon: Icons.notes_rounded,
                  maxLines: 2,
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
                    content: Text('${_type == StokMovementType.inStock ? 'Giriş' : 'Çıkış'} başarıyla kaydedildi!'),
                    backgroundColor: _type == StokMovementType.inStock ? AppColors.success : AppColors.danger,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                context.pop();
              },
              icon: const Icon(Icons.check_rounded, size: 22),
              label: const Text('Kaydet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                backgroundColor: _type == StokMovementType.inStock ? AppColors.success : AppColors.danger,
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
    final focusColor = _type == StokMovementType.inStock ? AppColors.success : AppColors.danger;
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
