import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sky_jewelry/app/core/app_theme.dart';
import 'package:sky_jewelry/app/core/responsive_utils.dart';

class PaymentMethodView extends StatelessWidget {
  const PaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    final methods = [
      {
        'brand': 'Visa',
        'last4': '4242',
        'holder': 'John Doe',
        'exp': '08/27',
        'isDefault': true,
      },
      {
        'brand': 'Mastercard',
        'last4': '5454',
        'holder': 'John Doe',
        'exp': '11/26',
        'isDefault': false,
      },
      {
        'brand': 'Apple Pay',
        'last4': '••••',
        'holder': 'John’s iPhone',
        'exp': '',
        'isDefault': false,
      },
    ];

    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(
        toolbarHeight: context.appBarHeight,
        title: Text(
          'Payment Methods',
          style: TextStyle(
            fontSize: context.responsiveFontSize(
              mobile: 20,
              tablet: 22,
              desktop: 24,
            ),
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.primaryGold,
        foregroundColor: AppTheme.pureWhite,
        onPressed: () => Get.snackbar(
          'Add Payment Method',
          'Payment method flow coming soon',
        ),
        icon: const Icon(Icons.add_card_outlined),
        label: Text(
          'Add New',
          style: TextStyle(
            fontSize: context.responsiveFontSize(
              mobile: 14,
              tablet: 16,
              desktop: 18,
            ),
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: context.isDesktop ? 800 : double.infinity,
          ),
          child: ListView.separated(
            padding: context.responsivePadding,
            itemBuilder: (ctx, i) => _PaymentCard(
              data: methods[i],
            ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.15, end: 0),
            separatorBuilder: (_, __) => SizedBox(
              height: context.spacing(mobile: 12, tablet: 16, desktop: 20),
            ),
            itemCount: methods.length,
          ),
        ),
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  const _PaymentCard({required this.data});
  final Map<String, dynamic> data;

  IconData _brandIcon(String brand) {
    switch (brand.toLowerCase()) {
      case 'visa':
        return Icons.credit_card;
      case 'mastercard':
        return Icons.credit_score_outlined;
      case 'apple pay':
        return Icons.phone_iphone;
      default:
        return Icons.credit_card;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDefault = data['isDefault'] == true;
    final brand = (data['brand'] ?? '').toString();

    return Container(
      padding: context.responsivePadding,
      decoration: BoxDecoration(
        color: AppTheme.pureWhite,
        borderRadius: BorderRadius.circular(context.borderRadius()),
        border: Border.all(
          color: isDefault ? AppTheme.primaryGold : AppTheme.lightGrey,
          width: isDefault ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.premiumBlack.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(
                  context.spacing(mobile: 8, tablet: 10, desktop: 12),
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGold.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(context.borderRadius()),
                ),
                child: Icon(
                  _brandIcon(brand),
                  color: AppTheme.primaryGold,
                  size: context.iconSize(),
                ),
              ),
              SizedBox(
                width: context.spacing(mobile: 12, tablet: 16, desktop: 20),
              ),
              Expanded(
                child: Text(
                  '$brand ${isDefault ? "(Default)" : ""}',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: context.responsiveFontSize(
                      mobile: 16,
                      tablet: 18,
                      desktop: 20,
                    ),
                  ),
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  color: AppTheme.darkGrey,
                  size: context.iconSize(mobile: 18, tablet: 20, desktop: 22),
                ),
                onSelected: (v) => Get.snackbar('Action', v),
                itemBuilder: (_) => [
                  const PopupMenuItem(
                    value: 'Set as default',
                    child: Text('Set as default'),
                  ),
                  const PopupMenuItem(value: 'Remove', child: Text('Remove')),
                ],
              ),
            ],
          ),
          SizedBox(
            height: context.spacing(mobile: 10, tablet: 12, desktop: 14),
          ),
          // Details
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Card Holder',
                      style: TextStyle(
                        color: AppTheme.mediumGrey,
                        fontSize: context.responsiveFontSize(),
                      ),
                    ),
                    Text(
                      data['holder'] ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: context.responsiveFontSize(),
                      ),
                    ),
                  ],
                ),
              ),
              if ((data['last4'] ?? '').toString().isNotEmpty)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ending',
                        style: TextStyle(
                          color: AppTheme.mediumGrey,
                          fontSize: context.responsiveFontSize(),
                        ),
                      ),
                      Text(
                        '•••• ${data['last4']}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: context.responsiveFontSize(),
                        ),
                      ),
                    ],
                  ),
                ),
              if ((data['exp'] ?? '').toString().isNotEmpty)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Expiry',
                        style: TextStyle(
                          color: AppTheme.mediumGrey,
                          fontSize: context.responsiveFontSize(),
                        ),
                      ),
                      Text(
                        data['exp'],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: context.responsiveFontSize(),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
