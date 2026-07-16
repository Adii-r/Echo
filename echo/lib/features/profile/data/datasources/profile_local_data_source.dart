import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/profile_model.dart';

class ProfileLocalDataSource {
  Future<ProfileModel> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final user = FirebaseAuth.instance.currentUser;

    return ProfileModel(
      name: user?.displayName ?? "Echo User",
      email: user?.email ?? "",
      photoUrl: user?.photoURL,
      interests: prefs.getStringList("preferences") ?? [],
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}