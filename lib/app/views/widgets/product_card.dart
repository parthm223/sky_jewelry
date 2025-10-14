import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sky_jewelry/app/core/app_theme.dart';
import 'package:sky_jewelry/app/core/responsive_utils.dart';

import '../../models/product_model.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/wishlist_controller.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final wishlistController = Get.find<WishlistController>();

    return GestureDetector(
      onTap: onTap,
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      context.borderRadius(),
                    ), // Responsive border radius
                  ),
                  child: AspectRatio(
                    aspectRatio: context.isMobile
                        ? 1
                        : context.isLargeTablet
                        ? 1.1
                        : 1.2, // Responsive aspect ratio
                    child: CachedNetworkImage(
                      imageUrl: product.images.first,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppTheme.lightGrey,
                        child: const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppTheme.primaryGold,
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppTheme.lightGrey,
                        child: Icon(
                          Icons.image_not_supported,
                          size: context.iconSize(
                            mobile: 40,
                            tablet: 50,
                            desktop: 60,
                          ), // Responsive icon size
                          color: AppTheme.mediumGrey,
                        ),
                      ),
                    ),
                  ),
                ),

                // Discount Badge
                if (product.hasDiscount)
                  Positioned(
                    top: context.spacing(
                      mobile: 8,
                      tablet: 12,
                      desktop: 16,
                    ), // Responsive positioning
                    left: context.spacing(mobile: 8, tablet: 12, desktop: 16),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.spacing(
                          mobile: 6,
                          tablet: 8,
                          desktop: 10,
                        ), // Responsive padding
                        vertical: context.spacing(
                          mobile: 2,
                          tablet: 4,
                          desktop: 6,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGold,
                        borderRadius: BorderRadius.circular(
                          context.borderRadius(
                            mobile: 6,
                            tablet: 8,
                            desktop: 10,
                          ),
                        ),
                      ),
                      child: Text(
                        '${product.discountPercentage.toInt()}% OFF',
                        style: TextStyle(
                          color: AppTheme.premiumBlack,
                          fontSize: context.responsiveFontSize(
                            mobile: 9,
                            tablet: 10,
                            desktop: 11,
                          ), // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                // Wishlist Button
                Positioned(
                  top: context.spacing(
                    mobile: 8,
                    tablet: 12,
                    desktop: 16,
                  ), // Responsive positioning
                  right: context.spacing(mobile: 8, tablet: 12, desktop: 16),
                  child: Obx(
                    () => GestureDetector(
                      onTap: () => wishlistController.toggleWishlist(product),
                      child: Container(
                        padding: EdgeInsets.all(
                          context.spacing(mobile: 6, tablet: 8, desktop: 10),
                        ), // Responsive padding
                        decoration: BoxDecoration(
                          color: AppTheme.pureWhite.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          wishlistController.isInWishlist(product.id)
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: wishlistController.isInWishlist(product.id)
                              ? Colors.red
                              : AppTheme.darkGrey,
                          size: context.iconSize(
                            mobile: 18,
                            tablet: 20,
                            desktop: 22,
                          ), // Responsive icon size
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Product Details
            Padding(
              padding: context.responsiveMargin, // Responsive padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: context.responsiveFontSize(
                        mobile: 14,
                        tablet: 16,
                        desktop: 18,
                      ), // Responsive font size
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(
                    height: context.spacing(mobile: 2, tablet: 4, desktop: 6),
                  ), // Responsive spacing

                  Text(
                    product.category,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.mediumGrey,
                      fontSize: context.responsiveFontSize(
                        mobile: 12,
                        tablet: 14,
                        desktop: 16,
                      ), // Responsive font size
                    ),
                  ),

                  SizedBox(
                    height: context.spacing(mobile: 6, tablet: 8, desktop: 10),
                  ), // Responsive spacing
                  // Rating
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: product.rating,
                        itemBuilder: (context, index) =>
                            const Icon(Icons.star, color: AppTheme.primaryGold),
                        itemCount: 5,
                        itemSize: context.iconSize(
                          mobile: 14,
                          tablet: 16,
                          desktop: 18,
                        ), // Responsive star size
                      ),
                      SizedBox(
                        width: context.spacing(
                          mobile: 2,
                          tablet: 4,
                          desktop: 6,
                        ),
                      ), // Responsive spacing
                      Text(
                        '(${product.reviewCount})',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.mediumGrey,
                          fontSize: context.responsiveFontSize(
                            mobile: 10,
                            tablet: 12,
                            desktop: 14,
                          ), // Responsive font size
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: context.spacing(mobile: 8, tablet: 12, desktop: 16),
                  ), // Responsive spacing
                  // Price
                  Row(
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryGold,
                          fontSize: context.responsiveFontSize(
                            mobile: 16,
                            tablet: 18,
                            desktop: 20,
                          ), // Responsive font size
                        ),
                      ),
                      if (product.hasDiscount) ...[
                        SizedBox(
                          width: context.spacing(),
                        ), // Responsive spacing
                        Text(
                          '\$${product.originalPrice!.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: AppTheme.mediumGrey,
                                fontSize: context.responsiveFontSize(
                                  mobile: 12,
                                  tablet: 14,
                                  desktop: 16,
                                ), // Responsive font size
                              ),
                        ),
                      ],
                    ],
                  ),

                  SizedBox(
                    height: context.spacing(mobile: 8, tablet: 12, desktop: 16),
                  ), // Responsive spacing
                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    height: context.cardHeight(
                      mobile: 40,
                      tablet: 44,
                      desktop: 48,
                    ), // Responsive button height
                    child: ElevatedButton(
                      onPressed: () {
                        cartController.addToCart(product);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.premiumBlack,
                        foregroundColor: AppTheme.pureWhite,
                        padding: EdgeInsets.symmetric(
                          vertical: context.spacing(
                            mobile: 8,
                            tablet: 12,
                            desktop: 16,
                          ),
                        ), // Responsive padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            context.borderRadius(
                              mobile: 6,
                              tablet: 8,
                              desktop: 10,
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: context.responsiveFontSize(
                            mobile: 12,
                            tablet: 14,
                            desktop: 16,
                          ), // Responsive font size
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
