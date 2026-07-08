import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../models/team_member_model.dart';
import '../../models/mini_app_model.dart';

class PermissionsScreen extends StatefulWidget {
  final String memberId;
  const PermissionsScreen({super.key, required this.memberId});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  late TeamMemberModel member;

  // Permission state per app
  final Map<String, Map<String, bool>> _permissions = {
    'vardiya': {
      'Kendi vardiyasını görsün': true,
      'Vardiya girişi yapabilsin': true,
      'Tüm ekip vardiyalarını görsün': false,
      'Vardiya düzenleyebilsin': false,
      'Rapor indirebilsin': false,
    },
    'odeme': {
      'Ödemeleri görsün': false,
      'Ödeme ekleyebilsin': false,
      'Ödeme düzenleyebilsin': false,
      'Ödeme silebilsin': false,
      'Finansal raporları görsün': false,
    },
    'rezervasyon': {
      'Rezervasyonları görsün': false,
      'Rezervasyon ekleyebilsin': false,
      'Rezervasyon düzenleyebilsin': false,
      'Rezervasyon iptal edebilsin': false,
      'Takvimi yönetebilsin': false,
    },
  };

  @override
  void initState() {
    super.initState();
    member = mockTeamMembers.firstWhere(
      (m) => m.id == widget.memberId,
      orElse: () => mockTeamMembers.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    final apps = [
      _AppPermGroup(
        appId: 'vardiya',
        name: 'Vardiya Takip',
        icon: Icons.schedule_rounded,
        color: AppColors.categoryPersonel,
      ),
      _AppPermGroup(
        appId: 'odeme',
        name: 'Ödeme Takibi',
        icon: Icons.account_balance_wallet_rounded,
        color: AppColors.categoryFinans,
      ),
      _AppPermGroup(
        appId: 'rezervasyon',
        name: 'Rezervasyon',
        icon: Icons.calendar_month_rounded,
        color: AppColors.categoryMusteri,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Yetki Yönetimi',
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Yetkiler başarıyla kaydedildi!'),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                context.pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryGreen,
                textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              child: const Text('Kaydet'),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Member header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.borderLight.withOpacity(0.5)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black900.withOpacity(0.03),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryGreen.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      member.initials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        member.email,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.info.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.info.withOpacity(0.2)),
                  ),
                  child: Text(
                    member.roleLabel,
                    style: const TextStyle(
                      color: AppColors.info,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          Text(
            'Uygulama Yetkileri',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Bu üyenin hangi uygulamalara erişebileceğini ve bu uygulamalarda hangi işlemleri yapabileceğini belirleyin.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),

          ...apps.map((app) => _AppPermissionSection(
                app: app,
                permissions: _permissions[app.appId]!,
                onChanged: (key, value) {
                  setState(() {
                    _permissions[app.appId]![key] = value;
                  });
                },
              )),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _AppPermGroup {
  final String appId;
  final String name;
  final IconData icon;
  final Color color;

  const _AppPermGroup({
    required this.appId,
    required this.name,
    required this.icon,
    required this.color,
  });
}

class _AppPermissionSection extends StatefulWidget {
  final _AppPermGroup app;
  final Map<String, bool> permissions;
  final Function(String, bool) onChanged;

  const _AppPermissionSection({
    required this.app,
    required this.permissions,
    required this.onChanged,
  });

  @override
  State<_AppPermissionSection> createState() => _AppPermissionSectionState();
}

class _AppPermissionSectionState extends State<_AppPermissionSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final enabledCount = widget.permissions.values.where((v) => v).length;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _expanded ? widget.app.color.withOpacity(0.3) : AppColors.borderLight.withOpacity(0.5),
            width: _expanded ? 1.5 : 1,
          ),
          boxShadow: [
            if (_expanded)
              BoxShadow(
                color: widget.app.color.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              )
            else
              BoxShadow(
                color: AppColors.black900.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              )
          ],
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () => setState(() => _expanded = !_expanded),
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: widget.app.color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(widget.app.icon, color: widget.app.color, size: 22),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.app.name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '$enabledCount / ${widget.permissions.length} yetki aktif',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: enabledCount > 0 ? widget.app.color : AppColors.textHint,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.gray50,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_expanded) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(height: 1, color: AppColors.borderLight.withOpacity(0.5)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Column(
                  children: widget.permissions.entries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              e.key,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: e.value ? AppColors.textPrimary : AppColors.textSecondary,
                                fontWeight: e.value ? FontWeight.w500 : FontWeight.normal,
                              ),
                            ),
                          ),
                          Switch(
                            value: e.value,
                            activeColor: Colors.white,
                            activeTrackColor: widget.app.color,
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: AppColors.gray300,
                            trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
                            onChanged: (v) => widget.onChanged(e.key, v),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

