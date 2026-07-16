import '../entities/user_progress.dart';

abstract class GamificationRepository {
  Future<UserProgress> getProgress();

  Future<void> saveProgress(UserProgress progress);

  Future<void> addXp(int xp);

  Future<void> incrementMessages();

  Future<void> updateDailyStreak();

  Future<void> reset();
}