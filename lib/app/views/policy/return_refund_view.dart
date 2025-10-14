import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sky_jewelry/app/core/app_theme.dart';

class ReturnRefundPolicyView extends StatelessWidget {
  const ReturnRefundPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pureWhite,
      appBar: AppBar(
        title: const Text(
          'Return & Refund Policy',
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
            // Header Section
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
                  Icon(
                    Icons.assignment_return,
                    size: 50,
                    color: AppTheme.pureWhite,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Easy Returns & Refunds',
                    style: TextStyle(
                      color: AppTheme.pureWhite,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Hassle-free return process',
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

            // Existing Policies
            _buildPolicySection(
              '30-Day Return Policy',
              'We offer a 30-day return policy from the date of delivery. Items must be in original condition, unworn, and in original packaging with all tags attached.',
              Icons.schedule,
            ).animate().slideX(delay: 200.ms, duration: 500.ms),

            _buildPolicySection(
              'Return Process',
              '1. Contact our customer service team\n2. Receive return authorization and shipping label\n3. Package item securely and ship back\n4. Refund processed within 5-7 business days',
              Icons.list_alt,
            ).animate().slideX(delay: 400.ms, duration: 500.ms),

            _buildPolicySection(
              'Refund Methods',
              'Refunds will be processed to the original payment method. Credit card refunds may take 3-5 business days to appear on your statement. Store credit is available for faster processing.',
              Icons.payment,
            ).animate().slideX(delay: 600.ms, duration: 500.ms),

            _buildPolicySection(
              'Exchange Policy',
              'We offer free exchanges for different sizes or styles within 30 days. Custom or personalized items cannot be returned unless defective.',
              Icons.swap_horiz,
            ).animate().slideX(delay: 800.ms, duration: 500.ms),

            _buildPolicySection(
              'Damaged Items',
              'If you receive a damaged item, please contact us immediately with photos. We will arrange for immediate replacement or full refund at no cost to you.',
              Icons.report_problem,
            ).animate().slideX(delay: 1000.ms, duration: 500.ms),

            // 🔥 New Extra Policies
            _buildPolicySection(
              'Non-Returnable Items',
              'Certain items such as customized jewellery, engraved pieces, and items purchased during clearance sales are non-returnable and non-refundable.',
              Icons.block,
            ).animate().slideX(delay: 1200.ms, duration: 500.ms),

            _buildPolicySection(
              'Return Shipping Costs',
              'We provide free return shipping for defective or incorrect items. For all other returns, a small return shipping fee may be deducted from the refund.',
              Icons.local_shipping,
            ).animate().slideX(delay: 1400.ms, duration: 500.ms),

            _buildPolicySection(
              'Quality Check',
              'All returned items will undergo a quality inspection before processing the refund. Items that show signs of wear or damage caused by the customer will not be accepted.',
              Icons.verified,
            ).animate().slideX(delay: 1600.ms, duration: 500.ms),

            _buildPolicySection(
              'International Orders',
              'For international customers, return shipping costs and customs duties are the responsibility of the customer unless the item is defective.',
              Icons.public,
            ).animate().slideX(delay: 1800.ms, duration: 500.ms),

            const SizedBox(height: 30),

            // Contact Us Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to Contact Us screen (define this route in your app)
                  Get.toNamed('/contact');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGold,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(
                  Icons.support_agent,
                  color: AppTheme.pureWhite,
                ),
                label: const Text(
                  "Need Help? Contact Us",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.pureWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable Policy Section Widget
  Widget _buildPolicySection(String title, String content, IconData icon) {
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGold.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, color: AppTheme.primaryGold, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.premiumBlack,
                  ),
                ),
              ),
            ],
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
