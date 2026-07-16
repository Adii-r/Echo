import 'package:echo/features/auth/presentation/screens/login_screen.dart';
import 'package:echo/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:go_router/go_router.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';
import '../../features/gamification/presentation/screens/gamification_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashScreen(),
    ),

    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),

    GoRoute(
      path: '/onboarding',
      builder: (context, state) => OnboardingScreen(),
    ),

    GoRoute(
      path: '/chat',
      builder: (context, state) => ChatScreen(),
    ),

    GoRoute(
      path: '/gamification',
      builder: (context, state) => GamificationScreen(),
    ),
  ],
);