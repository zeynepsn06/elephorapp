import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../models/mini_app_model.dart';

class MiniAppCard extends StatelessWidget {
  final MiniAppModel app;
  final VoidCallback? onTap;
  final VoidCallback? onAction;
  final bool showSummary;
  final String? summaryText;

  const MiniAppCard({
    super.key,
    required this.app,
    this.onTap,
    this.onAction,
    this.showSummary = false,
    this.summaryText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(AppConstants.radiusCard),
          border: Border.all(color: Theme.of(context).dividerColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: app.iconBgColor,
                  borderRadius:
                      BorderRadius.circular(20), // Using a fixed radius
                ),
                child: Icon(app.icon, color: app.iconColor, size: 26),
              ),
              SizedBox(width: 14),
              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      app.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 3),
                    Text(
                      showSummary && summaryText != null
                          ? summaryText!
                          : app.shortDescription,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              // Action Button
              _buildActionButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    switch (app.status) {
      case MiniAppStatus.added:
        return OutlinedButton(
          onPressed: onAction,
          style: OutlinedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.primary,
            side: BorderSide(color: Theme.of(context).colorScheme.primary),
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            minimumSize: Size(60, 34),
            textStyle: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w600),
          ),
          child: Text('Aç'),
        );
      case MiniAppStatus.premium:
        return Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            gradient: AppColors.premiumGradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'Pro',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      case MiniAppStatus.comingSoon:
        return Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: Theme.of(context).inputDecorationTheme.fillColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'Yakında',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      default:
        return ElevatedButton(
          onPressed: onAction,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            minimumSize: Size(60, 34),
            elevation: 0,
            textStyle: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w600),
          ),
          child: Text('Ekle'),
        );
    }
  }
}

class GridAppCard extends StatelessWidget {
  final MiniAppModel app;
  final VoidCallback? onTap;
  final VoidCallback? onAction;
  final bool showSummary;
  final String? summaryText;

  const GridAppCard({
    super.key,
    required this.app,
    this.onTap,
    this.onAction,
    this.showSummary = false,
    this.summaryText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(AppConstants.radiusCard),
          border: Border.all(color: Theme.of(context).dividerColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: app.iconBgColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(app.icon, color: app.iconColor, size: 30),
              ),
              SizedBox(height: 12),
              // Text
              Text(
                app.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Theme.of(context).colorScheme.onSurface),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Expanded(
                child: Text(
                  showSummary && summaryText != null
                      ? summaryText!
                      : app.shortDescription,
                  style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.secondary),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Action Button
              SizedBox(
                width: double.infinity,
                child: _buildActionButton(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    switch (app.status) {
      case MiniAppStatus.added:
        return OutlinedButton(
          onPressed: onAction,
          style: OutlinedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.primary,
            side: BorderSide(color: Theme.of(context).colorScheme.primary),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            minimumSize: Size(60, 34),
            textStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          child: Text('Aç'),
        );
      case MiniAppStatus.premium:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            gradient: AppColors.premiumGradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              'Pro',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      case MiniAppStatus.comingSoon:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: Theme.of(context).inputDecorationTheme.fillColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              'Yakında',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      default:
        return ElevatedButton(
          onPressed: onAction,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            minimumSize: Size(60, 34),
            elevation: 0,
            textStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          child: Text('Ekle'),
        );
    }
  }
}

class VerticalAppCard extends StatelessWidget {
  final MiniAppModel app;
  final VoidCallback? onTap;
  final VoidCallback? onAction;

  const VerticalAppCard({
    super.key,
    required this.app,
    this.onTap,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(AppConstants.radiusCard),
          border: Border.all(color: Theme.of(context).dividerColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(AppConstants.radiusIcon),
                    ),
                    child: Icon(app.icon, color: Theme.of(context).scaffoldBackgroundColor, size: 24),
                  ),
                  Icon(Icons.more_horiz_rounded, color: Theme.of(context).colorScheme.secondary),
                ],
              ),
              const Spacer(),
              Text(
                app.name,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                app.shortDescription,
                style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.secondary, height: 1.3),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Theme.of(context).dividerColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star_border_rounded, size: 12, color: Theme.of(context).colorScheme.onSurface),
                        const SizedBox(width: 4),
                        Text(
                          app.rating.toString(),
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSurface),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: onAction,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Aç',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Theme.of(context).scaffoldBackgroundColor),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HorizontalAppCard extends StatelessWidget {
  final MiniAppModel app;
  final VoidCallback? onTap;
  final VoidCallback? onAction;

  const HorizontalAppCard({
    super.key,
    required this.app,
    this.onTap,
    this.onAction,
  });

  Widget _buildActionButton(BuildContext context) {
    if (app.status == MiniAppStatus.premium) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color ?? Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.orange.shade300),
        ),
        child: Row(
          children: [
            Icon(Icons.workspace_premium_rounded, size: 14, color: Colors.orange.shade500),
            const SizedBox(width: 4),
            Text('Pro', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.orange.shade600)),
          ],
        ),
      );
    } else if (app.status == MiniAppStatus.comingSoon) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color ?? Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Row(
          children: [
            Icon(Icons.hourglass_empty_rounded, size: 14, color: Theme.of(context).colorScheme.secondary),
            const SizedBox(width: 4),
            Text('Yakında', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondary)),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color ?? Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Text(
          'Ekle',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(AppConstants.radiusIcon),
                    ),
                    child: Icon(app.icon, color: Theme.of(context).scaffoldBackgroundColor, size: 24),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.star_border_rounded, size: 10, color: Theme.of(context).colorScheme.secondary),
                      const SizedBox(width: 2),
                      Text(
                        app.rating.toString(),
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondary),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      app.name,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      app.shortDescription,
                      style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.secondary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: onAction,
                child: _buildActionButton(context),
              ),
              const SizedBox(width: 12),
              Icon(Icons.chevron_right_rounded, color: Theme.of(context).colorScheme.secondary, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
