import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class BusinessSettingsScreen extends StatelessWidget {
  const BusinessSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgPage,
      appBar: AppBar(
        backgroundColor: context.bgPage,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: context.textPrimary, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'İşletme Ayarları',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: context.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            // Business Logo
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: context.iconBg,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: context.borderLight, width: 2),
                    ),
                    child: Center(
                      child: Icon(Icons.store_rounded, color: context.textPrimary, size: 40),
                    ),
                  ),
                  Positioned(
                    bottom: -4,
                    right: -4,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: context.textPrimary,
                        shape: BoxShape.circle,
                        border: Border.all(color: context.bgPage, width: 3),
                      ),
                      child: Icon(Icons.edit_rounded, color: context.bgPage, size: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            _buildSectionTitle(context, 'Temel Bilgiler'),
            const SizedBox(height: 12),
            _buildTextField(context, label: 'İşletme Adı', value: 'Eren Kafe'),
            const SizedBox(height: 16),
            _buildTextField(context, label: 'Sektör / Kategori', value: 'Cafe & Restoran', icon: Icons.keyboard_arrow_down_rounded),
            
            const SizedBox(height: 32),
            
            _buildSectionTitle(context, 'İletişim ve Konum'),
            const SizedBox(height: 12),
            _buildTextField(context, label: 'Telefon Numarası', value: '+90 (212) 555 44 33'),
            const SizedBox(height: 16),
            _buildTextField(context, label: 'E-posta', value: 'info@erenkafe.com'),
            const SizedBox(height: 16),
            _buildTextField(context, label: 'Açık Adres', value: 'Kadıköy Moda Cd. No: 123\nİstanbul, Türkiye', maxLines: 2),

            const SizedBox(height: 32),
            
            _buildSectionTitle(context, 'Finansal Bilgiler'),
            const SizedBox(height: 12),
            _buildTextField(context, label: 'Vergi Dairesi', value: 'Kadıköy V.D.'),
            const SizedBox(height: 16),
            _buildTextField(context, label: 'Vergi Numarası', value: '123 456 7890'),

            const SizedBox(height: 48),

            // Save Button
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text('İşletme ayarları başarıyla kaydedildi.'), backgroundColor: context.success),
                );
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.textPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: Text(
                'Değişiklikleri Kaydet',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: context.bgPage,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Delete Business Button
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text('Bu işlem için yetkiniz bulunmuyor.'), backgroundColor: context.danger),
                );
              },
              child: Text(
                'İşletmeyi Kapat',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: context.danger,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w800,
        color: context.textPrimary,
      ),
    );
  }

  Widget _buildTextField(BuildContext context, {required String label, required String value, IconData? icon, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: context.textHint,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: context.bgCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.borderInput),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  maxLines: maxLines,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: context.textPrimary,
                    height: 1.4,
                  ),
                ),
              ),
              if (icon != null)
                Icon(icon, color: context.textHint, size: 20),
            ],
          ),
        ),
      ],
    );
  }
}
