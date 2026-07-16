import '../repositories/gamification_repository.dart';

class AddXpUseCase {
  final GamificationRepository repository;

  AddXpUseCase(this.repository);

  Future<void> call(int xp) async {
    await repository.addXp(xp);
  }
}