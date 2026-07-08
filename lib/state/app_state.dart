import 'package:flutter/material.dart';
import '../models/mini_app_model.dart';
import '../models/notification_model.dart';

class AppState extends ChangeNotifier {
  final List<MiniAppModel> _allApps = List.from(allMiniApps);
  final List<NotificationModel> _notifications = List.from(mockNotifications);
  int _currentNavIndex = 0;
  ThemeMode _themeMode = ThemeMode.light;

  // Getters
  ThemeMode get themeMode => _themeMode;
  List<MiniAppModel> get allApps => _allApps;
  List<MiniAppModel> get addedApps =>
      _allApps.where((a) => a.status == MiniAppStatus.added).toList();
  List<NotificationModel> get notifications => _notifications;
  int get currentNavIndex => _currentNavIndex;
  int get unreadCount =>
      _notifications.where((n) => !n.isRead).length;

  bool isAdded(String appId) =>
      _allApps.any((a) => a.id == appId && a.status == MiniAppStatus.added);

  bool hasApp(String appId) => isAdded(appId);

  void addApp(String appId) {
    final index = _allApps.indexWhere((a) => a.id == appId);
    if (index != -1 && _allApps[index].status == MiniAppStatus.notAdded) {
      _allApps[index] = _allApps[index].copyWith(status: MiniAppStatus.added);
      notifyListeners();
    }
  }

  void removeApp(String appId) {
    final index = _allApps.indexWhere((a) => a.id == appId);
    if (index != -1 && _allApps[index].status == MiniAppStatus.added) {
      _allApps[index] =
          _allApps[index].copyWith(status: MiniAppStatus.notAdded);
      notifyListeners();
    }
  }

  void setNavIndex(int index) {
    _currentNavIndex = index;
    notifyListeners();
  }

  void toggleThemeMode() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void markAllRead() {
    for (int i = 0; i < _notifications.length; i++) {
      // In a real app, we'd update the model; here we keep it simple
    }
    notifyListeners();
  }

  MiniAppModel? getAppById(String id) {
    try {
      return _allApps.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }

  List<MiniAppModel> getAppsByCategory(String category) {
    if (category == 'Tümü' || category == 'Popüler') {
      return _allApps
          .where((a) => a.status != MiniAppStatus.comingSoon)
          .toList();
    }
    if (category == 'Yakında') {
      return _allApps
          .where((a) => a.status == MiniAppStatus.comingSoon)
          .toList();
    }
    return _allApps.where((a) => a.category == category).toList();
  }
}
