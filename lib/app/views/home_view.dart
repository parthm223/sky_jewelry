import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sky_jewelry/app/controllers/cart_controller.dart';
import 'package:sky_jewelry/app/controllers/home_controller.dart';
import 'package:sky_jewelry/app/core/app_theme.dart';
import 'package:sky_jewelry/app/routes/app_routes.dart';
import 'package:sky_jewelry/app/views/widgets/category_card.dart';
import 'package:sky_jewelry/app/views/widgets/custom_drawer.dart';
import 'package:sky_jewelry/app/views/widgets/product_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Text(
          'Purna Jewels',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.search),
            icon: const Icon(Icons.search),
          ),
          Obx(
            () => badges.Badge(
              badgeContent: Text(
                cartController.itemCount.toString(),
                style: const TextStyle(
                  color: AppTheme.pureWhite,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              showBadge: cartController.itemCount > 0,
              badgeStyle: const badges.BadgeStyle(
                badgeColor: AppTheme.primaryGold,
              ),
              child: IconButton(
                onPressed: () => Get.toNamed(AppRoutes.cart),
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGold),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.loadHomeData,
          color: AppTheme.primaryGold,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner Carousel
                _buildBannerCarousel(),

                const SizedBox(height: 32),

                // Categories Section
                _buildCategoriesSection(context),

                const SizedBox(height: 32),

                // Featured Products Section
                _buildFeaturedProductsSection(context),

                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBannerCarousel() {
    final RxInt currentIndex = 0.obs;

    return CarouselSlider(
      options: CarouselOptions(
        height: 270,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        enlargeCenterPage: true,
        viewportFraction: 1.5,
        onPageChanged: (index, reason) {
          currentIndex.value = index;
        },
      ),
      items: controller.banners.map((banner) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppTheme.premiumBlack.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Banner image
                Image.network(
                  banner,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppTheme.lightGrey,
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: AppTheme.mediumGrey,
                      ),
                    );
                  },
                ),

                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppTheme.premiumBlack.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),

                // ✅ Indicator dots on top of the image
                Positioned(
                  bottom: 12,
                  left: 0,
                  right: 0,
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.banners.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: currentIndex.value == index ? 12 : 8,
                          height: currentIndex.value == index ? 12 : 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentIndex.value == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: -0.2, end: 0);
  }

  Widget _buildCategoriesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.categories),
                child: const Text('View All'),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

        const SizedBox(height: 16),

        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              return CategoryCard(
                    category: controller.categories[index],
                    onTap: () => Get.toNamed(
                      AppRoutes.categories,
                      arguments: controller.categories[index],
                    ),
                  )
                  .animate(delay: (index * 100).ms)
                  .fadeIn(duration: 600.ms)
                  .slideX(begin: 0.3, end: 0);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedProductsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Featured Products',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ).animate().fadeIn(delay: 400.ms, duration: 600.ms),

        const SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.featuredProducts.length,
            itemBuilder: (context, index) {
              return ProductCard(
                    product: controller.featuredProducts[index],
                    onTap: () => Get.toNamed(
                      AppRoutes.product,
                      arguments: controller.featuredProducts[index],
                    ),
                  )
                  .animate(delay: (index * 150).ms)
                  .fadeIn(duration: 600.ms)
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1, 1),
                  );
            },
          ),
        ),
      ],
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
              _buildNavItem(Icons.home, 'Home', true, () {}),
              _buildNavItem(
                Icons.category_outlined,
                'Categories',
                false,
                () => Get.toNamed(AppRoutes.categories),
              ),
              _buildNavItem(
                Icons.favorite_outline,
                'Wishlist',
                false,
                () => Get.toNamed(AppRoutes.wishlist),
              ),
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
