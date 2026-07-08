import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum BadgeType { success, warning, danger, info, neutral, premium }

class StatusBadge extends StatelessWidget {
  final String label;
  final BadgeType type;
  final bool small;

  const StatusBadge({
    super.key,
    required this.label,
    required this.type,
    this.small = false,
  });

  Color get _bgColor {
    switch (type) {
      case BadgeType.success:
        return AppColors.success.withOpacity(0.12);
      case BadgeType.warning:
        return AppColors.warning.withOpacity(0.12);
      case BadgeType.danger:
        return AppColors.danger.withOpacity(0.12);
      case BadgeType.info:
        return AppColors.info.withOpacity(0.12);
      case BadgeType.neutral:
        return AppColors.bgSurface;
      case BadgeType.premium:
        return AppColors.premiumGold.withOpacity(0.12);
    }
  }

  Color get _textColor {
    switch (type) {
      case BadgeType.success:
        return AppColors.success;
      case BadgeType.warning:
        return AppColors.warning;
      case BadgeType.danger:
        return AppColors.danger;
      case BadgeType.info:
        return AppColors.info;
      case BadgeType.neutral:
        return AppColors.textSecondary;
      case BadgeType.premium:
        return AppColors.premiumGold;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 8 : 10,
        vertical: small ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: _textColor,
          fontSize: small ? 10 : 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
