import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sky_jewelry/app/core/app_theme.dart';

class ShippingPolicyView extends StatelessWidget {
  const ShippingPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pureWhite,
      appBar: AppBar(
        title: const Text(
          'Shipping Policy',
          style: TextStyle(
            color: AppTheme.premiumBlack,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: AppTheme.pureWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppTheme.premiumBlack,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card with Enhanced Information
            Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.primaryGold, AppTheme.darkGold],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryGold.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppTheme.pureWhite.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.local_shipping,
                          size: 40,
                          color: AppTheme.pureWhite,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Fast & Secure Shipping',
                        style: TextStyle(
                          color: AppTheme.pureWhite,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Worldwide delivery with real-time tracking',
                        style: TextStyle(
                          color: AppTheme.pureWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      _buildInfoRow(
                        'Processing Time',
                        '1-2 Business Days',
                        Icons.schedule,
                      ),
                      _buildInfoRow(
                        'Support',
                        '24/7 Customer Care',
                        Icons.support_agent,
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(duration: 600.ms)
                .scale(begin: Offset(0.9, 0.9), end: Offset(1, 1)),

            const SizedBox(height: 30),

            // Shipping Options Section
            const Text(
              'Shipping Options',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.premiumBlack,
                letterSpacing: 0.3,
              ),
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 5),
            const Text(
              'Choose the delivery option that suits your needs',
              style: TextStyle(color: AppTheme.darkGrey, fontSize: 14),
            ),
            const SizedBox(height: 20),

            _buildShippingOption(
              'Standard Shipping',
              '5-7 Business Days',
              '• Free on orders over ₹2,000\n• Order tracking included\n• Safe & secure packaging\n• Delivery attempts: 2',
              '₹99',
              Icons.local_shipping,
              Colors.blue,
              ['All major cities', 'Tier 2-3 cities'],
            ).animate().slideX(delay: 300.ms, duration: 500.ms),

            _buildShippingOption(
              'Express Shipping',
              '2-3 Business Days',
              '• Priority processing\n• Real-time SMS updates\n• Signature confirmation\n• Free returns within 7 days',
              '₹199',
              Icons.flash_on,
              Colors.orange,
              ['Metro cities', 'State capitals'],
            ).animate().slideX(delay: 500.ms, duration: 500.ms),

            _buildShippingOption(
              'Premium Shipping',
              '1-2 Business Days',
              '• Same-day processing\n• Dedicated support agent\n• Insurance coverage up to ₹50,000\n• Flexible delivery time slots',
              '₹299',
              Icons.diamond,
              AppTheme.primaryGold,
              ['All serviceable areas', 'Early morning delivery'],
            ).animate().slideX(delay: 700.ms, duration: 500.ms),

            const SizedBox(height: 30),

            // Detailed Policy Sections
            _buildPolicySection('Shipping Information', Icons.info, [
              _buildPolicyPoint(
                'Order Processing',
                'All orders are processed within 1-2 business days (excluding weekends and holidays)',
              ),
              _buildPolicyPoint(
                'Tracking',
                'Real-time tracking information will be provided via email and SMS immediately after shipment',
              ),
              _buildPolicyPoint(
                'Signature Required',
                'Signature required for all orders above ₹10,000 for security purposes',
              ),
              _buildPolicyPoint(
                'Packaging',
                'All items are packaged in premium gift boxes with security seals and care instructions',
              ),
              _buildPolicyPoint(
                'Insurance',
                'Comprehensive insurance coverage included on all shipments above ₹5,000',
              ),
            ]).animate().slideX(delay: 900.ms, duration: 500.ms),

            _buildPolicySection('Delivery Areas & Coverage', Icons.location_on, [
              _buildPolicyPoint(
                'Domestic Shipping',
                'We deliver to all pin codes across India including remote areas and union territories',
              ),
              _buildPolicyPoint(
                'International Shipping',
                'Available to USA, UK, Canada, Australia, UAE, Singapore, and European countries',
              ),
              _buildPolicyPoint(
                'Remote Areas',
                'Additional 1-2 days may be required for delivery in remote locations',
              ),
              _buildPolicyPoint(
                'Service Updates',
                'Delivery timelines may vary during festivals and peak seasons',
              ),
            ]).animate().slideX(delay: 1100.ms, duration: 500.ms),

            _buildPolicySection('Important Notes', Icons.warning, [
              _buildPolicyPoint(
                'Address Accuracy',
                'Please ensure shipping address is complete and accurate. Address changes may delay delivery',
              ),
              _buildPolicyPoint(
                'Customs & Duties',
                'International customers are responsible for any customs duties and taxes',
              ),
              _buildPolicyPoint(
                'Delivery Attempts',
                'We make 2 delivery attempts. Failed deliveries will be returned to our facility',
              ),
              _buildPolicyPoint(
                'Contact Information',
                'Please provide active phone number for delivery coordination',
              ),
            ]).animate().slideX(delay: 1300.ms, duration: 500.ms),

            // FAQ Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.lightGrey.withOpacity(0.1),
                    AppTheme.primaryGold.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppTheme.primaryGold.withOpacity(0.1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.help, color: AppTheme.primaryGold, size: 20),
                      SizedBox(width: 10),
                      Text(
                        'Need Help?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.premiumBlack,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Contact our shipping support team for any delivery-related queries',
                    style: TextStyle(color: AppTheme.darkGrey, fontSize: 14),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      _buildContactButton('Call Support', Icons.phone, () {}),
                      const SizedBox(width: 10),
                      _buildContactButton('Email Us', Icons.email, () {}),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 1500.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: AppTheme.pureWhite.withOpacity(0.8)),
          const SizedBox(width: 8),
          Text(
            '$title: ',
            style: TextStyle(
              color: AppTheme.pureWhite.withOpacity(0.9),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.pureWhite,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingOption(
    String title,
    String duration,
    String description,
    String price,
    IconData icon,
    Color color,
    List<String> features,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.pureWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.premiumBlack,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            price,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      duration,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.darkGrey,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: features
                .map((feature) => _buildFeatureChip(feature, color))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPolicySection(String title, IconData icon, List<Widget> points) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.pureWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.lightGrey.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
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
                child: Icon(icon, color: AppTheme.primaryGold, size: 22),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.premiumBlack,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(children: points),
        ],
      ),
    );
  }

  Widget _buildPolicyPoint(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppTheme.primaryGold,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.premiumBlack,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.darkGrey,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactButton(
    String text,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 16),
        label: Text(text, style: const TextStyle(fontSize: 13)),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryGold,
          foregroundColor: AppTheme.pureWhite,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
