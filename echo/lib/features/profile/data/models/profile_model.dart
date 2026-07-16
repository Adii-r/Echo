import '../../domain/entities/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required super.name,
    required super.email,
    required super.photoUrl,
    required super.interests,
  });

  factory ProfileModel.fromData({
    required String name,
    required String email,
    String? photoUrl,
    required List<String> interests,
  }) {
    return ProfileModel(
      name: name,
      email: email,
      photoUrl: photoUrl,
      interests: interests,
    );
  }
}