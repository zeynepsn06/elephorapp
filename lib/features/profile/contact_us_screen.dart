import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

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
          'Bize Ulaşın',
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
            Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: context.iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.support_agent_rounded, color: context.textPrimary, size: 48),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Size nasıl yardımcı olabiliriz?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: context.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sorularınız, önerileriniz veya karşılaştığınız sorunlar için bizimle iletişime geçebilirsiniz. Ekibimiz en kısa sürede size dönüş yapacaktır.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: context.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),

            _buildContactMethod(
              context,
              icon: Icons.chat_bubble_outline_rounded,
              title: 'Canlı Destek',
              subtitle: 'Hemen şimdi sohbet başlatın',
              actionText: 'Sohbet Başlat',
              onTap: () {},
            ),
            const SizedBox(height: 16),
            _buildContactMethod(
              context,
              icon: Icons.mail_outline_rounded,
              title: 'E-posta Gönder',
              subtitle: 'destek@elephor.com',
              actionText: 'E-posta Yaz',
              onTap: () {},
            ),
            const SizedBox(height: 16),
            _buildContactMethod(
              context,
              icon: Icons.phone_outlined,
              title: 'Müşteri Hizmetleri',
              subtitle: '0850 123 45 67',
              actionText: 'Hemen Ara',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactMethod(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionText,
    required VoidCallback onTap,
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: context.textPrimary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: context.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: context.textHint,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(
              backgroundColor: context.textPrimary.withOpacity(0.1),
              foregroundColor: context.textPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(actionText, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
