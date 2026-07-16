import '../repositories/gamification_repository.dart';

class IncrementMessagesUseCase {
  final GamificationRepository repository;

  IncrementMessagesUseCase(this.repository);

  Future<void> call() async {
    await repository.incrementMessages();
  }
}