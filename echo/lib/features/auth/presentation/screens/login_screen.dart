import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/primary_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 32,
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Welcome Back",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 34,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Text(
                              "Log in for your next chat",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                            ),

                            const SizedBox(height: 50),

                            PrimaryTextField(
                              hintText: "Email",
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),

                            const SizedBox(height: 20),

                            PrimaryTextField(
                              hintText: "Password",
                              controller: passwordController,
                              obscureText: obscurePassword,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                                icon: Icon(
                                  obscurePassword
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forgot Password?",
                                  style: AppTheme.bodyMedium.copyWith(
                                    color: AppTheme.primary,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            PrimaryButton(
                              text: "Log In",
                              onPressed: () {},
                            ),

                            const SizedBox(height: 36),

                            Row(
                              children: [
                                const Expanded(
                                  child: Divider(
                                    color: Colors.white24,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                                  child: Text(
                                    "OR CONTINUE WITH",
                                    style: AppTheme.caption.copyWith(
                                      color: AppTheme.textSecondary,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: Divider(
                                    color: Colors.white24,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 30),

                            SocialButton(
                              text: "Continue with Google",
                              assetIcon: "assets/icons/google.png",
                              onPressed: () {},
                            ),

                            const SizedBox(height: 16),

                            SocialButton(
                              text: "Continue with Facebook",
                              assetIcon: "assets/icons/facebook.png",
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}