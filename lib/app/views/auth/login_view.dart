import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sky_jewelry/app/core/app_theme.dart';
import 'package:sky_jewelry/app/core/responsive_utils.dart';

import '../../controllers/auth_controller.dart';
import '../../routes/app_routes.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: SafeArea(
        child: Center(
          // Added Center widget for better responsive centering
          child: ConstrainedBox(
            // Added ConstrainedBox for max width control
            constraints: BoxConstraints(
              maxWidth: context.isDesktop ? 500 : double.infinity,
            ),
            child: SingleChildScrollView(
              padding: context.responsivePadding, // Using responsive padding
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: context.spacing(
                        mobile: 40,
                        tablet: 60,
                        desktop: 80,
                      ),
                    ), // Responsive spacing
                    // Logo and Title
                    Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Container(
                                width: context.iconSize(
                                  mobile: 70,
                                  tablet: 80,
                                  desktop: 90,
                                ), // Responsive logo size
                                height: context.iconSize(
                                  mobile: 70,
                                  tablet: 80,
                                  desktop: 90,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppTheme.primaryGold,
                                      AppTheme.darkGold,
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.primaryGold.withOpacity(
                                        0.3,
                                      ),
                                      blurRadius: 15,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.diamond,
                                  size: context.iconSize(
                                    mobile: 35,
                                    tablet: 40,
                                    desktop: 45,
                                  ), // Responsive icon size
                                  color: AppTheme.premiumBlack,
                                ),
                              ),
                              SizedBox(
                                height: context.spacing(
                                  mobile: 20,
                                  tablet: 24,
                                  desktop: 28,
                                ),
                              ), // Responsive spacing
                              Text(
                                'Welcome Back',
                                style: Theme.of(context).textTheme.displayMedium
                                    ?.copyWith(
                                      color: AppTheme.premiumBlack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: context.responsiveFontSize(
                                        mobile: 28,
                                        tablet: 32,
                                        desktop: 36,
                                      ), // Responsive font size
                                    ),
                              ),
                              SizedBox(
                                height: context.spacing(),
                              ), // Responsive spacing
                              Text(
                                'Sign in to your account',
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: AppTheme.darkGrey,
                                      fontSize: context.responsiveFontSize(
                                        mobile: 16,
                                        tablet: 18,
                                        desktop: 20,
                                      ), // Responsive font size
                                    ),
                              ),
                            ],
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .slideY(begin: -0.3, end: 0),

                    SizedBox(
                      height: context.spacing(
                        mobile: 40,
                        tablet: 60,
                        desktop: 80,
                      ),
                    ), // Responsive spacing
                    // Email Field
                    TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            fontSize: context.responsiveFontSize(),
                          ), // Responsive text size
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              fontSize: context.responsiveFontSize(),
                            ), // Responsive label size
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              size: context.iconSize(), // Responsive icon size
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!GetUtils.isEmail(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        )
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 600.ms)
                        .slideX(begin: -0.3, end: 0),

                    SizedBox(
                      height: context.spacing(
                        mobile: 16,
                        tablet: 20,
                        desktop: 24,
                      ),
                    ), // Responsive spacing
                    // Password Field
                    TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          style: TextStyle(
                            fontSize: context.responsiveFontSize(),
                          ), // Responsive text size
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontSize: context.responsiveFontSize(),
                            ), // Responsive label size
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              size: context.iconSize(), // Responsive icon size
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        )
                        .animate()
                        .fadeIn(delay: 400.ms, duration: 600.ms)
                        .slideX(begin: -0.3, end: 0),

                    SizedBox(
                      height: context.spacing(
                        mobile: 8,
                        tablet: 12,
                        desktop: 16,
                      ),
                    ), // Responsive spacing
                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Get.snackbar(
                            'Info',
                            'Forgot password feature coming soon!',
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: AppTheme.primaryGold,
                            fontSize: context
                                .responsiveFontSize(), // Responsive font size
                          ),
                        ),
                      ),
                    ).animate().fadeIn(delay: 600.ms, duration: 600.ms),

                    SizedBox(
                      height: context.spacing(
                        mobile: 32,
                        tablet: 40,
                        desktop: 48,
                      ),
                    ), // Responsive spacing
                    // Login Button
                    Obx(
                          () => SizedBox(
                            height: context.cardHeight(
                              mobile: 50,
                              tablet: 56,
                              desktop: 62,
                            ), // Responsive button height
                            child: ElevatedButton(
                              onPressed: controller.isLoading
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        controller.login(
                                          emailController.text.trim(),
                                          passwordController.text,
                                        );
                                      }
                                    },
                              child: controller.isLoading
                                  ? const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppTheme.premiumBlack,
                                      ),
                                    )
                                  : Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontSize: context.responsiveFontSize(
                                          mobile: 16,
                                          tablet: 18,
                                          desktop: 20,
                                        ),
                                      ), // Responsive button text
                                    ),
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 800.ms, duration: 600.ms)
                        .slideY(begin: 0.3, end: 0),

                    SizedBox(
                      height: context.spacing(
                        mobile: 32,
                        tablet: 40,
                        desktop: 48,
                      ),
                    ), // Responsive spacing
                    // Divider
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.spacing(
                              mobile: 12,
                              tablet: 16,
                              desktop: 20,
                            ),
                          ), // Responsive padding
                          child: Text(
                            'OR',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: context
                                  .responsiveFontSize(), // Responsive font size
                            ),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ).animate().fadeIn(delay: 1000.ms, duration: 600.ms),

                    SizedBox(
                      height: context.spacing(
                        mobile: 32,
                        tablet: 40,
                        desktop: 48,
                      ),
                    ), // Responsive spacing
                    // Register Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: context
                                .responsiveFontSize(), // Responsive font size
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.register),
                          child: Text(
                            'Sign Up',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.primaryGold,
                              fontWeight: FontWeight.w600,
                              fontSize: context
                                  .responsiveFontSize(), // Responsive font size
                            ),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(delay: 1200.ms, duration: 600.ms),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
