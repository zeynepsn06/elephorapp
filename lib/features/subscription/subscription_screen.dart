import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  String _selected = 'Pro';
  bool _annual = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPage,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.bgPage,
            surfaceTintColor: Colors.transparent,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.textPrimary),
              onPressed: () => context.pop(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                    decoration: BoxDecoration(
                      gradient: AppColors.premiumGradient,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.premiumGold.withOpacity(0.3),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withOpacity(0.3)),
                          ),
                          child: const Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 48),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Elephor+ Pro',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'İşletmenizin potansiyelini maksimuma çıkarın',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Annual / Monthly toggle
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        _BillingToggle(
                          label: 'Yıllık',
                          subtitle: '%20 Tasarruf',
                          selected: _annual,
                          onTap: () => setState(() => _annual = true),
                        ),
                        _BillingToggle(
                          label: 'Aylık',
                          subtitle: '',
                          selected: !_annual,
                          onTap: () => setState(() => _annual = false),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Plan cards
                  _PlanCard(
                    name: 'Ücretsiz',
                    price: '0',
                    period: 'sonsuza kadar',
                    description: 'Temel ihtiyaçlar için',
                    features: [
                      '1 Mini Uygulama',
                      '1 Ekip / 2 Kullanıcı',
                      'Temel raporlar',
                    ],
                    isSelected: _selected == 'Ücretsiz',
                    isCurrentPlan: true,
                    onSelect: () => setState(() => _selected = 'Ücretsiz'),
                  ),

                  const SizedBox(height: 16),

                  _PlanCard(
                    name: 'Pro',
                    price: _annual ? '299' : '349',
                    period: _annual ? '/ ay (yıllık)' : '/ ay',
                    description: 'Büyüyen işletmeler için',
                    features: [
                      '5 Mini Uygulama',
                      '10 Kullanıcı',
                      'Gelişmiş analitik raporları',
                      'Anlık bildirimler',
                      'Öncelikli destek (7/24)',
                    ],
                    isSelected: _selected == 'Pro',
                    isPremium: true,
                    recommended: true,
                    onSelect: () => setState(() => _selected = 'Pro'),
                  ),

                  const SizedBox(height: 16),

                  _PlanCard(
                    name: 'Kurumsal',
                    price: _annual ? '799' : '950',
                    period: _annual ? '/ ay (yıllık)' : '/ ay',
                    description: 'Sınırları kaldırmak için',
                    features: [
                      'Sınırsız Mini Uygulama',
                      'Sınırsız Kullanıcı',
                      'Özel modül talebi',
                      'API erişimi & Entegrasyon',
                      'Özel müşteri temsilcisi',
                    ],
                    isSelected: _selected == 'Kurumsal',
                    isEnterprise: true,
                    onSelect: () => setState(() => _selected = 'Kurumsal'),
                  ),

                  const SizedBox(height: 32),

                  if (_selected != 'Ücretsiz')
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: _selected == 'Pro'
                          ? Container(
                              decoration: BoxDecoration(
                                gradient: AppColors.premiumGradient,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.premiumGold.withOpacity(0.4),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  )
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                ),
                                child: Text(
                                  'Pro Planına Geç — ${_annual ? "299" : "349"} ₺/ay',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          : FilledButton(
                              onPressed: () {},
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.black900,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                              child: Text(
                                'Kurumsal Plana Geç — ${_annual ? "799" : "950"} ₺/ay',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            ),
                    ),

                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'İstediğiniz zaman, hiçbir kesinti olmadan iptal edebilirsiniz.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textHint,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BillingToggle extends StatelessWidget {
  final String label;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _BillingToggle({
    required this.label,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: AppColors.black900.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    )
                  ]
                : [],
          ),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  fontSize: 15,
                  color: selected ? AppColors.textPrimary : AppColors.textSecondary,
                ),
              ),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String name;
  final String price;
  final String period;
  final String description;
  final List<String> features;
  final bool isSelected;
  final bool isCurrentPlan;
  final bool isPremium;
  final bool isEnterprise;
  final bool recommended;
  final VoidCallback onSelect;

  const _PlanCard({
    required this.name,
    required this.price,
    required this.period,
    required this.description,
    required this.features,
    required this.isSelected,
    this.isCurrentPlan = false,
    this.isPremium = false,
    this.isEnterprise = false,
    this.recommended = false,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected 
        ? (isPremium ? AppColors.premiumGold : (isEnterprise ? AppColors.black900 : AppColors.primaryGreen))
        : AppColors.borderLight.withOpacity(0.5);

    return GestureDetector(
      onTap: onSelect,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: borderColor.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  )
                ]
              : [
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
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: isPremium && isSelected ? AppColors.premiumGold : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textHint,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (recommended)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: AppColors.premiumGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'ÖNERİLEN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                if (isCurrentPlan && !recommended)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'MEVCUT PLAN',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                if (isSelected)
                  const SizedBox(width: 12),
                if (isSelected)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: borderColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_rounded, color: Colors.white, size: 16),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₺$price',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    period,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Divider(color: AppColors.borderLight.withOpacity(0.5)),
            const SizedBox(height: 16),
            ...features.map(
              (f) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: isPremium ? AppColors.premiumGold.withOpacity(0.1) : AppColors.primaryGreen.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_rounded,
                        size: 14,
                        color: isPremium ? AppColors.premiumGold : AppColors.primaryGreen,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        f,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

