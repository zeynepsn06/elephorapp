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

final _mockMovements = [
  StokMovement(id: 'm1', productId: '2', productName: 'Saç Boyası (Kumral)', type: StokMovementType.outStock, quantity: 2, date: DateTime.now().subtract(const Duration(hours: 1)), note: 'Müşteri İşlemi'),
  StokMovement(id: 'm2', productId: '1', productName: 'Premium Şampuan 500ml', type: StokMovementType.inStock, quantity: 20, date: DateTime.now().subtract(const Duration(days: 1)), note: 'Toptancı Teslimatı'),
  StokMovement(id: 'm3', productId: '3', productName: 'Tıraş Köpüğü 200ml', type: StokMovementType.outStock, quantity: 5, date: DateTime.now().subtract(const Duration(days: 2))),
];

class StokHomeScreen extends StatelessWidget {
  const StokHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int totalProductsCount = _mockProducts.length;
    int totalStockSum = _mockProducts.fold(0, (sum, p) => sum + p.currentStock);
    final criticalProducts = _mockProducts.where((p) => p.isCritical).toList();
    int criticalCount = criticalProducts.length;

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
              'Stok Takibi',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Barkod Okuyucu Açılıyor...')));
                  },
                  icon: const Icon(Icons.qr_code_scanner_rounded, color: AppColors.textPrimary),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Depo Özetleri
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          context,
                          'Toplam Ürün Çeşidi',
                          totalProductsCount.toString(),
                          Icons.category_rounded,
                          AppColors.categoryOperasyon,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildSummaryCard(
                          context,
                          'Depodaki Ürün',
                          totalStockSum.toString(),
                          Icons.inventory_2_rounded,
                          AppColors.categoryOperasyon,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (criticalCount > 0)
                    GestureDetector(
                      onTap: () => context.push('/mini-apps/stok/reports'),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.danger.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.danger.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.danger.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.warning_amber_rounded, color: AppColors.danger),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kritik Stok Uyarısı',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          color: AppColors.danger,
                                          fontWeight: FontWeight.w800,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '$criticalCount ürün kritik seviyenin altında! Tükenmek üzere.',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: AppColors.danger.withOpacity(0.8),
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right_rounded, color: AppColors.danger),
                          ],
                        ),
                      ),
                    ),
                  
                  const SizedBox(height: 32),
                  
                  // Hızlı İşlemler Grid
                  Text(
                    'İşlemler',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _ActionButton(
                        icon: Icons.add_box_rounded,
                        label: 'Ürün Ekle',
                        color: AppColors.categoryOperasyon,
                        onTap: () => context.push('/mini-apps/stok/add-product'),
                      ),
                      _ActionButton(
                        icon: Icons.move_to_inbox_rounded,
                        label: 'Stok Girişi',
                        color: AppColors.success,
                        onTap: () => context.push('/mini-apps/stok/movement?type=in'),
                      ),
                      _ActionButton(
                        icon: Icons.outbox_rounded,
                        label: 'Stok Çıkışı',
                        color: AppColors.danger,
                        onTap: () => context.push('/mini-apps/stok/movement?type=out'),
                      ),
                      _ActionButton(
                        icon: Icons.warning_rounded,
                        label: 'Kritik Stoklar',
                        color: AppColors.warning,
                        onTap: () => context.push('/mini-apps/stok/reports?tab=1'),
                      ),
                      _ActionButton(
                        icon: Icons.pie_chart_rounded,
                        label: 'Stok Raporu',
                        color: AppColors.categoryOperasyon,
                        onTap: () => context.push('/mini-apps/stok/reports'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Son Hareketler
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Son Hareketler',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.3,
                            ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Tümü', style: TextStyle(color: AppColors.categoryOperasyon, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ..._mockMovements.map((m) => _MovementCard(movement: m)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, String title, String value, IconData icon, Color color) {
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
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
          ),
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
        width: (MediaQuery.of(context).size.width - 60) / 2,
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
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MovementCard extends StatelessWidget {
  final StokMovement movement;

  const _MovementCard({required this.movement});

  @override
  Widget build(BuildContext context) {
    final isIn = movement.type == StokMovementType.inStock;
    final color = isIn ? AppColors.success : AppColors.danger;
    
    return Container(
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
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isIn ? Icons.add_rounded : Icons.remove_rounded,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movement.productName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  isIn ? 'Stok Girişi' : 'Stok Çıkışı',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isIn ? '+' : '-'}${movement.quantity} Adet',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                '${movement.date.day}/${movement.date.month}',
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
