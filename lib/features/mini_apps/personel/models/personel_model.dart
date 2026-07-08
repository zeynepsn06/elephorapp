import 'package:flutter/material.dart';

class Personel {
  final String id;
  final String name;
  final String title;
  final String department;
  final String phone;
  final String email;
  final double salary;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isActive;
  final String imageUrl; // Profil resmi veya baş harfi

  const Personel({
    required this.id,
    required this.name,
    required this.title,
    required this.department,
    this.phone = '',
    this.email = '',
    required this.salary,
    required this.startDate,
    this.endDate,
    this.isActive = true,
    this.imageUrl = '',
  });
}

class PersonelEvrak {
  final String id;
  final String personelId;
  final String title;
  final String fileName;
  final DateTime uploadDate;

  const PersonelEvrak({
    required this.id,
    required this.personelId,
    required this.title,
    required this.fileName,
    required this.uploadDate,
  });
}

class PersonelPerformans {
  final String id;
  final String personelId;
  final String evaluatorName;
  final double score; // 1 ile 5 arası
  final String note;
  final DateTime date;

  const PersonelPerformans({
    required this.id,
    required this.personelId,
    required this.evaluatorName,
    required this.score,
    required this.note,
    required this.date,
  });
}
