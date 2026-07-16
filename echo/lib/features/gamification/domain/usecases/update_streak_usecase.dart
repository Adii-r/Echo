import '../repositories/gamification_repository.dart';

class UpdateDailyStreakUseCase {
  final GamificationRepository repository;

  UpdateDailyStreakUseCase(this.repository);

  Future<void> call() async {
    await repository.updateDailyStreak();
  }
}