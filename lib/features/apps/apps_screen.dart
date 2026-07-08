import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../state/app_state.dart';
import '../../models/mini_app_model.dart';
import '../../shared/widgets/mini_app_card.dart';

class AppsScreen extends StatefulWidget {
  const AppsScreen({super.key});

  @override
  State<AppsScreen> createState() => _AppsScreenState();
}

class _AppsScreenState extends State<AppsScreen> {
  String _selectedCategory = 'Popüler';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  static const List<_CategoryItem> _categories = [
    _CategoryItem(label: 'Popüler', icon: Icons.star_rounded),
    _CategoryItem(label: 'Personel', icon: Icons.people_outline_rounded),
    _CategoryItem(label: 'Finans', icon: Icons.account_balance_wallet_outlined),
    _CategoryItem(label: 'Müşteri', icon: Icons.person_outline_rounded),
    _CategoryItem(label: 'Operasyon', icon: Icons.settings_outlined),
    _CategoryItem(label: 'Raporlama', icon: Icons.bar_chart_rounded),
    _CategoryItem(label: 'Yakında', icon: Icons.access_time_rounded),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    List<MiniAppModel> filteredApps;
    if (_searchQuery.isNotEmpty) {
      filteredApps = appState.allApps
          .where((a) =>
              a.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              a.description.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    } else {
      filteredApps = appState.getAppsByCategory(_selectedCategory);
    }

    // Popular = added apps for top horizontal section
    final popularApps = appState.allApps
        .where((a) => a.status != MiniAppStatus.comingSoon)
        .take(6)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      body: CustomScrollView(
        slivers: [
          // ── Header ───────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Uygulamalar',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: AppColors.black900,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            'İşletmen için ihtiyacın olan tüm araçlar.',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Search button
                    GestureDetector(
                      onTap: () => _showSearch(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                        decoration: BoxDecoration(
                          color: AppColors.gray100,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.search_rounded, size: 16, color: AppColors.textHint),
                            SizedBox(width: 6),
                            Text(
                              'Uygulama ara...',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textHint,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Category Tabs ─────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 16),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final cat = _categories[i];
                      final isSelected = cat.label == _selectedCategory;
                      return GestureDetector(
                        onTap: () => setState(() {
                          _selectedCategory = cat.label;
                          _searchQuery = '';
                          _searchController.clear();
                        }),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.black900 : Colors.transparent,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: isSelected ? AppColors.black900 : AppColors.border,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                cat.icon,
                                size: 13,
                                color: isSelected ? Colors.white : AppColors.textSecondary,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                cat.label,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? Colors.white : AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),

          // ── Popüler Uygulamalar ───────────────────────────────────────
          if (_searchQuery.isEmpty && _selectedCategory == 'Popüler') ...[
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Popüler Uygulamalar',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: AppColors.black900,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Row(
                            children: [
                              Text(
                                'Tümünü Gör',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              SizedBox(width: 2),
                              Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.textSecondary),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Horizontal Popular Cards
                  SizedBox(
                    height: 210,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: popularApps.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, i) {
                        final app = popularApps[i];
                        return _PopularAppCard(
                          app: app,
                          onTap: () => context.push('/apps/detail/${app.id}'),
                          onAction: () {
                            if (app.status == MiniAppStatus.notAdded) {
                              appState.addApp(app.id);
                            } else if (app.status == MiniAppStatus.added) {
                              context.push(app.route);
                            }
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Tüm Uygulamalar header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tüm Uygulamalar',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: AppColors.black900,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.border),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.tune_rounded, size: 14, color: AppColors.textSecondary),
                                SizedBox(width: 4),
                                Text(
                                  'Filtrele',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],

          // ── "Tüm Uygulamalar" header for non-Popular tabs ─────────────
          if (_searchQuery.isEmpty && _selectedCategory != 'Popüler')
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedCategory,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: AppColors.black900,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.tune_rounded, size: 14, color: AppColors.textSecondary),
                          SizedBox(width: 4),
                          Text(
                            'Filtrele',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // ── App List ──────────────────────────────────────────────────
          if (filteredApps.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  mainAxisExtent: 64, // Exact height for each row
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, i) => _AllAppsGridTile(
                    index: i + 1,
                    app: filteredApps[i],
                    onTap: () => context.push('/apps/detail/${filteredApps[i].id}'),
                    onAction: () {
                      if (filteredApps[i].status == MiniAppStatus.notAdded) {
                        appState.addApp(filteredApps[i].id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${filteredApps[i].name} eklendi'),
                            backgroundColor: AppColors.black900,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                        );
                      } else if (filteredApps[i].status == MiniAppStatus.added) {
                        context.push(filteredApps[i].route);
                      }
                    },
                  ),
                  childCount: filteredApps.length,
                ),
              ),
            ),

          // ── Empty State ───────────────────────────────────────────────
          if (filteredApps.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(60),
                child: Column(
                  children: [
                    const Icon(Icons.search_off_rounded, size: 48, color: AppColors.textHint),
                    const SizedBox(height: 12),
                    const Text(
                      'Sonuç bulunamadı',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '"$_searchQuery" için uygulama bulunamadı',
                      style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: _AppSearchDelegate(context.read<AppState>(), (app) {
        context.push('/apps/detail/${app.id}');
      }),
    );
  }
}

// ── Category Item Model ─────────────────────────────────────────────────────
class _CategoryItem {
  final String label;
  final IconData icon;
  const _CategoryItem({required this.label, required this.icon});
}

// ── Popular Card (horizontal scroll) ───────────────────────────────────────
class _PopularAppCard extends StatelessWidget {
  final MiniAppModel app;
  final VoidCallback onTap;
  final VoidCallback onAction;

  const _PopularAppCard({
    required this.app,
    required this.onTap,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(AppConstants.radiusCard),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon — always black
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.black900,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(app.icon, color: Colors.white, size: 24),
            ),
            const Spacer(),
            // Name
            Text(
              app.name,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: AppColors.black900,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 3),
            // Description
            Text(
              app.shortDescription,
              style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            // Rating + Action button row
            Row(
              children: [
                const Icon(Icons.star_rounded, size: 12, color: Color(0xFFF59E0B)),
                const SizedBox(width: 3),
                Text(
                  app.rating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSecondary,
                  ),
                ),
                const Spacer(),
                _buildActionChip(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionChip(BuildContext context) {
    switch (app.status) {
      case MiniAppStatus.added:
        return GestureDetector(
          onTap: onAction,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.black900,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('Aç', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
          ),
        );
      case MiniAppStatus.premium:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            gradient: AppColors.premiumGradient,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text('Pro', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
        );
      case MiniAppStatus.comingSoon:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.gray100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text('Yakında', style: TextStyle(color: AppColors.textHint, fontSize: 10, fontWeight: FontWeight.w600)),
        );
      default:
        return GestureDetector(
          onTap: onAction,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.black900,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('Aç', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
          ),
        );
    }
  }
}

// ── All Apps Grid Tile ──────────────────────────────────────────────────────
class _AllAppsGridTile extends StatelessWidget {
  final MiniAppModel app;
  final int index;
  final VoidCallback onTap;
  final VoidCallback onAction;

  const _AllAppsGridTile({
    required this.app,
    required this.index,
    required this.onTap,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent, // No borders or shadows like the screenshot
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Index Number
            SizedBox(
              width: 28,
              child: Text(
                '$index',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            // Icon
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.black900, // Black background for icon
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(app.icon, color: Colors.white, size: 26),
            ),
            const SizedBox(width: 12),
            // Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    app.name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black900,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    app.shortDescription, // Displays category-like string
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Search Delegate ─────────────────────────────────────────────────────────
class _AppSearchDelegate extends SearchDelegate<MiniAppModel?> {
  final AppState appState;
  final void Function(MiniAppModel) onSelected;

  _AppSearchDelegate(this.appState, this.onSelected);

  @override
  String get searchFieldLabel => 'Uygulama ara...';

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => query = '',
        ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => _buildList(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildList(context);

  Widget _buildList(BuildContext context) {
    final results = appState.allApps
        .where((a) =>
            a.name.toLowerCase().contains(query.toLowerCase()) ||
            a.shortDescription.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return const Center(child: Text('Uygulama bulunamadı'));
    }

    return ListView.builder(
      itemCount: results.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, i) {
        final app = results[i];
        return ListTile(
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.black900,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(app.icon, color: Colors.white, size: 22),
          ),
          title: Text(app.name, style: const TextStyle(fontWeight: FontWeight.w700)),
          subtitle: Text(app.shortDescription, maxLines: 1, overflow: TextOverflow.ellipsis),
          onTap: () {
            close(context, app);
            onSelected(app);
          },
        );
      },
    );
  }
}
