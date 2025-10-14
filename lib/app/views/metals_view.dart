import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sky_jewelry/app/controllers/metals_controller.dart';
import 'package:sky_jewelry/app/core/app_theme.dart';
import 'package:sky_jewelry/app/routes/app_routes.dart';
import 'package:sky_jewelry/app/views/widgets/product_card.dart';

class MetalsView extends GetView<MetalsController> {
  const MetalsView({super.key});

  @override
  Widget build(BuildContext context) {
    final String metalType = Get.arguments ?? 'gold';

    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(
        title: Text(
          '${metalType.toUpperCase()} COLLECTION',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _showFilterBottomSheet(context),
            icon: const Icon(Icons.filter_list_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGold),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMetalHeader(metalType),

              const SizedBox(height: 24),

              _buildMetalProperties(metalType),

              const SizedBox(height: 32),

              _buildProductsGrid(context, metalType),

              const SizedBox(height: 32),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildMetalHeader(String metalType) {
    final metalInfo = _getMetalInfo(metalType);

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: metalInfo['gradient'],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: metalInfo['gradient'][0].withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.pureWhite.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.diamond_rounded,
                  color: AppTheme.pureWhite,
                  size: 32,
                ),
              ).animate().scale(delay: 200.ms, duration: 600.ms),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      metalInfo['name'],
                      style: const TextStyle(
                        color: AppTheme.pureWhite,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
                    const SizedBox(height: 4),
                    Text(
                      metalInfo['subtitle'],
                      style: TextStyle(
                        color: AppTheme.pureWhite.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            metalInfo['description'],
            style: TextStyle(
              color: AppTheme.pureWhite.withOpacity(0.95),
              fontSize: 16,
              height: 1.5,
            ),
          ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
        ],
      ),
    );
  }

  Widget _buildMetalProperties(String metalType) {
    final properties = _getMetalProperties(metalType);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Properties & Care',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.premiumBlack,
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: properties.length,
            itemBuilder: (context, index) {
              final property = properties[index];
              return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.pureWhite,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.premiumBlack.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          property['icon'],
                          color: AppTheme.primaryGold,
                          size: 24,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          property['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppTheme.premiumBlack,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          property['value'],
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.darkGrey,
                          ),
                        ),
                      ],
                    ),
                  )
                  .animate(delay: (index * 100).ms)
                  .fadeIn(duration: 600.ms)
                  .scale(begin: const Offset(0.8, 0.8));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid(BuildContext context, String metalType) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Products',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.premiumBlack,
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
              TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.categories, arguments: metalType);
                },
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.getProductsByMetal(metalType).length,
            itemBuilder: (context, index) {
              final product = controller.getProductsByMetal(metalType)[index];
              return ProductCard(
                    product: product,
                    onTap: () {
                      Get.toNamed(AppRoutes.product, arguments: product);
                    },
                  )
                  .animate(delay: (index * 150).ms)
                  .fadeIn(duration: 600.ms)
                  .scale(begin: const Offset(0.8, 0.8));
            },
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.pureWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter Options',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.premiumBlack,
              ),
            ),
            const SizedBox(height: 20),
            // Add filter options here
            const Text('Price Range'),
            const Text('Jewelry Type'),
            const Text('Stone Type'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGold,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Apply Filters'),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getMetalInfo(String metalType) {
    switch (metalType.toLowerCase()) {
      case 'gold':
        return {
          'name': 'Gold Collection',
          'subtitle': 'Timeless Elegance',
          'description':
              'Discover our exquisite gold jewelry collection, crafted with the finest 18K and 22K gold. Each piece embodies luxury and sophistication.',
          'gradient': [AppTheme.primaryGold, AppTheme.darkGold],
        };
      case 'silver':
        return {
          'name': 'Silver Collection',
          'subtitle': 'Modern Sophistication',
          'description':
              'Explore our contemporary silver jewelry, featuring sterling silver pieces that blend modern design with classic appeal.',
          'gradient': [Colors.grey[400]!, Colors.grey[600]!],
        };
      case 'platinum':
        return {
          'name': 'Platinum Collection',
          'subtitle': 'Ultimate Luxury',
          'description':
              'Experience the pinnacle of luxury with our platinum collection. Rare, pure, and eternally beautiful.',
          'gradient': [Colors.grey[600]!, Colors.grey[800]!],
        };
      case 'rose_gold':
        return {
          'name': 'Rose Gold Collection',
          'subtitle': 'Romantic Charm',
          'description':
              'Fall in love with our rose gold pieces, where warm copper tones create romantic and feminine designs.',
          'gradient': [Colors.pink[300]!, Colors.pink[400]!],
        };
      default:
        return {
          'name': 'Metal Collection',
          'subtitle': 'Premium Quality',
          'description': 'Discover our premium metal jewelry collection.',
          'gradient': [AppTheme.primaryGold, AppTheme.darkGold],
        };
    }
  }

  List<Map<String, dynamic>> _getMetalProperties(String metalType) {
    switch (metalType.toLowerCase()) {
      case 'gold':
        return [
          {'icon': Icons.star, 'title': 'Purity', 'value': '18K - 22K'},
          {'icon': Icons.shield, 'title': 'Durability', 'value': 'Excellent'},
          {'icon': Icons.palette, 'title': 'Tarnish', 'value': 'Resistant'},
          {'icon': Icons.favorite, 'title': 'Hypoallergenic', 'value': 'Yes'},
        ];
      case 'silver':
        return [
          {'icon': Icons.star, 'title': 'Purity', 'value': '925 Sterling'},
          {'icon': Icons.shield, 'title': 'Durability', 'value': 'Good'},
          {'icon': Icons.palette, 'title': 'Maintenance', 'value': 'Regular'},
          {'icon': Icons.favorite, 'title': 'Affordable', 'value': 'Yes'},
        ];
      case 'platinum':
        return [
          {'icon': Icons.star, 'title': 'Purity', 'value': '95% Pure'},
          {'icon': Icons.shield, 'title': 'Durability', 'value': 'Superior'},
          {'icon': Icons.palette, 'title': 'Tarnish', 'value': 'Never'},
          {'icon': Icons.favorite, 'title': 'Rarity', 'value': 'Exclusive'},
        ];
      default:
        return [
          {'icon': Icons.star, 'title': 'Quality', 'value': 'Premium'},
          {'icon': Icons.shield, 'title': 'Crafted', 'value': 'Expertly'},
          {'icon': Icons.palette, 'title': 'Design', 'value': 'Unique'},
          {'icon': Icons.favorite, 'title': 'Warranty', 'value': 'Lifetime'},
        ];
    }
  }
}
