import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import 'models/crm_model.dart';

final _mockCustomers = [
  CrmCustomer(id: 'c1', name: 'Ahmet Yılmaz', type: CrmCustomerType.person, phone: '+90 532 111 2233', email: 'ahmet@example.com', tags: ['VIP', 'Potansiyel'], companyName: 'Yılmaz Gıda', createdAt: DateTime.now()),
  CrmCustomer(id: 'c2', name: 'ABC Teknoloji A.Ş.', type: CrmCustomerType.company, phone: '+90 212 333 4455', email: 'info@abcteknoloji.com', tags: ['Kurumsal', 'Aktif'], address: 'Levent, İstanbul', createdAt: DateTime.now().subtract(const Duration(days: 2))),
  CrmCustomer(id: 'c3', name: 'Zeynep Kaya', type: CrmCustomerType.person, phone: '+90 533 444 5566', email: 'zeynep@example.com', tags: ['Yeni'], createdAt: DateTime.now().subtract(const Duration(days: 5))),
  CrmCustomer(id: 'c4', name: 'Mavi Reklam Ajansı', type: CrmCustomerType.company, phone: '+90 216 777 8899', email: 'hello@mavireklam.com', tags: ['Kurumsal', 'İptal'], createdAt: DateTime.now().subtract(const Duration(days: 15))),
];

class CrmHomeScreen extends StatefulWidget {
  const CrmHomeScreen({super.key});

  @override
  State<CrmHomeScreen> createState() => _CrmHomeScreenState();
}

class _CrmHomeScreenState extends State<CrmHomeScreen> {
  String _searchQuery = '';
  
  @override
  Widget build(BuildContext context) {
    final filteredCustomers = _mockCustomers.where((c) {
      return c.name.toLowerCase().contains(_searchQuery.toLowerCase()) || 
             c.tags.any((t) => t.toLowerCase().contains(_searchQuery.toLowerCase()));
    }).toList();

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
            title: Text(
              'Müşteri Yönetimi',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
            ),
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hızlı İşlemler
                  Row(
                    children: [
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.person_add_alt_1_rounded,
                          label: 'Müşteri Ekle',
                          color: AppColors.categoryMusteri,
                          onTap: () => context.push('/mini-apps/crm/add?type=person'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.domain_add_rounded,
                          label: 'Firma Ekle',
                          color: AppColors.categoryMusteri,
                          onTap: () => context.push('/mini-apps/crm/add?type=company'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Arama Kutusu
                  TextField(
                    onChanged: (v) => setState(() => _searchQuery = v),
                    decoration: InputDecoration(
                      hintText: 'İsim, firma veya etiket ara...',
                      hintStyle: const TextStyle(color: AppColors.textHint, fontWeight: FontWeight.w500),
                      prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textHint, size: 22),
                      filled: true,
                      fillColor: AppColors.bgCard,
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
                  ),
                  const SizedBox(height: 24),
                  
                  Text(
                    'Kişiler ve Firmalar',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final customer = filteredCustomers[index];
                  return _CustomerCard(customer: customer);
                },
                childCount: filteredCustomers.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [
            BoxShadow(
              color: AppColors.black900.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomerCard extends StatelessWidget {
  final CrmCustomer customer;

  const _CustomerCard({required this.customer});

  @override
  Widget build(BuildContext context) {
    final isCompany = customer.type == CrmCustomerType.company;
    
    return GestureDetector(
      onTap: () => context.push('/mini-apps/crm/detail/${customer.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.categoryMusteri.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isCompany ? Icons.domain_rounded : Icons.person_rounded,
                color: AppColors.categoryMusteri,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (customer.companyName.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      customer.companyName,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: customer.tags.map((tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getTagColor(tag).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: _getTagColor(tag),
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
          ],
        ),
      ),
    );
  }
  
  Color _getTagColor(String tag) {
    if (tag.toLowerCase() == 'vip') return AppColors.warning; // Sarı/Turuncu
    if (tag.toLowerCase() == 'kurumsal') return AppColors.categoryOperasyon;
    if (tag.toLowerCase() == 'potansiyel') return AppColors.success;
    if (tag.toLowerCase() == 'iptal') return AppColors.danger;
    return AppColors.categoryMusteri;
  }
}
