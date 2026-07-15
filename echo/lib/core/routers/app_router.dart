import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      builder: (context, state) => Scaffold(
        body: Center(
          child: Text('Login Screen'),
        ),
      ),
    ),
  ],
);