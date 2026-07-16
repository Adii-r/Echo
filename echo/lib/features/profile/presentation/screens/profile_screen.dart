import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../gamification/presentation/providers/gamification_provider.dart';
import '../providers/profile_provider.dart';
import '../widgets/logout_button.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_option_tile.dart';
import '../widgets/profile_stat_card.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool isLoading = true;

  dynamic profile;
  dynamic progress;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    profile = await ref.read(profileProvider).getProfile();
    progress = await ref.read(gamificationProvider).getProgress();

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  Future<void> logout() async {
    await ref.read(profileProvider).signOut();

    if (!mounted) return;

    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: AppTheme.background,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.background,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "PROFILE",
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w900,
            fontSize: 24,
            letterSpacing: 6,
            color: Colors.white,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [

              ProfileAvatar(
                photoUrl: profile.photoUrl,
                name: profile.name,
              ),

              const SizedBox(height: 20),

              ProfileHeader(
                name: profile.name,
                email: profile.email,
              ),

              const SizedBox(height: 32),

              Row(
                children: [
                  ProfileStatCard(
                    title: "Level",
                    value: progress.level.toString(),
                  ),

                  const SizedBox(width: 12),

                  ProfileStatCard(
                    title: "XP",
                    value: progress.xp.toString(),
                  ),

                  const SizedBox(width: 12),

                  ProfileStatCard(
                    title: "Messages",
                    value: progress.messagesSent.toString(),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Your Interests",
                  style: AppTheme.bodyMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: profile.interests.map<Widget>((interest) {
                  return Chip(
                    label: Text(interest),
                    backgroundColor: AppTheme.primary,
                    labelStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 40),

              ProfileOptionTile(
                icon: Icons.emoji_events_outlined,
                title: "Gamification",
                onTap: () => context.push('/gamification'),
              ),

              ProfileOptionTile(
                icon: Icons.settings_outlined,
                title: "Settings",
                onTap: () {},
              ),

              ProfileOptionTile(
                icon: Icons.info_outline,
                title: "About Echo",
                onTap: () {},
              ),

              const SizedBox(height: 32),

              LogoutButton(
                onPressed: logout,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}