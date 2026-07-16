import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_progress_model.dart';

class GamificationLocalDataSource {
  static const _xpKey = 'xp';
  static const _levelKey = 'level';
  static const _streakKey = 'streak';
  static const _messagesKey = 'messages_sent';
  static const _lastLoginKey = 'last_login';
  static const _achievementsKey = 'achievements';

  Future<UserProgressModel> getProgress() async {
    final prefs = await SharedPreferences.getInstance();

    return UserProgressModel(
      xp: prefs.getInt(_xpKey) ?? 0,
      level: prefs.getInt(_levelKey) ?? 1,
      streak: prefs.getInt(_streakKey) ?? 0,
      messagesSent: prefs.getInt(_messagesKey) ?? 0,
      lastLogin: prefs.getString(_lastLoginKey) != null
          ? DateTime.parse(prefs.getString(_lastLoginKey)!)
          : null,
      achievements:
      prefs.getStringList(_achievementsKey) ?? const [],
    );
  }

  Future<void> saveProgress(UserProgressModel progress) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(_xpKey, progress.xp);
    await prefs.setInt(_levelKey, progress.level);
    await prefs.setInt(_streakKey, progress.streak);
    await prefs.setInt(_messagesKey, progress.messagesSent);

    if (progress.lastLogin != null) {
      await prefs.setString(
        _lastLoginKey,
        progress.lastLogin!.toIso8601String(),
      );
    }

    await prefs.setStringList(
      _achievementsKey,
      progress.achievements,
    );
  }

  Future<void> clearProgress() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_xpKey);
    await prefs.remove(_levelKey);
    await prefs.remove(_streakKey);
    await prefs.remove(_messagesKey);
    await prefs.remove(_lastLoginKey);
    await prefs.remove(_achievementsKey);
  }
}