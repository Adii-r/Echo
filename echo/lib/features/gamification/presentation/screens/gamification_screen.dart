import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/widgets/primary_button.dart';
import '../../domain/entities/user_progress.dart';
import '../providers/gamification_provider.dart';
import '../widgets/achievement_chip.dart';
import '../widgets/level_card.dart';
import '../widgets/stat_card.dart';

class GamificationScreen extends ConsumerStatefulWidget {
  const GamificationScreen({super.key});

  @override
  ConsumerState<GamificationScreen> createState() =>
      _GamificationScreenState();
}

class _GamificationScreenState
    extends ConsumerState<GamificationScreen> {
  UserProgress? progress;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProgress();
  }

  Future<void> loadProgress() async {
    final data = await ref
        .read(gamificationProvider)
        .getProgress();

    if (!mounted) return;

    setState(() {
      progress = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Achievements",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Inter",
            fontWeight: FontWeight.w900,
          ),
        ),
      ),

      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              LevelCard(
                level: progress!.level,
                xp: progress!.xp,
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      icon: Icons.local_fire_department,
                      title: "Streak",
                      value: "${progress!.streak}",
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: StatCard(
                      icon: Icons.chat_bubble,
                      title: "Messages",
                      value:
                      "${progress!.messagesSent}",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              StatCard(
                icon: Icons.workspace_premium,
                title: "Achievements",
                value:
                "${progress!.achievements.length}",
              ),

              const SizedBox(height: 30),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Unlocked Achievements",
                  style:
                  AppTheme.titleLarge.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              if (progress!
                  .achievements.isEmpty)
                Text(
                  "No achievements yet.\nKeep chatting!",
                  textAlign: TextAlign.center,
                  style:
                  AppTheme.bodyLarge.copyWith(
                    color:
                    AppTheme.textSecondary,
                  ),
                )
              else
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: progress!
                      .achievements
                      .map(
                        (achievement) =>
                        AchievementChip(
                          title: achievement,
                        ),
                  )
                      .toList(),
                ),

              const SizedBox(height: 40),

              PrimaryButton(
                text: "Refresh",
                onPressed: loadProgress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}