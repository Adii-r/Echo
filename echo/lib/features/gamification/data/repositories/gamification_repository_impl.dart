import '../../domain/entities/user_progress.dart';
import '../../domain/repositories/gamification_repository.dart';
import '../datasources/gamification_local_data_source.dart';
import '../models/user_progress_model.dart';

class GamificationRepositoryImpl implements GamificationRepository {
  final GamificationLocalDataSource localDataSource;

  GamificationRepositoryImpl(this.localDataSource);

  @override
  Future<UserProgress> getProgress() async {
    return await localDataSource.getProgress();
  }

  @override
  Future<void> saveProgress(UserProgress progress) async {
    await localDataSource.saveProgress(
      UserProgressModel.fromEntity(progress),
    );
  }

  @override
  Future<void> addXp(int xp) async {
    final progress = await localDataSource.getProgress();

    final updatedXp = progress.xp + xp;

    final updatedLevel = (updatedXp ~/ 100) + 1;

    final updatedProgress = progress.copyWith(
      xp: updatedXp,
      level: updatedLevel,
    );

    await localDataSource.saveProgress(
      UserProgressModel.fromEntity(updatedProgress),
    );
  }

  @override
  Future<void> incrementMessages() async {
    final progress = await localDataSource.getProgress();

    final achievements = List<String>.from(progress.achievements);

    final totalMessages = progress.messagesSent + 1;

    if (totalMessages == 1 &&
        !achievements.contains("First Prompt")) {
      achievements.add("First Prompt");
    }

    if (totalMessages == 25 &&
        !achievements.contains("Curious Mind")) {
      achievements.add("Curious Mind");
    }

    if (totalMessages == 100 &&
        !achievements.contains("AI Explorer")) {
      achievements.add("AI Explorer");
    }

    final updatedProgress = progress.copyWith(
      messagesSent: totalMessages,
      achievements: achievements,
    );

    await localDataSource.saveProgress(
      UserProgressModel.fromEntity(updatedProgress),
    );
  }

  @override
  Future<void> updateDailyStreak() async {
    final progress = await localDataSource.getProgress();

    final today = DateTime.now();

    int streak = progress.streak;

    if (progress.lastLogin != null) {
      final difference = today
          .difference(progress.lastLogin!)
          .inDays;

      if (difference == 1) {
        streak++;
      } else if (difference > 1) {
        streak = 1;
      }
    } else {
      streak = 1;
    }

    final achievements = List<String>.from(progress.achievements);

    if (streak == 7 &&
        !achievements.contains("Weekly Warrior")) {
      achievements.add("Weekly Warrior");
    }

    final updatedProgress = progress.copyWith(
      streak: streak,
      lastLogin: today,
      achievements: achievements,
    );

    await localDataSource.saveProgress(
      UserProgressModel.fromEntity(updatedProgress),
    );
  }

  @override
  Future<void> reset() async {
    await localDataSource.clearProgress();
  }
}