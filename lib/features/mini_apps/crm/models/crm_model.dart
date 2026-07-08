import 'package:flutter/material.dart';

enum CrmCustomerType { person, company }
enum CrmActivityType { note, meeting, offer, sale }

class CrmCustomer {
  final String id;
  final String name; // Kişi veya Firma adı
  final CrmCustomerType type;
  final String phone;
  final String email;
  final String address;
  final List<String> tags; // VIP, Potansiyel vb.
  final String companyName; // Eğer kişi ise, çalıştığı firma
  final DateTime createdAt;

  const CrmCustomer({
    required this.id,
    required this.name,
    required this.type,
    this.phone = '',
    this.email = '',
    this.address = '',
    this.tags = const [],
    this.companyName = '',
    required this.createdAt,
  });
}

class CrmActivity {
  final String id;
  final String customerId;
  final CrmActivityType type;
  final String title;
  final String description;
  final DateTime date;
  final double amount; // Sadece teklif veya satış için
  final String status; // Bekliyor, Onaylandı, Reddedildi vb.

  const CrmActivity({
    required this.id,
    required this.customerId,
    required this.type,
    required this.title,
    this.description = '',
    required this.date,
    this.amount = 0.0,
    this.status = '',
  });
}
