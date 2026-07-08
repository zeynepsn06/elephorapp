import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});

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
          'Hesap Bilgileri',
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
            // Profile Picture
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: context.iconBg,
                      shape: BoxShape.circle,
                      border: Border.all(color: context.borderLight, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        'EA',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: context.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: context.textPrimary,
                        shape: BoxShape.circle,
                        border: Border.all(color: context.bgPage, width: 3),
                      ),
                      child: Icon(Icons.camera_alt_rounded, color: context.bgPage, size: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Form Fields
            _buildSectionTitle(context, 'Kişisel Bilgiler'),
            const SizedBox(height: 12),
            _buildTextField(context, label: 'Ad Soyad', value: 'Eren Arslan'),
            const SizedBox(height: 16),
            _buildTextField(context, label: 'Doğum Tarihi', value: '14 Mayıs 1992', icon: Icons.calendar_today_rounded),
            
            const SizedBox(height: 32),
            
            _buildSectionTitle(context, 'İletişim Bilgileri'),
            const SizedBox(height: 12),
            _buildTextField(context, label: 'E-posta Adresi', value: 'erenarslan@example.com'),
            const SizedBox(height: 16),
            _buildTextField(context, label: 'Telefon Numarası', value: '+90 (555) 123 45 67'),
            
            const SizedBox(height: 48),

            // Save Button
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text('Bilgiler kaydedildi.'), backgroundColor: context.success),
                );
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

  Widget _buildTextField(BuildContext context, {required String label, required String value, IconData? icon}) {
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
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: context.textPrimary,
                  ),
                ),
              ),
              if (icon != null)
                Icon(icon, color: context.textHint, size: 18),
            ],
          ),
        ),
      ],
    );
  }
}
