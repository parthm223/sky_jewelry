import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sky_jewelry/app/controllers/cart_controller.dart';
import 'package:sky_jewelry/app/core/app_theme.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(title: const Text('Checkout'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary
            _buildOrderSummary(context, cartController),

            const SizedBox(height: 24),

            // Delivery Address
            _buildDeliveryAddress(context),

            const SizedBox(height: 24),

            // Payment Methods
            _buildPaymentMethods(context),

            const SizedBox(height: 100), // Space for bottom button
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomSection(context, cartController),
    );
  }

  Widget _buildOrderSummary(
    BuildContext context,
    CartController cartController,
  ) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          Obx(
            () => Column(
              children: [
                _buildSummaryRow(
                  'Subtotal',
                  '\$${cartController.totalAmount.toStringAsFixed(2)}',
                ),
                const SizedBox(height: 8),
                _buildSummaryRow('Shipping', 'Free'),
                const SizedBox(height: 8),
                _buildSummaryRow(
                  'Tax',
                  '\$${(cartController.totalAmount * 0.08).toStringAsFixed(2)}',
                ),
                const Divider(height: 24),
                _buildSummaryRow(
                  'Total',
                  '\$${(cartController.totalAmount * 1.08).toStringAsFixed(2)}',
                  isTotal: true,
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? AppTheme.premiumBlack : AppTheme.darkGrey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: FontWeight.bold,
            color: isTotal ? AppTheme.primaryGold : AppTheme.premiumBlack,
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryAddress(BuildContext context) {
    return Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery Address',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.snackbar('Info', 'Address management coming soon!');
                    },
                    child: const Text('Change'),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              const Text(
                'John Doe\n123 Main Street\nNew York, NY 10001\nUnited States',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: AppTheme.darkGrey,
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 200.ms, duration: 600.ms)
        .slideY(begin: 0.3, end: 0);
  }

  Widget _buildPaymentMethods(BuildContext context) {
    return Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment Method',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              _buildPaymentOption('Credit/Debit Card', Icons.credit_card, true),
              const SizedBox(height: 12),
              _buildPaymentOption('Razorpay', Icons.payment, false),
              const SizedBox(height: 12),
              _buildPaymentOption('UPI', Icons.account_balance_wallet, false),
              const SizedBox(height: 12),
              _buildPaymentOption('Cash on Delivery', Icons.money, false),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 400.ms, duration: 600.ms)
        .slideY(begin: 0.3, end: 0);
  }

  Widget _buildPaymentOption(String title, IconData icon, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected
            ? AppTheme.primaryGold.withOpacity(0.1)
            : AppTheme.lightGrey,
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(color: AppTheme.primaryGold, width: 2)
            : null,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? AppTheme.primaryGold : AppTheme.darkGrey,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isSelected ? AppTheme.primaryGold : AppTheme.premiumBlack,
            ),
          ),
          const Spacer(),
          if (isSelected)
            const Icon(Icons.check_circle, color: AppTheme.primaryGold),
        ],
      ),
    );
  }

  Widget _buildBottomSection(
    BuildContext context,
    CartController cartController,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.pureWhite,
        boxShadow: [
          BoxShadow(
            color: AppTheme.premiumBlack.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              _processPayment(cartController);
            },
            child: Obx(
              () => Text(
                'Pay \$${(cartController.totalAmount * 1.08).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _processPayment(CartController cartController) {
    Get.dialog(
      AlertDialog(
        title: const Text('Order Placed!'),
        content: const Text(
          'Your order has been placed successfully. You will receive a confirmation email shortly.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              cartController.clearCart();
              Get.offAllNamed('/home');
            },
            child: const Text('Continue Shopping'),
          ),
        ],
      ),
    );
  }
}
