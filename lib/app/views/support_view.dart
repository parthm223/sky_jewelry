import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sky_jewelry/app/core/app_theme.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(title: const Text('Customer Support'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'How can we help you?',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3, end: 0),

            const SizedBox(height: 8),

            Text(
              'Choose from the options below or contact us directly',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppTheme.mediumGrey),
            ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

            const SizedBox(height: 32),

            // Support Options
            _buildSupportOption(
                  icon: Icons.chat_bubble_outline,
                  title: 'Live Chat',
                  subtitle: 'Chat with our support team',
                  onTap: () => Get.snackbar('Info', 'Live chat coming soon!'),
                )
                .animate()
                .fadeIn(delay: 400.ms, duration: 600.ms)
                .slideX(begin: 0.3, end: 0),

            const SizedBox(height: 16),

            _buildSupportOption(
                  icon: Icons.email_outlined,
                  title: 'Email Support',
                  subtitle: 'Send us an email',
                  onTap: () => Get.snackbar(
                    'Info',
                    'Email support: support@luxejewelry.com',
                  ),
                )
                .animate()
                .fadeIn(delay: 600.ms, duration: 600.ms)
                .slideX(begin: 0.3, end: 0),

            const SizedBox(height: 16),

            _buildSupportOption(
                  icon: Icons.phone_outlined,
                  title: 'Phone Support',
                  subtitle: 'Call us directly',
                  onTap: () => Get.snackbar('Info', 'Phone: +1 (555) 123-4567'),
                )
                .animate()
                .fadeIn(delay: 800.ms, duration: 600.ms)
                .slideX(begin: 0.3, end: 0),

            const SizedBox(height: 16),

            _buildSupportOption(
                  icon: Icons.help_outline,
                  title: 'FAQ',
                  subtitle: 'Find answers to common questions',
                  onTap: () => Get.snackbar('Info', 'FAQ section coming soon!'),
                )
                .animate()
                .fadeIn(delay: 1000.ms, duration: 600.ms)
                .slideX(begin: 0.3, end: 0),

            const SizedBox(height: 32),

            // Contact Form
            _buildContactForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.pureWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.premiumBlack.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryGold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppTheme.primaryGold, size: 24),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.premiumBlack,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.mediumGrey,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppTheme.mediumGrey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final messageController = TextEditingController();

    return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppTheme.pureWhite,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppTheme.premiumBlack.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Send us a message',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: messageController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Your Message',
                  prefixIcon: Icon(Icons.message_outlined),
                  alignLabelWithHint: true,
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar(
                      'Message Sent',
                      'Thank you for contacting us. We\'ll get back to you soon!',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    nameController.clear();
                    emailController.clear();
                    messageController.clear();
                  },
                  child: const Text(
                    'Send Message',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 1200.ms, duration: 600.ms)
        .slideY(begin: 0.3, end: 0);
  }
}
