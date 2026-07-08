import 'package:flutter/material.dart';

class StokProduct {
  final String id;
  final String name;
  final String category;
  final String barcode;
  final int currentStock;
  final int criticalLimit;

  const StokProduct({
    required this.id,
    required this.name,
    required this.category,
    required this.barcode,
    required this.currentStock,
    required this.criticalLimit,
  });

  bool get isCritical => currentStock <= criticalLimit;
}

enum StokMovementType { inStock, outStock }

class StokMovement {
  final String id;
  final String productId;
  final String productName;
  final StokMovementType type;
  final int quantity;
  final DateTime date;
  final String note;

  const StokMovement({
    required this.id,
    required this.productId,
    required this.productName,
    required this.type,
    required this.quantity,
    required this.date,
    this.note = '',
  });
}
