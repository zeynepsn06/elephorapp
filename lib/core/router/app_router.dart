import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/widgets/main_scaffold.dart';
import '../../features/home/home_screen.dart';
import '../../features/apps/apps_screen.dart';
import '../../features/apps/app_detail_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/profile/placeholder_screen.dart';
import '../../features/profile/account_info_screen.dart';
import '../../features/profile/notification_settings_screen.dart';
import '../../features/profile/security_settings_screen.dart';
import '../../features/profile/help_center_screen.dart';
import '../../features/profile/contact_us_screen.dart';
import '../../features/profile/privacy_policy_screen.dart';
import '../../features/profile/terms_of_use_screen.dart';
import '../../features/profile/about_app_screen.dart';
import '../../features/profile/business_settings_screen.dart';
import '../../features/notifications/notifications_screen.dart';
import '../../features/team/team_screen.dart';
import '../../features/team/permissions_screen.dart';
import '../../features/subscription/subscription_screen.dart';
import '../../features/profile/payment_methods_screen.dart';
import '../../features/mini_apps/vardiya/vardiya_home_screen.dart';
import '../../features/mini_apps/vardiya/vardiya_plan_screen.dart';
import '../../features/mini_apps/vardiya/vardiya_list_screen.dart';
import '../../features/mini_apps/vardiya/vardiya_report_screen.dart';
import '../../features/mini_apps/odeme/odeme_home_screen.dart';
import '../../features/mini_apps/odeme/odeme_list_screen.dart';
import '../../features/mini_apps/odeme/odeme_add_screen.dart';
import '../../features/mini_apps/rezervasyon/rezervasyon_home_screen.dart';
import '../../features/mini_apps/rezervasyon/rezervasyon_list_screen.dart';
import '../../features/mini_apps/rezervasyon/rezervasyon_add_screen.dart';
import '../../features/mini_apps/gorev/gorev_home_screen.dart';
import '../../features/mini_apps/gorev/gorev_kanban_screen.dart';
import '../../features/mini_apps/gorev/gorev_list_screen.dart';
import '../../features/mini_apps/gorev/gorev_completed_screen.dart';
import '../../features/mini_apps/gelir_gider/gelir_gider_home_screen.dart';
import '../../features/mini_apps/gelir_gider/gelir_gider_add_screen.dart';
import '../../features/mini_apps/gelir_gider/gelir_gider_reports_screen.dart';
import '../../features/mini_apps/stok/stok_home_screen.dart';
import '../../features/mini_apps/stok/stok_add_product_screen.dart';
import '../../features/mini_apps/stok/stok_movement_screen.dart';
import '../../features/mini_apps/stok/stok_reports_screen.dart';
import '../../features/mini_apps/crm/crm_home_screen.dart';
import '../../features/mini_apps/crm/crm_add_screen.dart';
import '../../features/mini_apps/crm/crm_detail_screen.dart';
import '../../features/mini_apps/crm/crm_add_note_screen.dart';
import '../../features/mini_apps/personel/personel_home_screen.dart';
import '../../features/mini_apps/personel/personel_add_screen.dart';
import '../../features/mini_apps/personel/personel_detail_screen.dart';
import '../../features/mini_apps/alacak_borc/alacak_borc_home_screen.dart';
import '../../features/mini_apps/alacak_borc/alacak_borc_add_transaction_screen.dart';
import '../../features/mini_apps/alacak_borc/alacak_borc_add_cari_screen.dart';
import '../../features/mini_apps/alacak_borc/alacak_borc_reports_screen.dart';
import '../../features/mini_apps/izin/izin_home_screen.dart';
import '../../features/mini_apps/izin/izin_add_screen.dart';
import '../../features/mini_apps/izin/izin_calendar_screen.dart';
import '../../features/mini_apps/izin/izin_reports_screen.dart';
import '../../features/mini_apps/siparis/siparis_home_screen.dart';
import '../../features/mini_apps/siparis/siparis_add_screen.dart';
import '../../features/mini_apps/siparis/siparis_detail_screen.dart';
import '../../features/mini_apps/siparis/siparis_reports_screen.dart';


final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/apps',
          builder: (context, state) => const AppsScreen(),
          routes: [
            GoRoute(
              path: 'detail/:appId',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) => AppDetailScreen(
                appId: state.pathParameters['appId']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/notifications',
          builder: (context, state) => const NotificationsScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
    // Full screen routes (no bottom nav)
    GoRoute(
      path: '/team',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const TeamScreen(),
      routes: [
        GoRoute(
          path: 'permissions/:memberId',
          builder: (context, state) => PermissionsScreen(
            memberId: state.pathParameters['memberId']!,
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/subscription',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SubscriptionScreen(),
    ),
    GoRoute(
      path: '/payment-methods',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const PaymentMethodsScreen(),
    ),
    GoRoute(
      path: '/placeholder/:title',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => PlaceholderScreen(
        title: state.pathParameters['title']!,
      ),
    ),
    GoRoute(
      path: '/account-info',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const AccountInfoScreen(),
    ),
    GoRoute(
      path: '/business-settings',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const BusinessSettingsScreen(),
    ),
    GoRoute(
      path: '/notification-settings',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const NotificationSettingsScreen(),
    ),
    GoRoute(
      path: '/security-settings',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SecuritySettingsScreen(),
    ),
    GoRoute(
      path: '/help-center',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const HelpCenterScreen(),
    ),
    GoRoute(
      path: '/contact-us',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ContactUsScreen(),
    ),
    GoRoute(
      path: '/privacy-policy',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const PrivacyPolicyScreen(),
    ),
    GoRoute(
      path: '/terms-of-use',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const TermsOfUseScreen(),
    ),
    GoRoute(
      path: '/about-app',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const AboutAppScreen(),
    ),
    // Mini Apps
    GoRoute(
      path: '/mini-apps/vardiya',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const VardiyaHomeScreen(),
      routes: [
        GoRoute(
          path: 'list',
          builder: (context, state) => const VardiyaListScreen(),
        ),
        GoRoute(
          path: 'report',
          builder: (context, state) => const VardiyaReportScreen(),
        ),
        GoRoute(
          path: 'plan',
          builder: (context, state) {
            final tabStr = state.uri.queryParameters['tab'];
            final tabIndex = tabStr != null ? int.tryParse(tabStr) ?? 0 : 0;
            return VardiyaPlanScreen(initialTab: tabIndex);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/mini-apps/odeme',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const OdemeHomeScreen(),
      routes: [
        GoRoute(
          path: 'list',
          builder: (context, state) => const OdemeListScreen(),
        ),
        GoRoute(
          path: 'add',
          builder: (context, state) => const OdemeAddScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/mini-apps/rezervasyon',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const RezervasyonHomeScreen(),
      routes: [
        GoRoute(
          path: 'list',
          builder: (context, state) => const RezervasyonListScreen(),
        ),
        GoRoute(
          path: 'add',
          builder: (context, state) => const RezervasyonAddScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/mini-apps/gorev',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const GorevHomeScreen(),
      routes: [
        GoRoute(
          path: 'kanban',
          builder: (context, state) => const GorevKanbanScreen(),
        ),
        GoRoute(
          path: 'list',
          builder: (context, state) => const GorevListScreen(),
        ),
        GoRoute(
          path: 'completed',
          builder: (context, state) => const GorevCompletedScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/mini-apps/gelir-gider',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const GelirGiderHomeScreen(),
      routes: [
        GoRoute(
          path: 'add',
          builder: (context, state) => const GelirGiderAddScreen(),
        ),
        GoRoute(
          path: 'reports',
          builder: (context, state) => const GelirGiderReportsScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/mini-apps/stok',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const StokHomeScreen(),
      routes: [
        GoRoute(
          path: 'add-product',
          builder: (context, state) => const StokAddProductScreen(),
        ),
        GoRoute(
          path: 'movement',
          builder: (context, state) => const StokMovementScreen(),
        ),
        GoRoute(
          path: 'reports',
          builder: (context, state) => const StokReportsScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/mini-apps/crm',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const CrmHomeScreen(),
      routes: [
        GoRoute(
          path: 'add',
          builder: (context, state) => const CrmAddScreen(),
        ),
        GoRoute(
          path: 'detail/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return CrmDetailScreen(id: id);
          },
        ),
        GoRoute(
          path: 'add-note/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            final type = state.uri.queryParameters['type'] ?? 'Note';
            return CrmAddNoteScreen(customerId: id, type: type);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/mini-apps/personel',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const PersonelHomeScreen(),
      routes: [
        GoRoute(
          path: 'add',
          builder: (context, state) => const PersonelAddScreen(),
        ),
        GoRoute(
          path: 'detail/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return PersonelDetailScreen(id: id);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/mini-apps/alacak-borc',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const AlacakBorcHomeScreen(),
      routes: [
        GoRoute(
          path: 'add-transaction',
          builder: (context, state) {
            final type = state.uri.queryParameters['type'] ?? 'alacak';
            return AlacakBorcAddTransactionScreen(type: type);
          },
        ),
        GoRoute(
          path: 'add-cari',
          builder: (context, state) => const AlacakBorcAddCariScreen(),
        ),
        GoRoute(
          path: 'reports',
          builder: (context, state) => const AlacakBorcReportsScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/mini-apps/izin',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const IzinHomeScreen(),
      routes: [
        GoRoute(
          path: 'add',
          builder: (context, state) => const IzinAddScreen(),
        ),
        GoRoute(
          path: 'calendar',
          builder: (context, state) => const IzinCalendarScreen(),
        ),
        GoRoute(
          path: 'reports',
          builder: (context, state) => const IzinReportsScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/mini-apps/siparis',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SiparisHomeScreen(),
      routes: [
        GoRoute(
          path: 'add',
          builder: (context, state) => const SiparisAddScreen(),
        ),
        GoRoute(
          path: 'detail/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return SiparisDetailScreen(id: id);
          },
        ),
        GoRoute(
          path: 'reports',
          builder: (context, state) => const SiparisReportsScreen(),
        ),
      ],
    ),
  ],
);
