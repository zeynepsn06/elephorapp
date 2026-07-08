import 'package:flutter/material.dart';

enum NotificationType {
  vardiya,
  odeme,
  rezervasyon,
  ekip,
  sistem,
  abonelik,
}

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String source;
  final NotificationType type;
  final DateTime createdAt;
  final bool isRead;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.source,
    required this.type,
    required this.createdAt,
    required this.isRead,
  });

  IconData get icon {
    switch (type) {
      case NotificationType.vardiya:
        return Icons.schedule_rounded;
      case NotificationType.odeme:
        return Icons.account_balance_wallet_rounded;
      case NotificationType.rezervasyon:
        return Icons.calendar_month_rounded;
      case NotificationType.ekip:
        return Icons.people_rounded;
      case NotificationType.sistem:
        return Icons.notifications_rounded;
      case NotificationType.abonelik:
        return Icons.workspace_premium_rounded;
    }
  }

  Color get iconColor {
    switch (type) {
      case NotificationType.vardiya:
        return const Color(0xFF6366F1);
      case NotificationType.odeme:
        return const Color(0xFF2ECC8A);
      case NotificationType.rezervasyon:
        return const Color(0xFF4A90D9);
      case NotificationType.ekip:
        return const Color(0xFFF59E0B);
      case NotificationType.sistem:
        return const Color(0xFF6B7280);
      case NotificationType.abonelik:
        return const Color(0xFFC9A227);
    }
  }

  String get timeAgo {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inMinutes < 60) return '${diff.inMinutes} dakika önce';
    if (diff.inHours < 24) return '${diff.inHours} saat önce';
    if (diff.inDays < 7) return '${diff.inDays} gün önce';
    return '${createdAt.day}.${createdAt.month}.${createdAt.year}';
  }
}

final List<NotificationModel> mockNotifications = [
  NotificationModel(
    id: '1',
    title: 'Ödeme tarihi yaklaşıyor',
    body: 'ABC Müşterisinin 12.500 TL ödemesi bugün.',
    source: 'Ödeme Takibi',
    type: NotificationType.odeme,
    createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
    isRead: false,
  ),
  NotificationModel(
    id: '2',
    title: 'Yeni rezervasyon eklendi',
    body: 'Zeynep Kaya saat 14:00 için rezervasyon oluşturdu.',
    source: 'Rezervasyon',
    type: NotificationType.rezervasyon,
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    isRead: false,
  ),
  NotificationModel(
    id: '3',
    title: 'Ahmet Yılmaz vardiyaya başladı',
    body: 'Saat 09:05\'te giriş yapıldı. 5 dakika geç.',
    source: 'Vardiya Takip',
    type: NotificationType.vardiya,
    createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    isRead: true,
  ),
  NotificationModel(
    id: '4',
    title: 'Ekip daveti bekleniyor',
    body: 'Murat Demir ekip davetinizi henüz kabul etmedi.',
    source: 'Ekip',
    type: NotificationType.ekip,
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    isRead: true,
  ),
  NotificationModel(
    id: '5',
    title: 'Geciken ödeme uyarısı',
    body: 'XYZ Ltd. şirketinin 8.200 TL ödemesi 3 gün gecikti.',
    source: 'Ödeme Takibi',
    type: NotificationType.odeme,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    isRead: true,
  ),
  NotificationModel(
    id: '6',
    title: 'Pro paket avantajları sizi bekliyor',
    body: 'Daha fazla mini uygulama ve kullanıcı için Pro\'ya geçin.',
    source: 'Elephor+',
    type: NotificationType.abonelik,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    isRead: true,
  ),
];
