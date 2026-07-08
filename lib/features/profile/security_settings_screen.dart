import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class SecuritySettingsScreen extends StatelessWidget {
  const SecuritySettingsScreen({super.key});

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
          'Güvenlik',
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
            // Password Section
            _buildSectionTitle(context, 'Giriş Güvenliği'),
            const SizedBox(height: 12),
            _buildActionTile(
              context,
              icon: Icons.password_rounded,
              title: 'Şifreyi Değiştir',
              subtitle: 'Hesap şifrenizi güncelleyin.',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Şifre değiştirme sayfası açılacak.')),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildActionTile(
              context,
              icon: Icons.fingerprint_rounded,
              title: 'Biyometrik Giriş',
              subtitle: 'Face ID veya Touch ID ile güvenli giriş yapın.',
              trailing: Switch(
                value: true,
                onChanged: (val) {},
                activeColor: context.bgPage,
                activeTrackColor: context.textPrimary,
              ),
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _buildActionTile(
              context,
              icon: Icons.security_rounded,
              title: 'İki Adımlı Doğrulama (2FA)',
              subtitle: 'Hesabınıza ekstra bir güvenlik katmanı ekleyin.',
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: context.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Aktif',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: context.success),
                ),
              ),
              onTap: () {},
            ),

            const SizedBox(height: 32),

            // Devices Section
            _buildSectionTitle(context, 'Cihaz Yönetimi'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.bgCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.phone_iphone_rounded, color: context.textPrimary, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'iPhone 13 Pro (Şu anki cihaz)',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: context.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'İstanbul, Türkiye • Aktif',
                              style: TextStyle(
                                fontSize: 12,
                                color: context.success,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(height: 1),
                  ),
                  Row(
                    children: [
                      Icon(Icons.laptop_mac_rounded, color: context.textHint, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'MacBook Pro 14"',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: context.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'İstanbul, Türkiye • Son görülme: 2 saat önce',
                              style: TextStyle(
                                fontSize: 12,
                                color: context.textHint,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Çıkış Yap', style: TextStyle(color: context.danger, fontSize: 12, fontWeight: FontWeight.w600)),
                      )
                    ],
                  ),
                ],
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

  Widget _buildActionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.bgCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.borderLight),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: context.iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: context.textPrimary, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: context.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: context.textHint,
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing else Icon(Icons.chevron_right_rounded, size: 20, color: context.textHint),
          ],
        ),
      ),
    );
  }
}
