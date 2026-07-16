class UserProgress {
  final int xp;
  final int level;
  final int streak;
  final int messagesSent;
  final DateTime? lastLogin;
  final List<String> achievements;

  const UserProgress({
    required this.xp,
    required this.level,
    required this.streak,
    required this.messagesSent,
    required this.lastLogin,
    required this.achievements,
  });

  UserProgress copyWith({
    int? xp,
    int? level,
    int? streak,
    int? messagesSent,
    DateTime? lastLogin,
    List<String>? achievements,
  }) {
    return UserProgress(
      xp: xp ?? this.xp,
      level: level ?? this.level,
      streak: streak ?? this.streak,
      messagesSent: messagesSent ?? this.messagesSent,
      lastLogin: lastLogin ?? this.lastLogin,
      achievements: achievements ?? this.achievements,
    );
  }

  int get nextLevelXp => level * 100;

  int get currentLevelXp => xp - ((level - 1) * 100);

  int get xpForCurrentLevel => 100;

  double get progress =>
      (currentLevelXp / xpForCurrentLevel).clamp(0.0, 1.0);

  factory UserProgress.initial() {
    return const UserProgress(
      xp: 0,
      level: 1,
      streak: 0,
      messagesSent: 0,
      lastLogin: null,
      achievements: [],
    );
  }
}