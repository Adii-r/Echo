import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/routers/app_router.dart';
import 'core/theme/app_theme.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const EchoApp());
}

class EchoApp extends StatelessWidget {
  const EchoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Echo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppTheme.background,
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}