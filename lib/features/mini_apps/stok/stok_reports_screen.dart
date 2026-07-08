import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import 'models/stok_model.dart';

final _mockProducts = [
  StokProduct(id: '1', name: 'Premium Şampuan 500ml', category: 'Kozmetik', barcode: '8691234567890', currentStock: 45, criticalLimit: 10),
  StokProduct(id: '2', name: 'Saç Boyası (Kumral)', category: 'Boya', barcode: '8691234567891', currentStock: 8, criticalLimit: 15),
  StokProduct(id: '3', name: 'Tıraş Köpüğü 200ml', category: 'Sarf Malzeme', barcode: '8691234567892', currentStock: 3, criticalLimit: 10),
  StokProduct(id: '4', name: 'Keratin Bakım Seti', category: 'Kozmetik', barcode: '8691234567893', currentStock: 20, criticalLimit: 5),
  StokProduct(id: '5', name: 'Saç Spreyi Ekstra Sert', category: 'Sarf Malzeme', barcode: '8691234567894', currentStock: 4, criticalLimit: 10),
];

class StokReportsScreen extends StatefulWidget {
  const StokReportsScreen({super.key});

  @override
  State<StokReportsScreen> createState() => _StokReportsScreenState();
}

class _StokReportsScreenState extends State<StokReportsScreen> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final queryParams = GoRouterState.of(context).uri.queryParameters;
      if (queryParams['tab'] == '1') {
        setState(() => _selectedTab = 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final displayProducts = _selectedTab == 0
        ? _mockProducts
        : _mockProducts.where((p) => p.isCritical).toList();

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Stok Durumu',
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.bgPage,
              border: Border(bottom: BorderSide(color: AppColors.borderLight.withOpacity(0.5))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _selectedTab == 0 ? AppColors.categoryOperasyon : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text('Tüm Ürünler', style: TextStyle(
                          color: _selectedTab == 0 ? Colors.white : AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        )),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _selectedTab == 1 ? AppColors.warning : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text('Kritik Stoklar', style: TextStyle(
                          color: _selectedTab == 1 ? AppColors.textPrimary : AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: displayProducts.isEmpty
                ? Center(
                    child: Text(
                      _selectedTab == 1 ? 'Kritik seviyede ürün yok. Harika!' : 'Hiç ürün bulunamadı.',
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 16),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(24),
                    itemCount: displayProducts.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (ctx, i) {
                      final product = displayProducts[i];
                      return _ProductCard(product: product);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final StokProduct product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final isDanger = product.isCritical;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDanger ? AppColors.danger.withOpacity(0.5) : AppColors.borderLight,
          width: isDanger ? 1.5 : 1,
        ),
        boxShadow: isDanger ? [
          BoxShadow(
            color: AppColors.danger.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ] : [],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDanger ? AppColors.danger.withOpacity(0.1) : AppColors.categoryOperasyon.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              isDanger ? Icons.warning_rounded : Icons.inventory_2_rounded,
              color: isDanger ? AppColors.danger : AppColors.categoryOperasyon,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  product.category,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${product.currentStock} Adet',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isDanger ? AppColors.danger : AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'Kritik: ${product.criticalLimit}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.textHint,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
