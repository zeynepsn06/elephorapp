import 'package:flutter/material.dart';

enum GorevPriority {
  low(color: Color(0xFF10B981), label: 'Düşük'),
  medium(color: Color(0xFFF59E0B), label: 'Orta'),
  high(color: Color(0xFFEF4444), label: 'Yüksek');

  final Color color;
  final String label;
  const GorevPriority({required this.color, required this.label});
}

enum GorevStatus {
  todo('Yapılacak'),
  inProgress('Devam Ediyor'),
  review('İncelemede'),
  done('Tamamlandı');

  final String label;
  const GorevStatus(this.label);
}

class GorevModel {
  final String id;
  final String title;
  final String description;
  final GorevStatus status;
  final GorevPriority priority;
  final String assignee;
  final String assigneeInitials;
  final DateTime dueDate;
  final int subtasksCount;
  final int subtasksCompleted;
  final int commentsCount;
  final int attachmentsCount;

  const GorevModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.assignee,
    required this.assigneeInitials,
    required this.dueDate,
    this.subtasksCount = 0,
    this.subtasksCompleted = 0,
    this.commentsCount = 0,
    this.attachmentsCount = 0,
  });

  GorevModel copyWith({
    String? id,
    String? title,
    String? description,
    GorevStatus? status,
    GorevPriority? priority,
    String? assignee,
    String? assigneeInitials,
    DateTime? dueDate,
    int? subtasksCount,
    int? subtasksCompleted,
    int? commentsCount,
    int? attachmentsCount,
  }) {
    return GorevModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      assignee: assignee ?? this.assignee,
      assigneeInitials: assigneeInitials ?? this.assigneeInitials,
      dueDate: dueDate ?? this.dueDate,
      subtasksCount: subtasksCount ?? this.subtasksCount,
      subtasksCompleted: subtasksCompleted ?? this.subtasksCompleted,
      commentsCount: commentsCount ?? this.commentsCount,
      attachmentsCount: attachmentsCount ?? this.attachmentsCount,
    );
  }
}

// Mock Data
final List<GorevModel> mockGorevler = [
  GorevModel(
    id: '1',
    title: 'Ana sayfa tasarımı revizesi',
    description: 'Header ve footer kısımları yeni marka kurallarına göre güncellenecek.',
    status: GorevStatus.inProgress,
    priority: GorevPriority.high,
    assignee: 'Ahmet Yılmaz',
    assigneeInitials: 'AY',
    dueDate: DateTime.now().add(const Duration(days: 1)),
    subtasksCount: 4,
    subtasksCompleted: 2,
    commentsCount: 3,
    attachmentsCount: 1,
  ),
  GorevModel(
    id: '2',
    title: 'Müşteri veritabanı optimizasyonu',
    description: 'Yavaş çalışan sorguların indekslenmesi.',
    status: GorevStatus.todo,
    priority: GorevPriority.medium,
    assignee: 'Zeynep Kaya',
    assigneeInitials: 'ZK',
    dueDate: DateTime.now().add(const Duration(days: 3)),
    subtasksCount: 0,
    subtasksCompleted: 0,
    commentsCount: 0,
    attachmentsCount: 0,
  ),
  GorevModel(
    id: '3',
    title: 'Yeni ürün kataloğu çekimi',
    description: 'Stüdyo çekimleri ve düzenleme işleri tamamlanacak.',
    status: GorevStatus.review,
    priority: GorevPriority.medium,
    assignee: 'Murat Demir',
    assigneeInitials: 'MD',
    dueDate: DateTime.now().add(const Duration(days: 0)), // Today
    subtasksCount: 5,
    subtasksCompleted: 5,
    commentsCount: 12,
    attachmentsCount: 4,
  ),
  GorevModel(
    id: '4',
    title: 'Mobil uygulama performans testi',
    description: 'Flutter uygulamasının bellek sızıntıları test edilecek.',
    status: GorevStatus.done,
    priority: GorevPriority.high,
    assignee: 'Selin Arslan',
    assigneeInitials: 'SA',
    dueDate: DateTime.now().subtract(const Duration(days: 2)),
    subtasksCount: 3,
    subtasksCompleted: 3,
    commentsCount: 1,
    attachmentsCount: 0,
  ),
  GorevModel(
    id: '5',
    title: 'Aylık bülten hazırlığı',
    description: 'İçerik planlaması ve gönderim listelerinin güncellenmesi.',
    status: GorevStatus.todo,
    priority: GorevPriority.low,
    assignee: 'Ahmet Yılmaz',
    assigneeInitials: 'AY',
    dueDate: DateTime.now().add(const Duration(days: 7)),
    subtasksCount: 2,
    subtasksCompleted: 0,
    commentsCount: 0,
    attachmentsCount: 0,
  ),
];
