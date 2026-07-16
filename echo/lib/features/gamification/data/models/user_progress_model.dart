import '../../domain/entities/user_progress.dart';

class UserProgressModel extends UserProgress {
  const UserProgressModel({
    required super.xp,
    required super.level,
    required super.streak,
    required super.messagesSent,
    required super.lastLogin,
    required super.achievements,
  });

  factory UserProgressModel.fromMap(Map<String, dynamic> map) {
    return UserProgressModel(
      xp: map['xp'] ?? 0,
      level: map['level'] ?? 1,
      streak: map['streak'] ?? 0,
      messagesSent: map['messagesSent'] ?? 0,
      lastLogin: map['lastLogin'] != null
          ? DateTime.parse(map['lastLogin'])
          : null,
      achievements:
      List<String>.from(map['achievements'] ?? const []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'xp': xp,
      'level': level,
      'streak': streak,
      'messagesSent': messagesSent,
      'lastLogin': lastLogin?.toIso8601String(),
      'achievements': achievements,
    };
  }

  factory UserProgressModel.fromEntity(UserProgress progress) {
    return UserProgressModel(
      xp: progress.xp,
      level: progress.level,
      streak: progress.streak,
      messagesSent: progress.messagesSent,
      lastLogin: progress.lastLogin,
      achievements: progress.achievements,
    );
  }

  factory UserProgressModel.initial() {
    return const UserProgressModel(
      xp: 0,
      level: 1,
      streak: 0,
      messagesSent: 0,
      lastLogin: null,
      achievements: [],
    );
  }
}