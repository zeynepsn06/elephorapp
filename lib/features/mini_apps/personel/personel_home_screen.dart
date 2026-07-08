import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import 'models/personel_model.dart';

final _mockPersonelList = [
  Personel(id: 'p1', name: 'Ayşe Demir', title: 'Müşteri Temsilcisi', department: 'Satış', phone: '0533 111 2233', email: 'ayse@sirket.com', salary: 35000, startDate: DateTime(2022, 5, 10)),
  Personel(id: 'p2', name: 'Mehmet Yılmaz', title: 'Yazılım Geliştirici', department: 'IT', phone: '0532 222 3344', email: 'mehmet@sirket.com', salary: 55000, startDate: DateTime(2021, 3, 15)),
  Personel(id: 'p3', name: 'Elif Şahin', title: 'İnsan Kaynakları Uzmanı', department: 'İK', phone: '0555 333 4455', email: 'elif@sirket.com', salary: 42000, startDate: DateTime(2023, 1, 5)),
  Personel(id: 'p4', name: 'Burak Kaya', title: 'Muhasebe Sorumlusu', department: 'Finans', phone: '0544 444 5566', email: 'burak@sirket.com', salary: 38000, startDate: DateTime(2020, 8, 20), isActive: false, endDate: DateTime(2023, 12, 31)),
];

class PersonelHomeScreen extends StatefulWidget {
  const PersonelHomeScreen({super.key});

  @override
  State<PersonelHomeScreen> createState() => _PersonelHomeScreenState();
}

class _PersonelHomeScreenState extends State<PersonelHomeScreen> {
  String _searchQuery = '';
  String _selectedDept = 'Tümü';
  final List<String> _departments = ['Tümü', 'Satış', 'IT', 'İK', 'Finans', 'Operasyon'];

  @override
  Widget build(BuildContext context) {
    final filteredPersonel = _mockPersonelList.where((p) {
      final matchesSearch = p.name.toLowerCase().contains(_searchQuery.toLowerCase()) || 
                            p.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesDept = _selectedDept == 'Tümü' || p.department == _selectedDept;
      return matchesSearch && matchesDept;
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
              'Personel Yönetimi',
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
                  // İstatistik Kartları
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          title: 'Toplam Çalışan',
                          value: '${_mockPersonelList.where((p) => p.isActive).length}',
                          icon: Icons.groups_rounded,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _StatCard(
                          title: 'Departman',
                          value: '${_departments.length - 1}',
                          icon: Icons.account_tree_rounded,
                          color: AppColors.categoryOperasyon,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Hızlı İşlemler
                  Row(
                    children: [
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.person_add_alt_1_rounded,
                          label: 'Personel Ekle',
                          color: Colors.deepPurple,
                          onTap: () => context.push('/mini-apps/personel/add'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.domain_add_rounded,
                          label: 'Departman Ekle',
                          color: Colors.deepPurple,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Departman ekleme formu açılıyor...')));
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Arama ve Filtre
                  TextField(
                    onChanged: (v) => setState(() => _searchQuery = v),
                    decoration: InputDecoration(
                      hintText: 'Personel adı veya pozisyon ara...',
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
                        borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Departman Filtresi
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _departments.map((dept) {
                        final isSelected = _selectedDept == dept;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedDept = dept),
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.deepPurple : AppColors.bgCard,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: isSelected ? Colors.deepPurple : AppColors.borderLight),
                            ),
                            child: Text(
                              dept,
                              style: TextStyle(
                                color: isSelected ? Colors.white : AppColors.textSecondary,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  Text(
                    'Çalışan Listesi',
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
                  final personel = filteredPersonel[index];
                  return _PersonelCard(personel: personel);
                },
                childCount: filteredPersonel.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(20),
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
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
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

class _PersonelCard extends StatelessWidget {
  final Personel personel;

  const _PersonelCard({required this.personel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/mini-apps/personel/detail/${personel.id}'),
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
            Stack(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      personel.name.substring(0, 1),
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: personel.isActive ? AppColors.success : AppColors.danger,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.bgCard, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    personel.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          decoration: personel.isActive ? null : TextDecoration.lineThrough,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    personel.title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.bgPage,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      personel.department,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textHint,
                      ),
                    ),
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
}
