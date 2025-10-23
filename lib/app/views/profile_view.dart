import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sky_jewelry/app/controllers/auth_controller.dart';
import 'package:sky_jewelry/app/core/app_theme.dart';
import 'package:sky_jewelry/app/core/responsive_utils.dart';
import 'package:sky_jewelry/app/routes/app_routes.dart';

class ProfileView extends GetView<AuthController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(
        toolbarHeight: context.appBarHeight, // Responsive app bar height
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: context.responsiveFontSize(
              mobile: 20,
              tablet: 22,
              desktop: 24,
            ),
          ), // Responsive font size
        ),
        centerTitle: true,
      ),
      body: Center(
        // Added Center widget for better responsive centering
        child: ConstrainedBox(
          // Added ConstrainedBox for max width control
          constraints: BoxConstraints(
            maxWidth: context.isDesktop ? 600 : double.infinity,
          ),
          child: SingleChildScrollView(
            padding: context.responsivePadding, // Responsive padding
            child: Column(
              children: [
                // Profile Header
                _buildProfileHeader(context),

                SizedBox(
                  height: context.spacing(mobile: 24, tablet: 32, desktop: 40),
                ), // Responsive spacing
                // Menu Items
                _buildMenuItem(
                      context, // Pass context
                      icon: Icons.receipt_long_outlined,
                      title: 'My Orders',
                      subtitle: 'Track your orders',
                      onTap: () => Get.toNamed(AppRoutes.orders),
                    )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 600.ms)
                    .slideX(begin: 0.3, end: 0),

                SizedBox(
                  height: context.spacing(mobile: 12, tablet: 16, desktop: 20),
                ), // Responsive spacing

                _buildMenuItem(
                      context, // Pass context
                      icon: Icons.location_on_outlined,
                      title: 'Addresses',
                      subtitle: 'Manage delivery addresses',
                      onTap: () => Get.toNamed(
                        AppRoutes.addresses,
                      ), // Navigate to addresses screen
                    )
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 600.ms)
                    .slideX(begin: 0.3, end: 0),

                SizedBox(
                  height: context.spacing(mobile: 12, tablet: 16, desktop: 20),
                ), // Responsive spacing

                _buildMenuItem(
                      context, // Pass context
                      icon: Icons.payment_outlined,
                      title: 'Payment Methods',
                      subtitle: 'Manage payment options',
                      onTap: () => Get.toNamed(
                        AppRoutes.paymentMethods,
                      ), // Navigate to payment methods screen
                    )
                    .animate()
                    .fadeIn(delay: 600.ms, duration: 600.ms)
                    .slideX(begin: 0.3, end: 0),

                SizedBox(
                  height: context.spacing(mobile: 12, tablet: 16, desktop: 20),
                ), // Responsive spacing

                _buildMenuItem(
                      context, // Pass context
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      subtitle: 'Manage notifications',
                      onTap: () => Get.snackbar(
                        'Info',
                        'Notification settings coming soon!',
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 800.ms, duration: 600.ms)
                    .slideX(begin: 0.3, end: 0),

                SizedBox(
                  height: context.spacing(mobile: 12, tablet: 16, desktop: 20),
                ), // Responsive spacing

                _buildMenuItem(
                      context, // Pass context
                      icon: Icons.support_agent_outlined,
                      title: 'Customer Support',
                      subtitle: 'Get help and support',
                      onTap: () => Get.toNamed(AppRoutes.support),
                    )
                    .animate()
                    .fadeIn(delay: 1000.ms, duration: 600.ms)
                    .slideX(begin: 0.3, end: 0),

                SizedBox(
                  height: context.spacing(mobile: 12, tablet: 16, desktop: 20),
                ), // Responsive spacing

                _buildMenuItem(
                      context, // Pass context
                      icon: Icons.info_outline,
                      title: 'About',
                      subtitle: 'App information',
                      onTap: () => Get.toNamed(
                        AppRoutes.aboutUs,
                      ), // Navigate to about us page
                    )
                    .animate()
                    .fadeIn(delay: 1200.ms, duration: 600.ms)
                    .slideX(begin: 0.3, end: 0),

                SizedBox(
                  height: context.spacing(mobile: 24, tablet: 32, desktop: 40),
                ), // Responsive spacing
                // Logout Button
                SizedBox(
                      width: double.infinity,
                      height: context.cardHeight(
                        mobile: 50,
                        tablet: 56,
                        desktop: 62,
                      ), // Responsive button height
                      child: ElevatedButton(
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              title: Text(
                                'Logout',
                                style: TextStyle(
                                  fontSize: context.responsiveFontSize(
                                    mobile: 18,
                                    tablet: 20,
                                    desktop: 22,
                                  ),
                                ), // Responsive font size
                              ),
                              content: Text(
                                'Are you sure you want to logout?',
                                style: TextStyle(
                                  fontSize: context.responsiveFontSize(),
                                ), // Responsive font size
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontSize: context.responsiveFontSize(),
                                    ), // Responsive font size
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                    controller.logout();
                                  },
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontSize: context.responsiveFontSize(),
                                    ), // Responsive font size
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: AppTheme.pureWhite,
                          padding: EdgeInsets.symmetric(
                            vertical: context.spacing(
                              mobile: 12,
                              tablet: 16,
                              desktop: 20,
                            ),
                          ), // Responsive padding
                        ),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: context.responsiveFontSize(
                              mobile: 16,
                              tablet: 18,
                              desktop: 20,
                            ), // Responsive font size
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 1400.ms, duration: 600.ms)
                    .slideY(begin: 0.3, end: 0),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context), // Pass context
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
          padding: context.responsivePadding, // Responsive padding
          decoration: BoxDecoration(
            color: AppTheme.pureWhite,
            borderRadius: BorderRadius.circular(
              context.borderRadius(),
            ), // Responsive border radius
            boxShadow: [
              BoxShadow(
                color: AppTheme.premiumBlack.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: context.iconSize(
                      mobile: 40,
                      tablet: 50,
                      desktop: 60,
                    ), // Responsive avatar size
                    backgroundColor: AppTheme.primaryGold.withOpacity(0.1),
                    child: Icon(
                      Icons.person,
                      size: context.iconSize(
                        mobile: 40,
                        tablet: 50,
                        desktop: 60,
                      ), // Responsive icon size
                      color: AppTheme.primaryGold,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(
                        context.spacing(mobile: 3, tablet: 4, desktop: 5),
                      ), // Responsive padding
                      decoration: const BoxDecoration(
                        color: AppTheme.primaryGold,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.edit,
                        size: context.iconSize(
                          mobile: 14,
                          tablet: 16,
                          desktop: 18,
                        ), // Responsive icon size
                        color: AppTheme.premiumBlack,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: context.spacing(mobile: 12, tablet: 16, desktop: 20),
              ), // Responsive spacing

              Obx(
                () => Text(
                  controller.name.value.isNotEmpty
                      ? controller.name.value
                      : 'Guest User',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: context.responsiveFontSize(
                      mobile: 20,
                      tablet: 22,
                      desktop: 24,
                    ), // Responsive font size
                  ),
                ),
              ),

              SizedBox(
                height: context.spacing(mobile: 2, tablet: 4, desktop: 6),
              ), // Responsive spacing

              Obx(
                () => Text(
                  controller.email.value.isNotEmpty
                      ? controller.email.value
                      : 'guest@example.com',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.mediumGrey,
                    fontSize: context.responsiveFontSize(
                      mobile: 16,
                      tablet: 18,
                      desktop: 20,
                    ), // Responsive font size
                  ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1));
  }

  Widget _buildMenuItem(
    BuildContext context, { // Added context parameter
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: context.responsivePadding, // Responsive padding
        decoration: BoxDecoration(
          color: AppTheme.pureWhite,
          borderRadius: BorderRadius.circular(
            context.borderRadius(),
          ), // Responsive border radius
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
              padding: EdgeInsets.all(
                context.spacing(mobile: 10, tablet: 12, desktop: 14),
              ), // Responsive padding
              decoration: BoxDecoration(
                color: AppTheme.primaryGold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(context.borderRadius()),
              ),
              child: Icon(
                icon,
                color: AppTheme.primaryGold,
                size: context.iconSize(), // Responsive icon size
              ),
            ),

            SizedBox(
              width: context.spacing(mobile: 12, tablet: 16, desktop: 20),
            ), // Responsive spacing

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: context.responsiveFontSize(
                        mobile: 16,
                        tablet: 18,
                        desktop: 20,
                      ), // Responsive font size
                      fontWeight: FontWeight.w600,
                      color: AppTheme.premiumBlack,
                    ),
                  ),
                  SizedBox(
                    height: context.spacing(mobile: 2, tablet: 4, desktop: 6),
                  ), // Responsive spacing
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: context
                          .responsiveFontSize(), // Responsive font size
                      color: AppTheme.mediumGrey,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios,
              size: context.iconSize(
                mobile: 14,
                tablet: 16,
                desktop: 18,
              ), // Responsive icon size
              color: AppTheme.mediumGrey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    // Added context parameter
    return Container(
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing(
              mobile: 16,
              tablet: 20,
              desktop: 24,
            ), // Responsive padding
            vertical: context.spacing(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                Icons.home_outlined,
                'Home',
                false,
                () => Get.offAllNamed(AppRoutes.home),
              ), // Pass context
              _buildNavItem(
                context,
                Icons.category_outlined,
                'Categories',
                false,
                () => Get.toNamed(AppRoutes.categories),
              ), // Pass context
              _buildNavItem(
                context,
                Icons.favorite_outline,
                'Wishlist',
                false,
                () => Get.toNamed(AppRoutes.wishlist),
              ), // Pass context
              _buildNavItem(
                context,
                Icons.person,
                'Profile',
                true,
                () {},
              ), // Pass context
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    bool isActive,
    VoidCallback onTap,
  ) {
    // Added context parameter
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: context.spacing(),
          horizontal: context.spacing(
            mobile: 8,
            tablet: 12,
            desktop: 16,
          ), // Responsive padding
        ),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.primaryGold.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(context.borderRadius()),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppTheme.primaryGold : AppTheme.darkGrey,
              size: context.iconSize(), // Responsive icon size
            ),
            SizedBox(
              height: context.spacing(mobile: 2, tablet: 4, desktop: 6),
            ), // Responsive spacing
            Text(
              label,
              style: TextStyle(
                color: isActive ? AppTheme.primaryGold : AppTheme.darkGrey,
                fontSize: context.responsiveFontSize(
                  mobile: 10,
                  tablet: 12,
                  desktop: 14,
                ), // Responsive font size
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
