import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/gemini_remote_data_source.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/usecases/send_message_usecase.dart';

final geminiRemoteDataSourceProvider =
Provider<GeminiRemoteDataSource>((ref) {
  return GeminiRemoteDataSource();
});

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepositoryImpl(
    ref.read(geminiRemoteDataSourceProvider),
  );
});

final sendMessageUseCaseProvider =
Provider<SendMessageUseCase>((ref) {
  return SendMessageUseCase(
    ref.read(chatRepositoryProvider),
  );
});