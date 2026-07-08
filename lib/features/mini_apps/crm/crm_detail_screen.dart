import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import 'models/crm_model.dart';

final _mockCustomer = CrmCustomer(
  id: 'c1',
  name: 'Ahmet Yılmaz',
  type: CrmCustomerType.person,
  phone: '+90 532 111 2233',
  email: 'ahmet@example.com',
  tags: ['VIP', 'Potansiyel'],
  companyName: 'Yılmaz Gıda',
  createdAt: DateTime.now(),
);

final _mockActivities = [
  CrmActivity(id: 'a1', customerId: 'c1', type: CrmActivityType.meeting, title: 'İlk Tanışma Toplantısı', description: 'Şirket ihtiyaçları konuşuldu.', date: DateTime.now().subtract(const Duration(days: 5))),
  CrmActivity(id: 'a2', customerId: 'c1', type: CrmActivityType.offer, title: 'Yıllık Bakım Teklifi', description: 'Teklif PDF olarak iletildi.', date: DateTime.now().subtract(const Duration(days: 3)), amount: 12500, status: 'Bekliyor'),
  CrmActivity(id: 'a3', customerId: 'c1', type: CrmActivityType.note, title: 'Önemli Not', description: 'Sadece sabah saatlerinde müsait oluyor.', date: DateTime.now().subtract(const Duration(days: 1))),
];

class CrmDetailScreen extends StatefulWidget {
  final String id;
  const CrmDetailScreen({super.key, required this.id});

  @override
  State<CrmDetailScreen> createState() => _CrmDetailScreenState();
}

class _CrmDetailScreenState extends State<CrmDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Gerçekte API'den veya stateten gelecek. Şimdilik mock veriyoruz.
    final customer = _mockCustomer; 
    
    return Scaffold(
      backgroundColor: AppColors.bgPage,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: AppColors.bgPage,
              surfaceTintColor: Colors.transparent,
              pinned: true,
              expandedHeight: 280,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.textPrimary),
                onPressed: () => context.pop(),
              ),
              title: Text(
                'Müşteri Profili',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz_rounded, color: AppColors.textPrimary),
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.only(top: 100, left: 24, right: 24),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.categoryMusteri.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          customer.name.substring(0, 1),
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppColors.categoryMusteri,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        customer.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        customer.companyName.isNotEmpty ? customer.companyName : customer.phone,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildActionCircle(Icons.call_rounded, Colors.green, 'Ara'),
                          const SizedBox(width: 24),
                          _buildActionCircle(Icons.message_rounded, Colors.greenAccent.shade700, 'WhatsApp'),
                          const SizedBox(width: 24),
                          _buildActionCircle(Icons.email_rounded, Colors.blue, 'E-Posta'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.categoryMusteri,
                indicatorWeight: 3,
                labelColor: AppColors.categoryMusteri,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                tabs: const [
                  Tab(text: 'Görüşmeler'),
                  Tab(text: 'Teklifler'),
                  Tab(text: 'Satışlar'),
                  Tab(text: 'Notlar'),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _ActivityList(activities: _mockActivities.where((a) => a.type == CrmActivityType.meeting).toList()),
            _ActivityList(activities: _mockActivities.where((a) => a.type == CrmActivityType.offer).toList()),
            _ActivityList(activities: _mockActivities.where((a) => a.type == CrmActivityType.sale).toList()),
            _ActivityList(activities: _mockActivities.where((a) => a.type == CrmActivityType.note).toList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Bulunulan sekmeye göre tür gönderelim
          String type = 'Meeting';
          if (_tabController.index == 1) type = 'Offer';
          if (_tabController.index == 2) type = 'Sale';
          if (_tabController.index == 3) type = 'Note';
          
          context.push('/mini-apps/crm/add-note/${customer.id}?type=$type');
        },
        backgroundColor: AppColors.categoryMusteri,
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildActionCircle(IconData icon, Color color, String actionName) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$actionName açılıyor...')));
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
        ],
      ),
    );
  }
}

class _ActivityList extends StatelessWidget {
  final List<CrmActivity> activities;

  const _ActivityList({required this.activities});

  @override
  Widget build(BuildContext context) {
    if (activities.isEmpty) {
      return const Center(
        child: Text(
          'Henüz kayıt yok.',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 15, fontWeight: FontWeight.w500),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: activities.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (ctx, i) {
        final a = activities[i];
        
        IconData icon;
        Color color;
        if (a.type == CrmActivityType.meeting) { icon = Icons.handshake_rounded; color = AppColors.categoryOperasyon; }
        else if (a.type == CrmActivityType.offer) { icon = Icons.description_rounded; color = AppColors.warning; }
        else if (a.type == CrmActivityType.sale) { icon = Icons.monetization_on_rounded; color = AppColors.success; }
        else { icon = Icons.notes_rounded; color = AppColors.textHint; }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            a.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        Text(
                          '${a.date.day}/${a.date.month}',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppColors.textHint,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      a.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                    ),
                    if (a.amount > 0) ...[
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₺${a.amount.toStringAsFixed(0)}',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: color,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          if (a.status.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.bgPage,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                a.status,
                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textSecondary),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
