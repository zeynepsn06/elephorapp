import 'package:flutter/material.dart';

enum TransactionType { alacak, borc }
enum TransactionStatus { bekliyor, odendi, tahsilEdildi, gecikti }

class CariHesap {
  final String id;
  final String name;
  final String phone;
  final double bakiye; // Pozitif ise alacaklıyız, negatif ise borçluyuz
  final DateTime createdAt;

  const CariHesap({
    required this.id,
    required this.name,
    this.phone = '',
    this.bakiye = 0.0,
    required this.createdAt,
  });
}

class AlacakBorcIslem {
  final String id;
  final String cariId;
  final String cariName;
  final TransactionType type;
  final double amount;
  final DateTime vadeTarihi;
  final TransactionStatus status;
  final String note;

  const AlacakBorcIslem({
    required this.id,
    required this.cariId,
    required this.cariName,
    required this.type,
    required this.amount,
    required this.vadeTarihi,
    this.status = TransactionStatus.bekliyor,
    this.note = '',
  });

  bool get isGecikmis {
    if (status == TransactionStatus.odendi || status == TransactionStatus.tahsilEdildi) return false;
    return vadeTarihi.isBefore(DateTime.now().subtract(const Duration(days: 1)));
  }
}
