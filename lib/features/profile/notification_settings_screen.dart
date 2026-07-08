import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _smsNotifications = false;
  bool _marketingEmails = false;

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
          'Bildirim Ayarları',
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
            Text(
              'Hangi konularda bildirim almak istediğinizi seçin. Bu ayarları istediğiniz zaman değiştirebilirsiniz.',
              style: TextStyle(
                fontSize: 13,
                color: context.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 32),

            _buildSectionTitle('Sistem Bildirimleri'),
            const SizedBox(height: 12),
            _buildSwitchTile(
              title: 'E-posta Bildirimleri',
              subtitle: 'Hesap aktiviteleri ve güvenlik uyarıları e-posta adresinize gönderilir.',
              value: _emailNotifications,
              onChanged: (val) => setState(() => _emailNotifications = val),
            ),
            const SizedBox(height: 12),
            _buildSwitchTile(
              title: 'Anlık Bildirimler (Push)',
              subtitle: 'Uygulama içi güncellemeler ve hatırlatmalar anında telefonunuza gelir.',
              value: _pushNotifications,
              onChanged: (val) => setState(() => _pushNotifications = val),
            ),
            const SizedBox(height: 12),
            _buildSwitchTile(
              title: 'SMS Bildirimleri',
              subtitle: 'Kritik uyarılar telefonunuza SMS olarak gönderilir.',
              value: _smsNotifications,
              onChanged: (val) => setState(() => _smsNotifications = val),
            ),

            const SizedBox(height: 32),

            _buildSectionTitle('Pazarlama & Promosyon'),
            const SizedBox(height: 12),
            _buildSwitchTile(
              title: 'Kampanya ve Fırsatlar',
              subtitle: 'Yeni özellikler, kampanyalar ve promosyonlar hakkında e-posta alın.',
              value: _marketingEmails,
              onChanged: (val) => setState(() => _marketingEmails = val),
            ),

            const SizedBox(height: 48),

            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text('Bildirim ayarları güncellendi.'), backgroundColor: context.success),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.textPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: Text(
                'Ayarları Kaydet',
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w800,
        color: context.textPrimary,
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderLight),
      ),
      child: Row(
        children: [
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
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: context.bgPage,
            activeTrackColor: context.textPrimary,
            inactiveThumbColor: context.textHint,
            inactiveTrackColor: context.iconBg,
          ),
        ],
      ),
    );
  }
}
