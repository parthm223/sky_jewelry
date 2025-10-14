import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sky_jewelry/app/core/app_theme.dart';
import 'package:sky_jewelry/app/core/responsive_utils.dart';

import '../../controllers/auth_controller.dart';
import '../../routes/app_routes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return SizedBox(
      width: context.drawerWidth, // Responsive drawer width
      child: Drawer(
        backgroundColor: AppTheme.pureWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(
              context.borderRadius(mobile: 20, tablet: 24, desktop: 28),
            ), // Responsive border radius
          ),
        ),
        elevation: 16,
        child: Column(
          children: [
            Container(
              height: context.cardHeight(
                mobile: 200,
                tablet: 220,
                desktop: 250,
              ), // Responsive header height
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppTheme.primaryGold, AppTheme.darkGold],
                  stops: [0.0, 1.0],
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(
                    context.borderRadius(mobile: 20, tablet: 24, desktop: 28),
                  ), // Responsive border radius
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.darkGold.withOpacity(0.4),
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: context.responsivePadding, // Responsive padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.spacing()), // Responsive spacing
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppTheme.pureWhite.withOpacity(0.8),
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: context.iconSize(
                            mobile: 30,
                            tablet: 35,
                            desktop: 40,
                          ), // Responsive avatar size
                          backgroundColor: AppTheme.pureWhite,
                          child: Icon(
                            Icons.person,
                            size: context.iconSize(
                              mobile: 35,
                              tablet: 40,
                              desktop: 45,
                            ), // Responsive icon size
                            color: AppTheme.primaryGold,
                          ),
                        ),
                      ).animate().scale(delay: 200.ms, duration: 600.ms),
                      SizedBox(
                        height: context.spacing(
                          mobile: 16,
                          tablet: 20,
                          desktop: 24,
                        ),
                      ), // Responsive spacing
                      Obx(
                        () => Text(
                          authController.isLoggedIn
                              ? authController.userName.isNotEmpty
                                    ? authController.userName
                                    : 'User'
                              : 'Guest User',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: AppTheme.pureWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: context.responsiveFontSize(
                                  mobile: 20,
                                  tablet: 22,
                                  desktop: 24,
                                ), // Responsive font size
                              ),
                        ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
                      ),
                      SizedBox(
                        height: context.spacing(
                          mobile: 4,
                          tablet: 6,
                          desktop: 8,
                        ),
                      ), // Responsive spacing
                      Obx(
                        () => Text(
                          authController.isLoggedIn
                              ? authController.userEmail.isNotEmpty
                                    ? authController.userEmail
                                    : 'user@example.com'
                              : 'Login to access all features',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: AppTheme.pureWhite.withOpacity(0.9),
                                fontSize: context.responsiveFontSize(
                                  mobile: 12,
                                  tablet: 14,
                                  desktop: 16,
                                ), // Responsive font size
                              ),
                          overflow: TextOverflow.ellipsis,
                        ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
                      ),
                      SizedBox(
                        height: context.spacing(
                          mobile: 8,
                          tablet: 12,
                          desktop: 16,
                        ),
                      ), // Responsive spacing
                      if (authController.isLoggedIn)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.spacing(
                              mobile: 8,
                              tablet: 12,
                              desktop: 16,
                            ), // Responsive padding
                            vertical: context.spacing(
                              mobile: 2,
                              tablet: 4,
                              desktop: 6,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.pureWhite.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(
                              context.borderRadius(),
                            ),
                          ),
                          child: Text(
                            'Premium Member',
                            style: TextStyle(
                              color: AppTheme.pureWhite,
                              fontSize: context.responsiveFontSize(
                                mobile: 10,
                                tablet: 12,
                                desktop: 14,
                              ), // Responsive font size
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ).animate().slideX(delay: 800.ms, duration: 600.ms),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              child: Obx(
                () => ListView(
                  padding: EdgeInsets.symmetric(
                    vertical: context.spacing(
                      mobile: 12,
                      tablet: 16,
                      desktop: 20,
                    ), // Responsive padding
                    horizontal: context.spacing(),
                  ),
                  children: authController.isLoggedIn
                      ? _buildLoggedInMenu(context) // Pass context
                      : _buildGuestMenu(context), // Pass context
                ),
              ),
            ),

            Container(
              padding: context.responsiveMargin, // Responsive padding
              decoration: BoxDecoration(
                color: AppTheme.pureWhite,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade200, width: 1),
                ),
              ),
              child: Obx(
                () => authController.isLoggedIn
                    ? SizedBox(
                        height: context.cardHeight(
                          mobile: 45,
                          tablet: 50,
                          desktop: 55,
                        ), // Responsive button height
                        child: ElevatedButton.icon(
                          icon: Icon(
                            Icons.logout,
                            size: context.iconSize(
                              mobile: 18,
                              tablet: 20,
                              desktop: 22,
                            ), // Responsive icon size
                          ),
                          label: Text(
                            'Logout',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: context
                                  .responsiveFontSize(), // Responsive font size
                            ),
                          ),
                          onPressed: () {
                            Get.back();
                            authController.logout();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade50,
                            foregroundColor: Colors.red,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                context.borderRadius(),
                              ),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                            side: BorderSide(
                              color: Colors.red.shade100,
                              width: 1,
                            ),
                          ),
                        ),
                      ).animate().fadeIn(delay: 1000.ms, duration: 600.ms)
                    : Column(
                        children: [
                          SizedBox(
                            height: context.cardHeight(
                              mobile: 45,
                              tablet: 50,
                              desktop: 55,
                            ), // Responsive button height
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                                Get.toNamed(AppRoutes.login);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryGold,
                                foregroundColor: AppTheme.pureWhite,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    context.borderRadius(),
                                  ),
                                ),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: context
                                      .responsiveFontSize(), // Responsive font size
                                ),
                              ),
                            ),
                          ).animate().slideY(delay: 1000.ms, duration: 600.ms),
                          SizedBox(
                            height: context.spacing(
                              mobile: 8,
                              tablet: 12,
                              desktop: 16,
                            ),
                          ), // Responsive spacing
                          SizedBox(
                            height: context.cardHeight(
                              mobile: 45,
                              tablet: 50,
                              desktop: 55,
                            ), // Responsive button height
                            child: OutlinedButton(
                              onPressed: () {
                                Get.back();
                                Get.toNamed(AppRoutes.register);
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppTheme.primaryGold,
                                side: const BorderSide(
                                  color: AppTheme.primaryGold,
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    context.borderRadius(),
                                  ),
                                ),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: context
                                      .responsiveFontSize(), // Responsive font size
                                ),
                              ),
                            ),
                          ).animate().slideY(delay: 1200.ms, duration: 600.ms),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildLoggedInMenu(BuildContext context) {
    // Added context parameter
    return [
      _buildDrawerItem(
        context, // Pass context
        icon: Icons.home_rounded,
        title: 'Home',
        onTap: () {
          Get.back();
          Get.toNamed(AppRoutes.home);
        },
      ).animate().slideX(delay: 200.ms, duration: 400.ms),
      _buildDrawerItem(
        context, // Pass context
        icon: Icons.category_rounded,
        title: 'Categories',
        onTap: () {
          Get.back();
          Get.toNamed(AppRoutes.categories);
        },
      ).animate().slideX(delay: 250.ms, duration: 400.ms),
      _buildMetalsExpansionTile(
        context,
      ).animate().slideX(delay: 300.ms, duration: 400.ms), // Pass context
      _buildDrawerItem(
        context, // Pass context
        icon: Icons.favorite_rounded,
        title: 'Wishlist',
        onTap: () {
          Get.back();
          Get.toNamed(AppRoutes.wishlist);
        },
      ).animate().slideX(delay: 350.ms, duration: 400.ms),
      _buildDrawerItem(
        context, // Pass context
        icon: Icons.shopping_bag_rounded,
        title: 'My Cart',
        onTap: () {
          Get.back();
          Get.toNamed(AppRoutes.cart);
        },
      ).animate().slideX(delay: 400.ms, duration: 400.ms),
      _buildDrawerItem(
        context, // Pass context
        icon: Icons.receipt_long_rounded,
        title: 'My Orders',
        onTap: () {
          Get.back();
          Get.toNamed(AppRoutes.orders);
        },
      ).animate().slideX(delay: 450.ms, duration: 400.ms),
      _buildDrawerItem(
        context, // Pass context
        icon: Icons.person_rounded,
        title: 'Profile',
        onTap: () {
          Get.back();
          Get.toNamed(AppRoutes.profile);
        },
      ).animate().slideX(delay: 500.ms, duration: 400.ms),
      _buildDrawerItem(
        context, // Pass context
        icon: Icons.support_agent_rounded,
        title: 'Customer Support',
        onTap: () {
          Get.back();
          Get.toNamed(AppRoutes.support);
        },
      ).animate().slideX(delay: 550.ms, duration: 400.ms),
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing(
            mobile: 12,
            tablet: 16,
            desktop: 20,
          ), // Responsive padding
          vertical: context.spacing(),
        ),
        child: const Divider(height: 1, thickness: 1),
      ),
      _buildDrawerItem(
        context, // Pass context
        icon: Icons.settings_rounded,
        title: 'Settings',
        onTap: () {
          Get.back();
          Get.snackbar('Info', 'Settings coming soon!');
        },
      ).animate().slideX(delay: 600.ms, duration: 400.ms),
      _buildDrawerItem(
        context, // Pass context
        icon: Icons.help_rounded,
        title: 'Help & FAQ',
        onTap: () {
          Get.back();
          Get.snackbar('Info', 'Help section coming soon!');
        },
      ).animate().slideX(delay: 650.ms, duration: 400.ms),
      _buildPolicyExpansionTile(
        context,
      ).animate().slideX(delay: 700.ms, duration: 400.ms), // Pass context
    ];
  }

  List<Widget> _buildGuestMenu(BuildContext context) {
    // Added context parameter
    return [
      _buildDrawerItem(
        context, // Pass context
        icon: Icons.home_rounded,
        title: 'Home',
        onTap: () {
          Get.back();
          Get.toNamed(AppRoutes.home);
        },
      ).animate().slideX(delay: 200.ms, duration: 400.ms),
      _buildDrawerItem(
        context, // Pass context
        icon: Icons.category_rounded,
        title: 'Categories',
        onTap: () {
          Get.back();
          Get.toNamed(AppRoutes.categories);
        },
      ).animate().slideX(delay: 250.ms, duration: 400.ms),
      _buildMetalsExpansionTile(
        context,
      ).animate().slideX(delay: 300.ms, duration: 400.ms), // Pass context
      _buildDrawerItem(
        context, // Pass context
        icon: Icons.support_agent_rounded,
        title: 'Customer Support',
        onTap: () {
          Get.back();
          Get.toNamed(AppRoutes.support);
        },
      ).animate().slideX(delay: 350.ms, duration: 400.ms),
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing(
            mobile: 12,
            tablet: 16,
            desktop: 20,
          ), // Responsive padding
          vertical: context.spacing(),
        ),
        child: const Divider(height: 1, thickness: 1),
      ),
      _buildDrawerItem(
        context, // Pass context
        icon: Icons.help_rounded,
        title: 'Help & FAQ',
        onTap: () {
          Get.back();
          Get.snackbar('Info', 'Help section coming soon!');
        },
      ).animate().slideX(delay: 400.ms, duration: 400.ms),
      _buildPolicyExpansionTile(
        context,
      ).animate().slideX(delay: 450.ms, duration: 400.ms), // Pass context
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: context.spacing(
            mobile: 12,
            tablet: 16,
            desktop: 20,
          ), // Responsive margin
          vertical: context.spacing(),
        ),
        padding: EdgeInsets.all(
          context.spacing(mobile: 8, tablet: 12, desktop: 16),
        ), // Responsive padding
        decoration: BoxDecoration(
          color: AppTheme.primaryGold.withOpacity(0.1),
          borderRadius: BorderRadius.circular(context.borderRadius()),
        ),
        child: Text(
          'Login to access all features like wishlist, cart, and orders',
          style: TextStyle(
            color: AppTheme.darkGrey,
            fontStyle: FontStyle.italic,
            fontSize: context.responsiveFontSize(
              mobile: 11,
              tablet: 13,
              desktop: 15,
            ), // Responsive font size
          ),
          textAlign: TextAlign.center,
        ),
      ).animate().fadeIn(delay: 500.ms, duration: 600.ms),
    ];
  }

  Widget _buildPolicyExpansionTile(BuildContext context) {
    // Added context parameter
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.spacing(), // Responsive margin
        vertical: context.spacing(mobile: 2, tablet: 4, desktop: 6),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.borderRadius()),
        color: AppTheme.lightGrey.withOpacity(0.3),
      ),
      child: ExpansionTile(
        leading: Container(
          width: context.iconSize(
            mobile: 36,
            tablet: 40,
            desktop: 44,
          ), // Responsive container size
          height: context.iconSize(mobile: 36, tablet: 40, desktop: 44),
          decoration: BoxDecoration(
            color: AppTheme.primaryGold.withOpacity(0.1),
            borderRadius: BorderRadius.circular(
              context.borderRadius(mobile: 8, tablet: 10, desktop: 12),
            ),
          ),
          child: Icon(
            Icons.info_outline,
            color: AppTheme.primaryGold,
            size: context.iconSize(
              mobile: 18,
              tablet: 20,
              desktop: 22,
            ), // Responsive icon size
          ),
        ),
        title: Text(
          'Policies & Info',
          style: TextStyle(
            color: AppTheme.premiumBlack,
            fontWeight: FontWeight.w500,
            fontSize: context.responsiveFontSize(), // Responsive font size
          ),
        ),
        trailing: Icon(
          Icons.expand_more_rounded,
          color: Colors.grey.shade400,
          size: context.iconSize(), // Responsive icon size
        ),
        children: [
          _buildSubDrawerItem(
            context, // Pass context
            icon: Icons.business,
            title: 'About Us',
            color: Colors.blue,
            onTap: () {
              Get.back();
              Get.toNamed(AppRoutes.aboutUs);
            },
          ),
          _buildSubDrawerItem(
            context, // Pass context
            icon: Icons.privacy_tip,
            title: 'Privacy Policy',
            color: Colors.green,
            onTap: () {
              Get.back();
              Get.toNamed(AppRoutes.privacyPolicy);
            },
          ),
          _buildSubDrawerItem(
            context, // Pass context
            icon: Icons.assignment_return,
            title: 'Return & Refund',
            color: Colors.orange,
            onTap: () {
              Get.back();
              Get.toNamed(AppRoutes.returnRefundPolicy);
            },
          ),
          _buildSubDrawerItem(
            context, // Pass context
            icon: Icons.local_shipping,
            title: 'Shipping Policy',
            color: Colors.purple,
            onTap: () {
              Get.back();
              Get.toNamed(AppRoutes.shippingPolicy);
            },
          ),
          _buildSubDrawerItem(
            context, // Pass context
            icon: Icons.gavel,
            title: 'Terms & Conditions',
            color: Colors.red,
            onTap: () {
              Get.back();
              Get.toNamed(AppRoutes.termsConditions);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMetalsExpansionTile(BuildContext context) {
    // Added context parameter
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.spacing(), // Responsive margin
        vertical: context.spacing(mobile: 2, tablet: 4, desktop: 6),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.borderRadius()),
        color: AppTheme.lightGrey.withOpacity(0.3),
      ),
      child: ExpansionTile(
        leading: Container(
          width: context.iconSize(
            mobile: 36,
            tablet: 40,
            desktop: 44,
          ), // Responsive container size
          height: context.iconSize(mobile: 36, tablet: 40, desktop: 44),
          decoration: BoxDecoration(
            color: AppTheme.primaryGold.withOpacity(0.1),
            borderRadius: BorderRadius.circular(
              context.borderRadius(mobile: 8, tablet: 10, desktop: 12),
            ),
          ),
          child: Icon(
            Icons.diamond_rounded,
            color: AppTheme.primaryGold,
            size: context.iconSize(
              mobile: 18,
              tablet: 20,
              desktop: 22,
            ), // Responsive icon size
          ),
        ),
        title: Text(
          'Metal Types',
          style: TextStyle(
            color: AppTheme.premiumBlack,
            fontWeight: FontWeight.w500,
            fontSize: context.responsiveFontSize(), // Responsive font size
          ),
        ),
        trailing: Icon(
          Icons.expand_more_rounded,
          color: Colors.grey.shade400,
          size: context.iconSize(), // Responsive icon size
        ),
        children: [
          _buildSubDrawerItem(
            context, // Pass context
            icon: Icons.circle,
            title: 'Gold Collection',
            color: AppTheme.primaryGold,
            onTap: () {
              Get.back();
              Get.toNamed('/metals', arguments: 'gold');
            },
          ),
          _buildSubDrawerItem(
            context, // Pass context
            icon: Icons.circle,
            title: 'Silver Collection',
            color: Colors.grey[400]!,
            onTap: () {
              Get.back();
              Get.toNamed('/metals', arguments: 'silver');
            },
          ),
          _buildSubDrawerItem(
            context, // Pass context
            icon: Icons.circle,
            title: 'Platinum Collection',
            color: Colors.grey[600]!,
            onTap: () {
              Get.back();
              Get.toNamed('/metals', arguments: 'platinum');
            },
          ),
          _buildSubDrawerItem(
            context, // Pass context
            icon: Icons.circle,
            title: 'Rose Gold Collection',
            color: Colors.pink[300]!,
            onTap: () {
              Get.back();
              Get.toNamed('/metals', arguments: 'rose_gold');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, { // Added context parameter
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.spacing(), // Responsive margin
        vertical: context.spacing(mobile: 2, tablet: 4, desktop: 6),
      ),
      child: ListTile(
        leading: Container(
          width: context.iconSize(
            mobile: 36,
            tablet: 40,
            desktop: 44,
          ), // Responsive container size
          height: context.iconSize(mobile: 36, tablet: 40, desktop: 44),
          decoration: BoxDecoration(
            color: AppTheme.primaryGold.withOpacity(0.1),
            borderRadius: BorderRadius.circular(
              context.borderRadius(mobile: 8, tablet: 10, desktop: 12),
            ),
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryGold,
            size: context.iconSize(
              mobile: 18,
              tablet: 20,
              desktop: 22,
            ), // Responsive icon size
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: AppTheme.premiumBlack,
            fontWeight: FontWeight.w500,
            fontSize: context.responsiveFontSize(), // Responsive font size
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: Colors.grey.shade400,
          size: context.iconSize(), // Responsive icon size
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.spacing(mobile: 8, tablet: 12, desktop: 16),
        ), // Responsive padding
        visualDensity: const VisualDensity(vertical: -2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            context.borderRadius(mobile: 8, tablet: 10, desktop: 12),
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSubDrawerItem(
    BuildContext context, { // Added context parameter
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(
        left: context.spacing(
          mobile: 12,
          tablet: 16,
          desktop: 20,
        ), // Responsive margin
        right: context.spacing(),
        bottom: context.spacing(mobile: 2, tablet: 4, desktop: 6),
      ),
      child: ListTile(
        leading: Container(
          width: context.iconSize(
            mobile: 28,
            tablet: 32,
            desktop: 36,
          ), // Responsive container size
          height: context.iconSize(mobile: 28, tablet: 32, desktop: 36),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(
              context.borderRadius(mobile: 6, tablet: 8, desktop: 10),
            ),
          ),
          child: Icon(
            icon,
            color: color,
            size: context.iconSize(
              mobile: 14,
              tablet: 16,
              desktop: 18,
            ), // Responsive icon size
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: AppTheme.darkGrey,
            fontWeight: FontWeight.w400,
            fontSize: context.responsiveFontSize(
              mobile: 12,
              tablet: 14,
              desktop: 16,
            ), // Responsive font size
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: Colors.grey.shade300,
          size: context.iconSize(
            mobile: 14,
            tablet: 16,
            desktop: 18,
          ), // Responsive icon size
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.spacing(mobile: 6, tablet: 8, desktop: 10),
        ), // Responsive padding
        visualDensity: const VisualDensity(vertical: -4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            context.borderRadius(mobile: 6, tablet: 8, desktop: 10),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
