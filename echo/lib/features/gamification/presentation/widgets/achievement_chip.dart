import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class AchievementChip extends StatelessWidget {
  final String title;

  const AchievementChip({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: const Icon(
        Icons.emoji_events_rounded,
        color: Colors.amber,
        size: 18,
      ),
      backgroundColor: Colors.white10,
      side: BorderSide.none,
      label: Text(
        title,
        style: AppTheme.bodyMedium.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}