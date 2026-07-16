import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/widgets/primary_button.dart';
import '../widgets/interest_chip.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<String> interests = [
    'AI',
    'Programming',
    'Technology',
    'Flutter',
    'Web Development',
    'Machine Learning',
    'Cyber Security',
    'Mobile Development',
    'UI/UX',
    'Design',
    'Finance',
    'Business',
    'Productivity',
    'Startups',
    'Mathematics',
    'Science',
    'Gaming',
    'Movies',
    'Music',
    'Sports',
    'Travel',
    'Books',
    'History',
  ];

  final List<String> selectedInterests = [];

  Future<void> continueToChat() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(
      'onboarding_completed',
      true,
    );

    await prefs.setStringList(
      'preferences',
      selectedInterests,
    );

    if (!mounted) return;

    context.go('/chat');
  }

  void toggleInterest(String interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else {
        // Optional limit
        if (selectedInterests.length < 10) {
          selectedInterests.add(interest);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final canContinue = selectedInterests.length >= 3;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),

              Text(
                "Choose Your Interests",
                textAlign: TextAlign.center,
                style: AppTheme.displayLarge.copyWith(
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                "Pick at least 3 interests to personalize your chats.",
                textAlign: TextAlign.center,
                style: AppTheme.bodyLarge.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "${selectedInterests.length} of 3 selected",
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 28),

              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 12,
                      children: interests.map((interest) {
                        return InterestChip(
                          title: interest,
                          isSelected:
                          selectedInterests.contains(interest),
                          onTap: () => toggleInterest(interest),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              PrimaryButton(
                text: "Continue",
                onPressed: canContinue
                    ? continueToChat
                    : null,
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}