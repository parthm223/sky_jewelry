import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sky_jewelry/app/controllers/wishlist_controller.dart';
import 'package:sky_jewelry/app/core/app_theme.dart';
import 'package:sky_jewelry/app/routes/app_routes.dart';
import 'package:sky_jewelry/app/views/widgets/product_card.dart';

class WishlistView extends GetView<WishlistController> {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(
        title: const Text('Wishlist'),
        centerTitle: true,
        actions: [
          Obx(
            () => controller.items.isNotEmpty
                ? TextButton(
                    onPressed: () {
                      Get.dialog(
                        AlertDialog(
                          title: const Text('Clear Wishlist'),
                          content: const Text(
                            'Are you sure you want to remove all items from your wishlist?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.clearWishlist();
                                Get.back();
                              },
                              child: const Text('Clear'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Clear All'),
                  )
                : const SizedBox(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isEmpty) {
          return _buildEmptyWishlist(context);
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            itemCount: controller.items.length,
            itemBuilder: (context, index) {
              final product = controller.items[index];
              return ProductCard(
                    product: product,
                    onTap: () =>
                        Get.toNamed(AppRoutes.product, arguments: product),
                  )
                  .animate(delay: (index * 100).ms)
                  .fadeIn(duration: 600.ms)
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1, 1),
                  );
            },
          ),
        );
      }),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildEmptyWishlist(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_outline,
            size: 100,
            color: AppTheme.mediumGrey,
          ).animate().scale(duration: 600.ms),

          const SizedBox(height: 24),

          Text(
            'Your wishlist is empty',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(color: AppTheme.darkGrey),
          ).animate().fadeIn(delay: 300.ms, duration: 600.ms),

          const SizedBox(height: 12),

          Text(
            'Save your favorite jewelry pieces here',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppTheme.mediumGrey),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 600.ms, duration: 600.ms),

          const SizedBox(height: 32),

          ElevatedButton(
                onPressed: () => Get.offAllNamed(AppRoutes.home),
                child: const Text('Explore Products'),
              )
              .animate()
              .fadeIn(delay: 900.ms, duration: 600.ms)
              .slideY(begin: 0.3, end: 0),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                Icons.home_outlined,
                'Home',
                false,
                () => Get.offAllNamed(AppRoutes.home),
              ),
              _buildNavItem(
                Icons.category_outlined,
                'Categories',
                false,
                () => Get.toNamed(AppRoutes.categories),
              ),
              _buildNavItem(Icons.favorite, 'Wishlist', true, () {}),
              _buildNavItem(
                Icons.person_outline,
                'Profile',
                false,
                () => Get.toNamed(AppRoutes.profile),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool isActive,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.primaryGold.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppTheme.primaryGold : AppTheme.darkGrey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? AppTheme.primaryGold : AppTheme.darkGrey,
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
