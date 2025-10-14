import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sky_jewelry/app/core/app_theme.dart';
import 'package:sky_jewelry/app/core/responsive_utils.dart';

class AddressesView extends StatelessWidget {
  const AddressesView({super.key});

  @override
  Widget build(BuildContext context) {
    final shippingAddresses = [
      {
        'name': 'Home',
        'recipient': 'John Doe',
        'line1': '123 Gold Street',
        'line2': 'Apt 4B',
        'city': 'Dubai',
        'country': 'UAE',
        'phone': '+971 50 123 4567',
        'isDefault': true,
        'type': 'shipping',
      },
      {
        'name': 'Office',
        'recipient': 'John Doe',
        'line1': '45 Diamond Avenue',
        'line2': 'Floor 9',
        'city': 'Abu Dhabi',
        'country': 'UAE',
        'phone': '+971 50 987 6543',
        'isDefault': false,
        'type': 'shipping',
      },
    ];

    final billingAddresses = [
      {
        'name': 'Primary Billing',
        'recipient': 'John Doe',
        'line1': '123 Gold Street',
        'line2': 'Apt 4B',
        'city': 'Dubai',
        'country': 'UAE',
        'phone': '+971 50 123 4567',
        'isDefault': true,
        'type': 'billing',
      },
    ];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(
        toolbarHeight: context.appBarHeight,
        title: Text(
          'Addresses',
          style: TextStyle(
            fontSize: context.responsiveFontSize(
              mobile: 20,
              tablet: 22,
              desktop: 24,
            ),
            fontWeight: FontWeight.w700,
            color: AppTheme.premiumBlack,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.pureWhite,
        elevation: 2,
        shadowColor: AppTheme.premiumBlack.withOpacity(0.1),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
      body: CustomScrollView(
        slivers: [
          // Shipping Addresses Section
          SliverPadding(
            padding: EdgeInsets.only(
              top: context.spacing(mobile: 16, tablet: 20, desktop: 24),
            ),
            sliver: SliverToBoxAdapter(
              child: _buildSectionHeader(
                context,
                title: 'Shipping Addresses',
                subtitle: 'Your delivery locations',
                icon: Icons.local_shipping_outlined,
              ),
            ),
          ),
          SliverPadding(
            padding: context.responsivePadding.copyWith(
              top: context.spacing(mobile: 12, tablet: 16, desktop: 20),
              bottom: context.spacing(mobile: 16, tablet: 20, desktop: 24),
            ),
            sliver: SliverList.separated(
              itemCount: shippingAddresses.length,
              separatorBuilder: (_, __) => SizedBox(
                height: context.spacing(mobile: 12, tablet: 16, desktop: 20),
              ),
              itemBuilder: (ctx, i) => _AddressCard(
                data: shippingAddresses[i],
                addressType: 'shipping',
              ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.15, end: 0),
            ),
          ),

          // Billing Addresses Section
          SliverToBoxAdapter(
            child: _buildSectionHeader(
              context,
              title: 'Billing Addresses',
              subtitle: 'Your billing locations',
              icon: Icons.receipt_long_outlined,
            ),
          ),
          SliverPadding(
            padding: context.responsivePadding.copyWith(
              top: context.spacing(mobile: 12, tablet: 16, desktop: 20),
              bottom: context.spacing(mobile: 16, tablet: 20, desktop: 24),
            ),
            sliver: billingAddresses.isEmpty
                ? SliverToBoxAdapter(child: _buildEmptyBillingAddress(context))
                : SliverList.separated(
                    itemCount: billingAddresses.length,
                    separatorBuilder: (_, __) => SizedBox(
                      height: context.spacing(
                        mobile: 12,
                        tablet: 16,
                        desktop: 20,
                      ),
                    ),
                    itemBuilder: (ctx, i) =>
                        _AddressCard(
                              data: billingAddresses[i],
                              addressType: 'billing',
                            )
                            .animate()
                            .fadeIn(duration: 400.ms)
                            .slideX(begin: 0.15, end: 0),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
          backgroundColor: AppTheme.primaryGold,
          foregroundColor: AppTheme.premiumBlack,
          elevation: 4,
          onPressed: () => _showAddAddressBottomSheet(context),
          icon: Icon(
            Icons.add_location_alt_outlined,
            size: context.iconSize(mobile: 20, tablet: 22, desktop: 24),
          ),
          label: Text(
            'Add New Address',
            style: TextStyle(
              fontSize: context.responsiveFontSize(
                mobile: 14,
                tablet: 16,
                desktop: 18,
              ),
              fontWeight: FontWeight.w600,
            ),
          ),
        )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 2000.ms, delay: 1000.ms);
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Padding(
      padding: context.responsivePadding.copyWith(bottom: 0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(
              context.spacing(mobile: 10, tablet: 12, desktop: 14),
            ),
            decoration: BoxDecoration(
              color: AppTheme.primaryGold.withOpacity(0.1),
              borderRadius: BorderRadius.circular(context.borderRadius() * 1.5),
            ),
            child: Icon(
              icon,
              color: AppTheme.primaryGold,
              size: context.iconSize(mobile: 20, tablet: 22, desktop: 24),
            ),
          ),
          SizedBox(width: context.spacing(mobile: 12, tablet: 16, desktop: 20)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: context.responsiveFontSize(
                      mobile: 18,
                      tablet: 20,
                      desktop: 22,
                    ),
                    fontWeight: FontWeight.w700,
                    color: AppTheme.premiumBlack,
                  ),
                ),
                SizedBox(
                  height: context.spacing(mobile: 2, tablet: 3, desktop: 4),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: context.responsiveFontSize(
                      mobile: 12,
                      tablet: 13,
                      desktop: 14,
                    ),
                    color: AppTheme.darkGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyBillingAddress(BuildContext context) {
    return Container(
      padding: context.responsivePadding.copyWith(
        top: context.spacing(mobile: 24, tablet: 32, desktop: 40),
      ),
      decoration: BoxDecoration(
        color: AppTheme.pureWhite,
        borderRadius: BorderRadius.circular(context.borderRadius()),
        border: Border.all(color: AppTheme.lightGrey, width: 1),
      ),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: context.iconSize(mobile: 48, tablet: 56, desktop: 64),
            color: AppTheme.mediumGrey,
          ),
          SizedBox(
            height: context.spacing(mobile: 12, tablet: 16, desktop: 20),
          ),
          Text(
            'No Billing Address',
            style: TextStyle(
              fontSize: context.responsiveFontSize(
                mobile: 16,
                tablet: 18,
                desktop: 20,
              ),
              fontWeight: FontWeight.w600,
              color: AppTheme.premiumBlack,
            ),
          ),
          SizedBox(height: context.spacing(mobile: 6, tablet: 8, desktop: 10)),
          Text(
            'Add a billing address for your orders',
            style: TextStyle(
              fontSize: context.responsiveFontSize(
                mobile: 12,
                tablet: 13,
                desktop: 14,
              ),
              color: AppTheme.darkGrey,
            ),
          ),
          SizedBox(
            height: context.spacing(mobile: 16, tablet: 20, desktop: 24),
          ),
          ElevatedButton(
            onPressed: () =>
                _showAddAddressBottomSheet(context, isBilling: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGold,
              foregroundColor: AppTheme.premiumBlack,
              padding: EdgeInsets.symmetric(
                horizontal: context.spacing(
                  mobile: 20,
                  tablet: 24,
                  desktop: 28,
                ),
                vertical: context.spacing(mobile: 12, tablet: 14, desktop: 16),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.borderRadius()),
              ),
            ),
            child: Text(
              'Add Billing Address',
              style: TextStyle(
                fontSize: context.responsiveFontSize(
                  mobile: 14,
                  tablet: 15,
                  desktop: 16,
                ),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddAddressBottomSheet(
    BuildContext context, {
    bool isBilling = false,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.borderRadius() * 2),
        ),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: context.responsivePadding.copyWith(
            top: context.spacing(mobile: 20, tablet: 24, desktop: 28),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: context.spacing(mobile: 40, tablet: 48, desktop: 56),
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.lightGrey,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(
                height: context.spacing(mobile: 16, tablet: 20, desktop: 24),
              ),
              Row(
                children: [
                  Icon(
                    isBilling ? Icons.receipt_long : Icons.add_location_alt,
                    color: AppTheme.primaryGold,
                    size: context.iconSize(mobile: 24, tablet: 26, desktop: 28),
                  ),
                  SizedBox(
                    width: context.spacing(mobile: 12, tablet: 16, desktop: 20),
                  ),
                  Text(
                    'Add ${isBilling ? 'Billing' : 'Shipping'} Address',
                    style: TextStyle(
                      fontSize: context.responsiveFontSize(
                        mobile: 18,
                        tablet: 20,
                        desktop: 22,
                      ),
                      fontWeight: FontWeight.w700,
                      color: AppTheme.premiumBlack,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: context.spacing(mobile: 20, tablet: 24, desktop: 28),
              ),
              // Add your address form fields here
              _buildBottomSheetForm(context, isBilling: isBilling),
              SizedBox(
                height: context.spacing(mobile: 20, tablet: 24, desktop: 28),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: context.spacing(
                            mobile: 14,
                            tablet: 16,
                            desktop: 18,
                          ),
                        ),
                        side: BorderSide(color: AppTheme.mediumGrey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            context.borderRadius(),
                          ),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: context.responsiveFontSize(),
                          color: AppTheme.darkGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.spacing(mobile: 12, tablet: 16, desktop: 20),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        Get.snackbar(
                          'Success',
                          '${isBilling ? 'Billing' : 'Shipping'} address added successfully',
                          backgroundColor: AppTheme.primaryGold,
                          colorText: AppTheme.premiumBlack,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryGold,
                        foregroundColor: AppTheme.premiumBlack,
                        padding: EdgeInsets.symmetric(
                          vertical: context.spacing(
                            mobile: 14,
                            tablet: 16,
                            desktop: 18,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            context.borderRadius(),
                          ),
                        ),
                      ),
                      child: Text(
                        'Save Address',
                        style: TextStyle(
                          fontSize: context.responsiveFontSize(),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: context.spacing(mobile: 16, tablet: 20, desktop: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheetForm(BuildContext context, {bool isBilling = false}) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Address Name',
            hintText: 'e.g., Home, Office',
            prefixIcon: Icon(Icons.label_outline, color: AppTheme.primaryGold),
          ),
        ),
        SizedBox(height: context.spacing(mobile: 12, tablet: 16, desktop: 20)),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Full Name',
            hintText: 'Enter recipient name',
            prefixIcon: Icon(Icons.person_outline, color: AppTheme.primaryGold),
          ),
        ),
        SizedBox(height: context.spacing(mobile: 12, tablet: 16, desktop: 20)),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Address Line 1',
            hintText: 'Street address',
            prefixIcon: Icon(
              Icons.location_on_outlined,
              color: AppTheme.primaryGold,
            ),
          ),
        ),
        SizedBox(height: context.spacing(mobile: 12, tablet: 16, desktop: 20)),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Address Line 2',
            hintText: 'Apartment, suite, etc.',
            prefixIcon: Icon(
              Icons.location_city_outlined,
              color: AppTheme.primaryGold,
            ),
          ),
        ),
        SizedBox(height: context.spacing(mobile: 12, tablet: 16, desktop: 20)),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'City',
                  hintText: 'City',
                  prefixIcon: Icon(
                    Icons.location_city,
                    color: AppTheme.primaryGold,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: context.spacing(mobile: 12, tablet: 16, desktop: 20),
            ),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Country',
                  hintText: 'Country',
                  prefixIcon: Icon(Icons.public, color: AppTheme.primaryGold),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: context.spacing(mobile: 12, tablet: 16, desktop: 20)),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Phone Number',
            hintText: '+971 50 123 4567',
            prefixIcon: Icon(Icons.phone, color: AppTheme.primaryGold),
          ),
        ),
        if (!isBilling) ...[
          SizedBox(
            height: context.spacing(mobile: 12, tablet: 16, desktop: 20),
          ),
          Row(
            children: [
              Icon(Icons.star_border, color: AppTheme.primaryGold, size: 20),
              SizedBox(
                width: context.spacing(mobile: 8, tablet: 10, desktop: 12),
              ),
              Text(
                'Set as default shipping address',
                style: TextStyle(
                  fontSize: context.responsiveFontSize(),
                  color: AppTheme.darkGrey,
                ),
              ),
              const Spacer(),
              Switch(
                value: false,
                onChanged: (value) {},
                activeColor: AppTheme.primaryGold,
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({required this.data, required this.addressType});
  final Map<String, dynamic> data;
  final String addressType;

  @override
  Widget build(BuildContext context) {
    final isDefault = data['isDefault'] == true;
    final isBilling = addressType == 'billing';

    return Container(
      padding: context.responsivePadding,
      decoration: BoxDecoration(
        color: AppTheme.pureWhite,
        borderRadius: BorderRadius.circular(context.borderRadius()),
        border: Border.all(
          color: isDefault ? AppTheme.primaryGold : AppTheme.lightGrey,
          width: isDefault ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.premiumBlack.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(
                  context.spacing(mobile: 10, tablet: 12, desktop: 14),
                ),
                decoration: BoxDecoration(
                  color: isBilling
                      ? AppTheme.primaryGold.withOpacity(0.15)
                      : AppTheme.primaryGold.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(context.borderRadius()),
                ),
                child: Icon(
                  isBilling
                      ? Icons.receipt_long_outlined
                      : Icons.location_on_outlined,
                  color: AppTheme.primaryGold,
                  size: context.iconSize(mobile: 20, tablet: 22, desktop: 24),
                ),
              ),
              SizedBox(
                width: context.spacing(mobile: 12, tablet: 16, desktop: 20),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data['name']}',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: context.responsiveFontSize(
                          mobile: 16,
                          tablet: 18,
                          desktop: 20,
                        ),
                        color: AppTheme.premiumBlack,
                      ),
                    ),
                    if (isDefault) ...[
                      SizedBox(
                        height: context.spacing(
                          mobile: 2,
                          tablet: 3,
                          desktop: 4,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.spacing(
                            mobile: 8,
                            tablet: 10,
                            desktop: 12,
                          ),
                          vertical: context.spacing(
                            mobile: 2,
                            tablet: 3,
                            desktop: 4,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryGold.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppTheme.primaryGold,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'DEFAULT',
                          style: TextStyle(
                            fontSize: context.responsiveFontSize(
                              mobile: 10,
                              tablet: 11,
                              desktop: 12,
                            ),
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryGold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  color: AppTheme.darkGrey,
                  size: context.iconSize(mobile: 20, tablet: 22, desktop: 24),
                ),
                onSelected: (v) => Get.snackbar('Action', v),
                itemBuilder: (_) => [
                  const PopupMenuItem(value: 'Edit', child: Text('Edit')),
                  const PopupMenuItem(value: 'Delete', child: Text('Delete')),
                  if (!isDefault)
                    const PopupMenuItem(
                      value: 'Set as default',
                      child: Text('Set as default'),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: context.spacing(mobile: 12, tablet: 14, desktop: 16),
          ),
          // Address lines
          Text(
            data['recipient'],
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: context.responsiveFontSize(),
              color: AppTheme.premiumBlack,
            ),
          ),
          SizedBox(height: context.spacing(mobile: 4, tablet: 5, desktop: 6)),
          Text(
            '${data['line1']}, ${data['line2']}',
            style: TextStyle(
              color: AppTheme.darkGrey,
              fontSize: context.responsiveFontSize(),
            ),
          ),
          Text(
            '${data['city']}, ${data['country']}',
            style: TextStyle(
              color: AppTheme.darkGrey,
              fontSize: context.responsiveFontSize(),
            ),
          ),
          SizedBox(
            height: context.spacing(mobile: 10, tablet: 12, desktop: 14),
          ),
          Row(
            children: [
              Icon(
                Icons.phone_outlined,
                size: context.iconSize(mobile: 16, tablet: 18, desktop: 20),
                color: AppTheme.mediumGrey,
              ),
              SizedBox(
                width: context.spacing(mobile: 8, tablet: 10, desktop: 12),
              ),
              Text(
                data['phone'],
                style: TextStyle(
                  color: AppTheme.mediumGrey,
                  fontSize: context.responsiveFontSize(),
                ),
              ),
              const Spacer(),
              if (isBilling)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.spacing(
                      mobile: 8,
                      tablet: 10,
                      desktop: 12,
                    ),
                    vertical: context.spacing(mobile: 4, tablet: 5, desktop: 6),
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGold.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Billing',
                    style: TextStyle(
                      fontSize: context.responsiveFontSize(
                        mobile: 10,
                        tablet: 11,
                        desktop: 12,
                      ),
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryGold,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
