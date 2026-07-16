import '../entities/user_progress.dart';
import '../repositories/gamification_repository.dart';

class GetProgressUseCase {
  final GamificationRepository repository;

  GetProgressUseCase(this.repository);

  Future<UserProgress> call() async {
    return repository.getProgress();
  }
}