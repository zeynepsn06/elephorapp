import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import 'models/crm_model.dart';

class CrmAddScreen extends StatefulWidget {
  const CrmAddScreen({super.key});

  @override
  State<CrmAddScreen> createState() => _CrmAddScreenState();
}

class _CrmAddScreenState extends State<CrmAddScreen> {
  CrmCustomerType _type = CrmCustomerType.person;
  
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _companyNameCtrl = TextEditingController();
  
  final List<String> _selectedTags = [];
  final List<String> _availableTags = ['VIP', 'Potansiyel', 'Kurumsal', 'Aktif', 'Pasif'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final queryParams = GoRouterState.of(context).uri.queryParameters;
      if (queryParams['type'] == 'company') {
        setState(() {
          _type = CrmCustomerType.company;
        });
      }
    });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _addressCtrl.dispose();
    _companyNameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPerson = _type == CrmCustomerType.person;
    
    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        title: Text(
          isPerson ? 'Yeni Müşteri Ekle' : 'Yeni Firma Ekle',
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
          // İşlem Tipi (Müşteri/Firma)
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
                    onTap: () => setState(() => _type = CrmCustomerType.person),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isPerson ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: isPerson ? [
                          BoxShadow(color: AppColors.black900.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
                        ] : [],
                      ),
                      child: Center(
                        child: Text('Bireysel', style: TextStyle(
                          color: isPerson ? AppColors.categoryMusteri : AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        )),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _type = CrmCustomerType.company),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: !isPerson ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: !isPerson ? [
                          BoxShadow(color: AppColors.black900.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
                        ] : [],
                      ),
                      child: Center(
                        child: Text('Kurumsal', style: TextStyle(
                          color: !isPerson ? AppColors.categoryMusteri : AppColors.textSecondary,
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
            title: 'İletişim Bilgileri',
            child: Column(
              children: [
                _buildTextField(
                  controller: _nameCtrl,
                  hintText: isPerson ? 'Müşteri Adı Soyadı' : 'Firma Ünvanı',
                  icon: isPerson ? Icons.person_outline_rounded : Icons.domain_rounded,
                ),
                if (isPerson) ...[
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _companyNameCtrl,
                    hintText: 'Çalıştığı Firma (Opsiyonel)',
                    icon: Icons.business_center_outlined,
                  ),
                ],
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _phoneCtrl,
                  hintText: 'Telefon Numarası',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _emailCtrl,
                  hintText: 'E-posta Adresi',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _addressCtrl,
                  hintText: 'Açık Adres',
                  icon: Icons.location_on_outlined,
                  maxLines: 2,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          _FormSection(
            title: 'Etiketler',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availableTags.map((tag) {
                final isSelected = _selectedTags.contains(tag);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedTags.remove(tag);
                      } else {
                        _selectedTags.add(tag);
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.categoryMusteri : AppColors.bgPage,
                      border: Border.all(
                        color: isSelected ? AppColors.categoryMusteri : AppColors.borderLight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 40),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${isPerson ? 'Müşteri' : 'Firma'} başarıyla kaydedildi!'),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                context.pop();
              },
              icon: const Icon(Icons.check_rounded, size: 22),
              label: const Text('Kaydet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.categoryMusteri,
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
          borderSide: const BorderSide(color: AppColors.categoryMusteri, width: 2),
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
