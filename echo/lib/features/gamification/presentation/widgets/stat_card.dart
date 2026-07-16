import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 15,
          sigmaY: 15,
        ),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.08),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Colors.white12,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: AppTheme.primary,
                size: 32,
              ),

              const SizedBox(height: 10),

              Text(
                value,
                style: AppTheme.titleLarge.copyWith(
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                title,
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}