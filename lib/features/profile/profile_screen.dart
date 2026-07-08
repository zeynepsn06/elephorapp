import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // ── Header ───────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Profil',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Hesabınızı ve işletmenizi yönetin.',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Profile Card ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.bgCard,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.bgButtonSecondary,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border, width: 1.5),
                      ),
                      child: const Center(
                        child: Text(
                          'EA',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Eren Asan',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'erenasan@email.com',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textHint,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.bgPage,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Yönetici',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Profili Düzenle
                    GestureDetector(
                      onTap: () => context.push('/account-info'),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Profili Düzenle',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(width: 2),
                          Icon(Icons.chevron_right_rounded, size: 16, color: AppColors.textSecondary),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ── Pro Banner ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1C1C1E), Color(0xFF2C2C2E)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.workspace_premium_rounded, color: AppColors.premiumGold, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Elephor+ Pro',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: AppColors.premiumGold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Pro plan ile tüm özelliklere erişin.',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.textDisabled,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.push('/subscription'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.premiumGold,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Planı İncele',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.premiumDark,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── İşletmem ─────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'İşletmem',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.push('/business-settings'),
                        child: const Row(
                          children: [
                            Text(
                              'Tümünü Gör',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textHint,
                              ),
                            ),
                            SizedBox(width: 2),
                            Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.textHint),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Business card
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      color: AppColors.bgCard,
                      border: Border(bottom: BorderSide(color: AppColors.borderLight)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.bgButtonSecondary,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.store_rounded, color: AppColors.textPrimary, size: 22),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Eren Kafe',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Cafe & Restoran',
                                style: TextStyle(fontSize: 11, color: AppColors.textHint),
                              ),
                              SizedBox(height: 2),
                              Text(
                                '12 Çalışan  •  3 Şube',
                                style: TextStyle(fontSize: 11, color: AppColors.textDisabled),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/business-settings'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.border),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  'İşletme Ayarları',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(width: 2),
                                Icon(Icons.chevron_right_rounded, size: 14, color: AppColors.textPrimary),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Hesap Yönetimi ───────────────────────────────────────
            _buildSectionHeader(context, 'Hesap Yönetimi'),
            const SizedBox(height: 8),
            _buildListTile(context, 
              icon: Icons.person_outline_rounded,
              title: 'Hesap Bilgileri',
              subtitle: 'Kişisel bilgileriniz ve iletişim ayarları.',
              onTap: () => context.push('/account-info'),
            ),
            _buildListTile(context, 
              icon: Icons.people_outline_rounded,
              title: 'Ekip & Yetkiler',
              subtitle: 'Ekip üyelerinizi ve yetki düzeylerini yönetin.',
              onTap: () => context.push('/team'),
            ),
            _buildListTile(context, 
              icon: Icons.workspace_premium_outlined,
              title: 'Abonelik & Faturalama',
              subtitle: 'Planınızı ve faturalandırma bilgilerinizi yönetin.',
              onTap: () => context.push('/subscription'),
            ),
            _buildListTile(context, 
              icon: Icons.credit_card_outlined,
              title: 'Ödeme Yöntemleri',
              subtitle: 'Kayıtlı kartlarınız ve ödeme yöntemleriniz.',
              onTap: () => context.push('/payment-methods'),
            ),
            _buildListTile(context, 
              icon: Icons.notifications_none_rounded,
              title: 'Bildirim Ayarları',
              subtitle: 'Bildirim tercihlerinizi özelleştirin.',
              onTap: () => context.push('/notification-settings'),
            ),
            _buildListTile(context, 
              icon: Icons.lock_outline_rounded,
              title: 'Güvenlik',
              subtitle: 'Şifre, giriş ve güvenlik ayarlarınızı yönetin.',
              onTap: () => context.push('/security-settings'),
            ),

            const SizedBox(height: 24),

            // ── Destek & Diğer ───────────────────────────────────────
            _buildSectionHeader(context, 'Destek & Diğer'),
            const SizedBox(height: 8),
            _buildListTile(context, 
              icon: Icons.help_outline_rounded,
              title: 'Yardım Merkezi',
              subtitle: 'Sık sorulan sorular ve rehberlere göz atın.',
              onTap: () => context.push('/help-center'),
            ),
            _buildListTile(context, 
              icon: Icons.chat_bubble_outline_rounded,
              title: 'Bize Ulaşın',
              subtitle: 'Destek ekibimizle iletişime geçin.',
              onTap: () => context.push('/contact-us'),
            ),
            _buildSimpleTile(context, 
              icon: Icons.shield_outlined,
              title: 'Gizlilik Politikası',
              onTap: () => context.push('/privacy-policy'),
            ),
            _buildSimpleTile(context, 
              icon: Icons.description_outlined,
              title: 'Kullanım Koşulları',
              onTap: () => context.push('/terms-of-use'),
            ),
            _buildSimpleTileWithValue(context, 
              icon: Icons.info_outline_rounded,
              title: 'Uygulama Hakkında',
              value: 'Elephor+ sürüm 1.0.0',
              onTap: () => context.push('/about-app'),
            ),

            const SizedBox(height: 20),

            // ── Çıkış Yap ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Çıkış yapılıyor...')),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: context.danger.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout_rounded, color: context.danger, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Çıkış Yap',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: context.danger,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  // ── Section header builder ─────────────────────────────────────────────
  static Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: context.textPrimary,
        ),
      ),
    );
  }

  // ── List tile with subtitle ────────────────────────────────────────────
  static Widget _buildListTile(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
        decoration: BoxDecoration(
          color: context.bgCard,
          border: Border(bottom: BorderSide(color: context.borderLight)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: context.textPrimary, size: 20),
            ),
            const SizedBox(width: 14),
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
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: context.textHint,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, size: 18, color: context.textHint),
          ],
        ),
      ),
    );
  }

  // ── Simple tile (no subtitle) ──────────────────────────────────────────
  static Widget _buildSimpleTile(BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
        decoration: BoxDecoration(
          color: context.bgCard,
          border: Border(bottom: BorderSide(color: context.borderLight)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: context.textPrimary, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: context.textPrimary,
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded, size: 18, color: context.textHint),
          ],
        ),
      ),
    );
  }

  // ── Simple tile with right value ───────────────────────────────────────
  static Widget _buildSimpleTileWithValue(BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
        decoration: BoxDecoration(
          color: context.bgCard,
          border: Border(bottom: BorderSide(color: context.borderLight)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: context.textPrimary, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: context.textPrimary,
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 11,
                color: context.textHint,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right_rounded, size: 18, color: context.textHint),
          ],
        ),
      ),
    );
  }
}
