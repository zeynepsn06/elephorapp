import 'package:flutter/material.dart';

enum TransactionType { income, expense }

class GelirGiderTransaction {
  final String id;
  final TransactionType type;
  final double amount;
  final String category;
  final DateTime date;
  final String description;

  const GelirGiderTransaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.category,
    required this.date,
    this.description = '',
  });
}

class GelirGiderCategory {
  final String id;
  final String name;
  final IconData icon;
  final TransactionType type;

  const GelirGiderCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
  });
}
