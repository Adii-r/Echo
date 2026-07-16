class Profile {
  final String name;
  final String email;
  final String? photoUrl;
  final List<String> interests;

  const Profile({
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.interests,
  });
}