import 'package:get/get.dart';

class PolicyController extends GetxController {
  final RxString currentPolicy = ''.obs;
  final RxBool isLoading = false.obs;

  void setCurrentPolicy(String policy) {
    currentPolicy.value = policy;
  }

  // Sample policy content - in real app, this would come from API
  String getAboutUsContent() {
    return '''
Welcome to Jewelry Palace - Your Premier Destination for Exquisite Jewelry

At Jewelry Palace, we believe that every piece of jewelry tells a story. Since our establishment, we have been dedicated to crafting and curating the finest collection of jewelry that celebrates life's most precious moments.

Our Story
Founded with a passion for exceptional craftsmanship and timeless elegance, Jewelry Palace has grown to become a trusted name in the jewelry industry. We combine traditional techniques with modern innovation to create pieces that are not just accessories, but treasured heirlooms.

Our Mission
To provide our customers with the highest quality jewelry at exceptional value, while delivering an unparalleled shopping experience that exceeds expectations.

Quality Assurance
Every piece in our collection undergoes rigorous quality checks. We work with certified gemologists and skilled artisans to ensure that each item meets our exacting standards.

Customer Commitment
Your satisfaction is our priority. We are committed to providing exceptional customer service, expert guidance, and lifetime support for all your jewelry needs.
    ''';
  }

  String getPrivacyPolicyContent() {
    return '''
Privacy Policy

Last updated: ${DateTime.now().year}

At Jewelry Palace, we are committed to protecting your privacy and ensuring the security of your personal information.

Information We Collect
• Personal identification information (Name, email address, phone number)
• Billing and shipping addresses
• Payment information (processed securely through encrypted channels)
• Shopping preferences and browsing history
• Device information and IP addresses

How We Use Your Information
• Process and fulfill your orders
• Communicate about your purchases and account
• Provide customer support
• Send promotional offers (with your consent)
• Improve our services and website functionality
• Comply with legal obligations

Information Sharing
We do not sell, trade, or rent your personal information to third parties. We may share information with:
• Trusted service providers who assist in our operations
• Payment processors for transaction processing
• Shipping companies for order delivery
• Legal authorities when required by law

Data Security
We implement industry-standard security measures to protect your information, including SSL encryption, secure servers, and regular security audits.

Your Rights
• Access your personal information
• Correct inaccurate data
• Request deletion of your data
• Opt-out of marketing communications
• Data portability

Contact Us
For privacy-related questions, contact us at privacy@jewelrypalace.com
    ''';
  }

  String getReturnRefundPolicyContent() {
    return '''
Return & Refund Policy

We want you to be completely satisfied with your purchase. Our return and refund policy is designed to ensure your peace of mind.

Return Period
• 30 days from delivery date for most items
• 7 days for custom or personalized jewelry
• 14 days for engagement rings and wedding bands

Return Conditions
Items must be:
• In original condition and packaging
• Unworn and undamaged
• Accompanied by original receipt or order confirmation
• Free from engravings or customizations (unless defective)

Non-Returnable Items
• Earrings (for hygiene reasons)
• Custom or personalized jewelry (unless defective)
• Items damaged by normal wear
• Items purchased with special promotions (unless defective)

Return Process
1. Contact our customer service within the return period
2. Receive return authorization and shipping label
3. Package items securely and ship back
4. Refund processed within 5-7 business days after receipt

Refund Methods
• Original payment method for full refunds
• Store credit for exchanges
• Shipping costs are non-refundable (unless item is defective)

Exchanges
Free exchanges available for:
• Different sizes (subject to availability)
• Manufacturing defects
• Damaged items during shipping

Warranty
• 1-year warranty on craftsmanship
• Lifetime warranty on diamond settings
• Free cleaning and inspection services

Contact our customer service at returns@jewelrypalace.com for assistance.
    ''';
  }

  String getShippingPolicyContent() {
    return '''
Shipping Policy

We are committed to delivering your precious jewelry safely and promptly.

Shipping Options

Standard Shipping (5-7 business days)
• Free on orders over ₹2,000
• ₹99 for orders under ₹2,000
• Available across India

Express Shipping (2-3 business days)
• ₹199 for all orders
• Available in major cities
• Tracking included

Premium Shipping (Next day delivery)
• ₹399 for all orders
• Available in select metro cities
• Signature required on delivery

International Shipping
• Available to select countries
• 7-14 business days
• Customs duties may apply
• Insurance included

Processing Time
• In-stock items: 1-2 business days
• Custom jewelry: 7-14 business days
• Engraving services: Additional 2-3 days

Packaging
• Elegant gift boxes included
• Secure, tamper-evident packaging
• Insurance coverage for all shipments
• Eco-friendly materials

Delivery Requirements
• Signature required for orders over ₹5,000
• Valid ID required for high-value items
• Safe delivery to registered address only
• Re-delivery charges may apply for failed attempts

Order Tracking
• Tracking information sent via SMS and email
• Real-time updates on order status
• Customer service support for delivery issues

Special Handling
• High-value items shipped with additional security
• Temperature-controlled shipping for sensitive items
• White glove delivery service available for premium orders

Contact our shipping team at shipping@jewelrypalace.com for any queries.
    ''';
  }

  String getTermsConditionsContent() {
    return '''
Terms & Conditions

Last updated: ${DateTime.now().year}

Welcome to Jewelry Palace. By using our services, you agree to these terms.

Acceptance of Terms
By accessing and using our website and services, you accept and agree to be bound by these Terms and Conditions.

Use of Website
• You must be 18 years or older to make purchases
• Provide accurate and complete information
• Use the website for lawful purposes only
• Do not attempt to breach security measures

Product Information
• We strive for accuracy in product descriptions
• Colors may vary due to monitor settings
• Weights and measurements are approximate
• Gemstone characteristics may vary naturally

Pricing and Payment
• All prices are in Indian Rupees (INR)
• Prices subject to change without notice
• Payment required before shipping
• We accept major credit cards, debit cards, and UPI

Order Acceptance
• Order confirmation does not guarantee acceptance
• We reserve the right to refuse or cancel orders
• Pricing errors may result in order cancellation
• Bulk orders subject to special terms

Intellectual Property
• All content is owned by Jewelry Palace
• Trademarks and logos are protected
• Unauthorized use is prohibited
• Product images are copyrighted

Limitation of Liability
• Our liability is limited to the purchase price
• We are not liable for indirect damages
• Force majeure events excuse performance
• Some jurisdictions may not allow limitations

Governing Law
These terms are governed by Indian law and subject to the jurisdiction of courts in Mumbai, India.

Modifications
We reserve the right to modify these terms at any time. Continued use constitutes acceptance of changes.

Contact Information
For questions about these terms, contact us at:
Email: legal@jewelrypalace.com
Phone: +91-9876543210
Address: Jewelry Palace, Mumbai, India

Severability
If any provision is found unenforceable, the remaining provisions will continue in effect.
    ''';
  }
}
