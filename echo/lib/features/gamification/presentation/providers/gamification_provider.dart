import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/gamification_local_data_source.dart';
import '../../data/repositories/gamification_repository_impl.dart';
import '../../domain/entities/user_progress.dart';
import '../../domain/usecases/add_xp_usecase.dart';
import '../../domain/usecases/get_progress_usecase.dart';
import '../../domain/usecases/increment_messages_usecase.dart';
import '../../domain/usecases/update_streak_usecase.dart';

final gamificationLocalDataSourceProvider =
Provider<GamificationLocalDataSource>((ref) {
  return GamificationLocalDataSource();
});

final gamificationRepositoryProvider =
Provider<GamificationRepositoryImpl>((ref) {
  return GamificationRepositoryImpl(
    ref.read(gamificationLocalDataSourceProvider),
  );
});

final addXpUseCaseProvider =
Provider<AddXpUseCase>((ref) {
  return AddXpUseCase(
    ref.read(gamificationRepositoryProvider),
  );
});

final getProgressUseCaseProvider =
Provider<GetProgressUseCase>((ref) {
  return GetProgressUseCase(
    ref.read(gamificationRepositoryProvider),
  );
});

final incrementMessagesUseCaseProvider =
Provider<IncrementMessagesUseCase>((ref) {
  return IncrementMessagesUseCase(
    ref.read(gamificationRepositoryProvider),
  );
});

final updateDailyStreakUseCaseProvider =
Provider<UpdateDailyStreakUseCase>((ref) {
  return UpdateDailyStreakUseCase(
    ref.read(gamificationRepositoryProvider),
  );
});

final gamificationProvider =
Provider<GamificationService>((ref) {
  return GamificationService(
    repository: ref.read(gamificationRepositoryProvider),
    addXpUseCase: ref.read(addXpUseCaseProvider),
    getProgressUseCase: ref.read(getProgressUseCaseProvider),
    incrementMessagesUseCase:
    ref.read(incrementMessagesUseCaseProvider),
    updateDailyStreakUseCase:
    ref.read(updateDailyStreakUseCaseProvider),
  );
});

class GamificationService {
  final GamificationRepositoryImpl repository;

  final AddXpUseCase addXpUseCase;
  final GetProgressUseCase getProgressUseCase;
  final IncrementMessagesUseCase incrementMessagesUseCase;
  final UpdateDailyStreakUseCase updateDailyStreakUseCase;

  GamificationService({
    required this.repository,
    required this.addXpUseCase,
    required this.getProgressUseCase,
    required this.incrementMessagesUseCase,
    required this.updateDailyStreakUseCase,
  });

  Future<UserProgress> getProgress() async {
    return await getProgressUseCase();
  }

  Future<void> rewardForLogin() async {
    await updateDailyStreakUseCase();
    await addXpUseCase(10);
  }

  Future<void> rewardForOnboarding() async {
    await addXpUseCase(30);
  }

  Future<void> rewardForPrompt() async {
    await incrementMessagesUseCase();
    await addXpUseCase(5);
  }

  Future<void> rewardForResponse() async {
    await addXpUseCase(2);
  }

  Future<void> resetProgress() async {
    await repository.reset();
  }
}