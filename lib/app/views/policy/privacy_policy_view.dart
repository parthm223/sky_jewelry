import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sky_jewelry/app/core/app_theme.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pureWhite,
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            color: AppTheme.premiumBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppTheme.pureWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppTheme.premiumBlack),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primaryGold, AppTheme.darkGold],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Icon(Icons.privacy_tip, size: 50, color: AppTheme.pureWhite),
                  SizedBox(height: 12),
                  Text(
                    'Your Privacy Matters',
                    style: TextStyle(
                      color: AppTheme.pureWhite,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Last updated: January 2024',
                    style: TextStyle(
                      color: AppTheme.pureWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms),

            const SizedBox(height: 30),

            _buildPolicySection(
              'Information We Collect',
              'We collect information you provide directly to us, such as when you create an account, make a purchase, or contact us for support. This includes your name, email address, phone number, shipping address, and payment information.',
            ).animate().slideX(delay: 200.ms, duration: 500.ms),

            _buildPolicySection(
              'How We Use Your Information',
              'We use the information we collect to process your orders, provide customer service, send you updates about your purchases, and improve our services. We may also use your information to personalize your shopping experience.',
            ).animate().slideX(delay: 400.ms, duration: 500.ms),

            _buildPolicySection(
              'Information Sharing',
              'We do not sell, trade, or otherwise transfer your personal information to third parties without your consent, except as described in this policy. We may share information with trusted service providers who assist us in operating our website and conducting our business.',
            ).animate().slideX(delay: 600.ms, duration: 500.ms),

            _buildPolicySection(
              'Data Security',
              'We implement appropriate security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the internet is 100% secure.',
            ).animate().slideX(delay: 800.ms, duration: 500.ms),

            _buildPolicySection(
              'Your Rights',
              'You have the right to access, update, or delete your personal information. You may also opt out of receiving promotional communications from us. Contact us if you wish to exercise these rights.',
            ).animate().slideX(delay: 1000.ms, duration: 500.ms),

            _buildPolicySection(
              'Contact Us',
              'If you have any questions about this Privacy Policy, please contact us at privacy@skyjewelry.com or through our customer support channels.',
            ).animate().slideX(delay: 1200.ms, duration: 500.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicySection(String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.lightGrey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryGold.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.premiumBlack,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              color: AppTheme.darkGrey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
