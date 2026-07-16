import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class LevelCard extends StatelessWidget {
  final int level;
  final int xp;

  const LevelCard({
    super.key,
    required this.level,
    required this.xp,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (xp % 100) / 100;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 15,
          sigmaY: 15,
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.08),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white12,
            ),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.workspace_premium_rounded,
                color: Colors.amber,
                size: 60,
              ),

              const SizedBox(height: 16),

              Text(
                "Level $level",
                style: AppTheme.displayLarge.copyWith(
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "$xp XP",
                style: AppTheme.bodyLarge.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),

              const SizedBox(height: 20),

              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  backgroundColor: Colors.white10,
                  valueColor: const AlwaysStoppedAnimation(
                    AppTheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}