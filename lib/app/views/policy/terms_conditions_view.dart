import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sky_jewelry/app/core/app_theme.dart';

class TermsConditionsView extends StatelessWidget {
  const TermsConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pureWhite,
      appBar: AppBar(
        title: Text(
          'Terms & Conditions',
          style: TextStyle(
            color: AppTheme.premiumBlack,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: -0.5,
          ),
        ),
        backgroundColor: AppTheme.pureWhite,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppTheme.premiumBlack,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Header Card
            _buildHeroHeader(),
            const SizedBox(height: 32),

            // Introduction
            _buildSectionHeader('Introduction', Icons.description_rounded),
            const SizedBox(height: 16),
            _buildRichTextSection(
              'Welcome to Sky Jewelry. These Terms and Conditions govern your use of our website and services. By accessing or using our platform, you agree to be bound by these terms. If you disagree with any part, you may not access our services.',
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),

            const SizedBox(height: 32),

            // Terms Sections with staggered animation
            ..._buildAllTermsSections(),

            const SizedBox(height: 24),

            // Contact Information
            _buildContactSection(),

            const SizedBox(height: 20),

            // Acceptance Footer
            _buildAcceptanceFooter(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroHeader() {
    return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.primaryGold, AppTheme.darkGold],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.8],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryGold.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            children: [
              // Animated Icon Container
              Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.pureWhite.withOpacity(0.15),
                          AppTheme.pureWhite.withOpacity(0.05),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.pureWhite.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.gavel_rounded,
                      size: 44,
                      color: AppTheme.pureWhite,
                    ),
                  )
                  .animate()
                  .scale(duration: 600.ms, curve: Curves.elasticOut)
                  .shake(delay: 300.ms, hz: 4),

              const SizedBox(height: 20),

              // Title
              Text(
                'Terms & Conditions',
                style: TextStyle(
                  color: AppTheme.pureWhite,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              // Subtitle
              Text(
                'Please read these terms carefully before using our services',
                style: TextStyle(
                  color: AppTheme.pureWhite.withOpacity(0.9),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              // Metadata Cards
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildMetadataChip('Version', '2.1.0'),
                    const SizedBox(width: 12),
                    _buildMetadataChip(
                      'Last Updated',
                      '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              _buildHeaderInfo(
                'Effective Immediately upon acceptance',
                Icons.flash_on_rounded,
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: -0.1, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildMetadataChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.pureWhite.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.pureWhite.withOpacity(0.3)),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: TextStyle(
                color: AppTheme.pureWhite.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                color: AppTheme.pureWhite,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderInfo(String text, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 16, color: AppTheme.pureWhite.withOpacity(0.8)),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: AppTheme.pureWhite.withOpacity(0.9),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildAllTermsSections() {
    final sections = [
      _buildTermsSection(
        title: '1. Acceptance of Terms',
        icon: Icons.check_circle_rounded,
        points: [
          'By creating an account, placing an order, or using our services, you acknowledge that you have read, understood, and agree to be bound by these terms.',
          'These terms apply to all users including browsers, vendors, customers, merchants, and content contributors.',
          'We reserve the right to update, change, or replace any part of these terms by posting updates to our website.',
        ],
        delay: 300,
      ),
      _buildTermsSection(
        title: '2. Account Terms',
        icon: Icons.person_rounded,
        points: [
          'You must be at least 18 years old to use our services or have parental consent.',
          'You are responsible for maintaining the confidentiality of your account credentials.',
          'You agree to provide accurate and complete information during registration.',
          'We reserve the right to terminate accounts for fraudulent activities or violations of these terms.',
        ],
        delay: 400,
      ),
      _buildTermsSection(
        title: '3. Product Information & Pricing',
        icon: Icons.shopping_bag_rounded,
        points: [
          'Product images are for illustrative purposes; actual products may vary slightly.',
          'We reserve the right to modify prices without prior notice.',
          'All prices are in Indian Rupees (₹) and include applicable taxes unless stated otherwise.',
          'Products are subject to availability; we may cancel orders for out-of-stock items.',
        ],
        delay: 500,
      ),
      _buildTermsSection(
        title: '4. Order Processing & Payment',
        icon: Icons.payment_rounded,
        points: [
          'Orders are processed within 1-2 business days (excluding weekends and holidays).',
          'We accept various payment methods including credit/debit cards, UPI, and net banking.',
          'Payment must be completed before order processing begins.',
          'We implement SSL encryption for secure transactions; however, we cannot guarantee absolute security.',
        ],
        delay: 600,
      ),
      _buildTermsSection(
        title: '5. Shipping & Delivery',
        icon: Icons.local_shipping_rounded,
        points: [
          'Delivery timelines are estimates and may vary based on location and circumstances.',
          'Risk of loss passes to you upon delivery to the carrier.',
          'Signature may be required for high-value orders (above ₹10,000).',
          'International shipping may be subject to customs duties and taxes.',
        ],
        delay: 700,
      ),
      _buildTermsSection(
        title: '6. Returns & Refunds',
        icon: Icons.assignment_return_rounded,
        points: [
          'Returns accepted within 15 days of delivery for defective or damaged items.',
          'Items must be returned in original condition with tags and packaging.',
          'Refunds processed within 7-10 business days after return inspection.',
          'Customized or personalized items cannot be returned unless defective.',
        ],
        delay: 800,
      ),
      _buildTermsSection(
        title: '7. Intellectual Property',
        icon: Icons.copyright_rounded,
        points: [
          'All content on this website (images, text, logos, designs) is owned by Sky Jewelry.',
          'Unauthorized use may violate copyright, trademark, and other laws.',
          'You may not reproduce, distribute, or create derivative works without permission.',
          'User-generated content grants us a license to use it for business purposes.',
        ],
        delay: 900,
      ),
      _buildTermsSection(
        title: '8. User Conduct',
        icon: Icons.security_rounded,
        points: [
          'You agree not to use the website for any unlawful purpose.',
          'Prohibited activities include fraud, hacking, spamming, and infringement.',
          'You may not attempt to gain unauthorized access to any part of the website.',
          'We reserve the right to terminate access for violations of user conduct policies.',
        ],
        delay: 1000,
      ),
      _buildTermsSection(
        title: '9. Limitation of Liability',
        icon: Icons.warning_rounded,
        points: [
          'Sky Jewelry shall not be liable for indirect, incidental, or consequential damages.',
          'Maximum liability is limited to the purchase price of the products.',
          'We are not liable for delays beyond our control (natural disasters, strikes, etc.).',
          'Products are provided "as is" without warranties of merchantability.',
        ],
        delay: 1100,
      ),
      _buildTermsSection(
        title: '10. Governing Law & Disputes',
        icon: Icons.balance_rounded,
        points: [
          'These terms are governed by the laws of India.',
          'Disputes will be subject to the exclusive jurisdiction of courts in Mumbai.',
          'We encourage informal dispute resolution before legal action.',
          'Arbitration may be required for certain disputes as per Indian law.',
        ],
        delay: 1200,
      ),
    ];

    return sections;
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryGold.withOpacity(0.15),
                AppTheme.primaryGold.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.primaryGold.withOpacity(0.2)),
          ),
          child: Icon(icon, color: AppTheme.primaryGold, size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppTheme.premiumBlack,
              letterSpacing: -0.5,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRichTextSection(String text) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.lightGrey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.lightGrey.withOpacity(0.2)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: AppTheme.darkGrey,
          height: 1.7,
          letterSpacing: 0.2,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildTermsSection({
    required String title,
    required IconData icon,
    required List<String> points,
    required int delay,
  }) {
    return Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Material(
            color: AppTheme.pureWhite,
            borderRadius: BorderRadius.circular(18),
            elevation: 1,
            shadowColor: Colors.black.withOpacity(0.05),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppTheme.lightGrey.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.primaryGold.withOpacity(0.15),
                              AppTheme.primaryGold.withOpacity(0.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          icon,
                          color: AppTheme.primaryGold,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.premiumBlack,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...points.map((point) => _buildTermPoint(point)).toList(),
                ],
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(delay: delay.ms)
        .slideX(
          begin: 0.1,
          end: 0,
          duration: 500.ms,
          curve: Curves.easeOutCubic,
        );
  }

  Widget _buildTermPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppTheme.primaryGold,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryGold.withOpacity(0.4),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.5,
                color: AppTheme.darkGrey,
                height: 1.6,
                letterSpacing: 0.1,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Material(
      color: AppTheme.pureWhite,
      borderRadius: BorderRadius.circular(18),
      elevation: 1,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppTheme.primaryGold.withOpacity(0.2)),
          gradient: LinearGradient(
            colors: [
              AppTheme.primaryGold.withOpacity(0.03),
              AppTheme.primaryGold.withOpacity(0.01),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGold.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.contact_support_rounded,
                    color: AppTheme.primaryGold,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Contact for Clarifications',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.premiumBlack,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'If you have any questions about these Terms & Conditions, please contact us:',
              style: TextStyle(
                color: AppTheme.darkGrey,
                fontSize: 14.5,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 20),
            _buildContactItem(
              Icons.email_rounded,
              'Email',
              'legal@skyjewelry.com',
            ),
            _buildContactItem(Icons.phone_rounded, 'Phone', '+91-XXXXX-XXXXX'),
            _buildContactItem(
              Icons.location_on_rounded,
              'Address',
              'Sky Jewelry Ltd., Mumbai, India',
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 1400.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppTheme.primaryGold),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.premiumBlack.withOpacity(0.7),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  color: AppTheme.premiumBlack,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAcceptanceFooter() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.primaryGold.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryGold.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_rounded, color: AppTheme.primaryGold, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'By using our services, you acknowledge that you have read and agree to these Terms & Conditions.',
              style: TextStyle(
                fontSize: 13.5,
                color: AppTheme.darkGrey,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 1500.ms);
  }
}
