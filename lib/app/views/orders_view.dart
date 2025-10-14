import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sky_jewelry/app/core/app_theme.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock orders data
    final orders = [
      {
        'id': 'ORD001',
        'date': '2024-01-15',
        'status': 'Delivered',
        'total': 2499.99,
        'items': 2,
      },
      {
        'id': 'ORD002',
        'date': '2024-01-10',
        'status': 'In Transit',
        'total': 899.99,
        'items': 1,
      },
      {
        'id': 'ORD003',
        'date': '2024-01-05',
        'status': 'Processing',
        'total': 1299.99,
        'items': 3,
      },
    ];

    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(title: const Text('My Orders'), centerTitle: true),
      body: orders.isEmpty
          ? _buildEmptyOrders(context)
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return _buildOrderCard(context, order, index);
              },
            ),
    );
  }

  Widget _buildEmptyOrders(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 100,
            color: AppTheme.mediumGrey,
          ).animate().scale(duration: 600.ms),

          const SizedBox(height: 24),

          Text(
            'No orders yet',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(color: AppTheme.darkGrey),
          ).animate().fadeIn(delay: 300.ms, duration: 600.ms),

          const SizedBox(height: 12),

          Text(
            'Start shopping to see your orders here',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppTheme.mediumGrey),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
        ],
      ),
    );
  }

  Widget _buildOrderCard(
    BuildContext context,
    Map<String, dynamic> order,
    int index,
  ) {
    return Container(
          margin: const EdgeInsets.only(bottom: 16),
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
                    'Order ${order['id']}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildStatusChip(order['status']),
                ],
              ),

              const SizedBox(height: 12),

              Text(
                'Placed on ${order['date']}',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppTheme.mediumGrey),
              ),

              const SizedBox(height: 8),

              Text(
                '${order['items']} items • \$${order['total'].toStringAsFixed(2)}',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppTheme.darkGrey),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Get.snackbar('Info', 'Order tracking coming soon!');
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.primaryGold),
                        foregroundColor: AppTheme.primaryGold,
                      ),
                      child: const Text('Track Order'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.snackbar('Info', 'Order details coming soon!');
                      },
                      child: const Text('View Details'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        .animate(delay: (index * 100).ms)
        .fadeIn(duration: 600.ms)
        .slideX(begin: 0.3, end: 0);
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'delivered':
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        break;
      case 'in transit':
        backgroundColor = AppTheme.primaryGold.withOpacity(0.1);
        textColor = AppTheme.primaryGold;
        break;
      case 'processing':
        backgroundColor = Colors.blue.withOpacity(0.1);
        textColor = Colors.blue;
        break;
      default:
        backgroundColor = AppTheme.lightGrey;
        textColor = AppTheme.darkGrey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
