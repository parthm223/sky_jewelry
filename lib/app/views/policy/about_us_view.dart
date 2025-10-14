import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sky_jewelry/app/core/app_theme.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pureWhite,
      appBar: AppBar(
        title: const Text(
          'About Us',
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
              height: 200,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primaryGold, AppTheme.darkGold],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.diamond, size: 60, color: AppTheme.pureWhite),
                    SizedBox(height: 12),
                    Text(
                      'Sky Jewelry',
                      style: TextStyle(
                        color: AppTheme.pureWhite,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Premium Jewelry Collection',
                      style: TextStyle(
                        color: AppTheme.pureWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 600.ms),

            const SizedBox(height: 30),

            _buildSection(
              'Our Story',
              'Sky Jewelry has been crafting exquisite jewelry pieces for over two decades. Founded with a passion for creating timeless beauty, we specialize in premium gold, silver, platinum, and rose gold collections that celebrate life\'s precious moments.',
              Icons.auto_stories,
            ).animate().slideX(delay: 200.ms, duration: 500.ms),

            _buildSection(
              'Our Mission',
              'To provide our customers with the finest quality jewelry that combines traditional craftsmanship with contemporary design. We believe every piece should tell a story and create lasting memories.',
              Icons.flag,
            ).animate().slideX(delay: 400.ms, duration: 500.ms),

            _buildSection(
              'Quality Assurance',
              'Each piece in our collection undergoes rigorous quality checks. We use only the finest materials and work with skilled artisans to ensure every jewelry item meets our high standards of excellence.',
              Icons.verified,
            ).animate().slideX(delay: 600.ms, duration: 500.ms),

            _buildSection(
              'Customer Commitment',
              'Your satisfaction is our priority. We offer comprehensive customer support, easy returns, and lifetime maintenance services to ensure your jewelry remains as beautiful as the day you bought it.',
              Icons.favorite,
            ).animate().slideX(delay: 800.ms, duration: 500.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.lightGrey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryGold.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGold.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppTheme.primaryGold, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.premiumBlack,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.darkGrey,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
