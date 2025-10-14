import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sky_jewelry/app/controllers/cart_controller.dart';
import 'package:sky_jewelry/app/controllers/product_controller.dart';
import 'package:sky_jewelry/app/controllers/wishlist_controller.dart';
import 'package:sky_jewelry/app/core/app_theme.dart';
import 'package:sky_jewelry/app/core/responsive_utils.dart';
import 'package:sky_jewelry/app/models/product_model.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product = Get.arguments as Product;
    final cartController = Get.find<CartController>();
    final wishlistController = Get.find<WishlistController>();

    controller.setProduct(product);

    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: context.cardHeight(
              mobile: 350,
              tablet: 400,
              desktop: 500,
            ), // Responsive app bar height
            pinned: true,
            backgroundColor: AppTheme.pureWhite,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildImageGallery(
                context,
                product,
              ), // Pass context for responsive design
            ),
            actions: [
              Obx(
                () => IconButton(
                  onPressed: () => wishlistController.toggleWishlist(product),
                  icon: Icon(
                    wishlistController.isInWishlist(product.id)
                        ? Icons.favorite
                        : Icons.favorite_outline,
                    color: wishlistController.isInWishlist(product.id)
                        ? Colors.red
                        : AppTheme.premiumBlack,
                    size: context.iconSize(), // Responsive icon size
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  // Share functionality
                  Get.snackbar('Share', 'Share functionality coming soon!');
                },
                icon: Icon(
                  Icons.share,
                  size: context.iconSize(), // Responsive icon size
                ),
              ),
            ],
          ),

          // Product Details
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.pureWhite,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(
                    context.borderRadius(mobile: 20, tablet: 24, desktop: 28),
                  ), // Responsive border radius
                ),
              ),
              child: Padding(
                padding: context.responsivePadding, // Responsive padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name and Price
                    _buildProductHeader(context, product),

                    SizedBox(
                      height: context.spacing(
                        mobile: 16,
                        tablet: 20,
                        desktop: 24,
                      ),
                    ), // Responsive spacing
                    // Rating and Reviews
                    _buildRatingSection(context, product),

                    SizedBox(
                      height: context.spacing(
                        mobile: 14,
                        tablet: 18,
                        desktop: 22,
                      ),
                    ), // Responsive spacing
                    // Benefits Row
                    _buildBenefitsRow(context),

                    SizedBox(
                      height: context.spacing(
                        mobile: 20,
                        tablet: 24,
                        desktop: 28,
                      ),
                    ), // Responsive spacing
                    // Product Details
                    _buildProductDetails(context, product),

                    SizedBox(
                      height: context.spacing(
                        mobile: 20,
                        tablet: 24,
                        desktop: 28,
                      ),
                    ), // Responsive spacing
                    // Description
                    _buildDescription(context, product),

                    SizedBox(
                      height: context.spacing(
                        mobile: 20,
                        tablet: 24,
                        desktop: 28,
                      ),
                    ), // Responsive spacing
                    // Info Cards
                    _buildInfoCards(context),

                    SizedBox(
                      height: context.spacing(
                        mobile: 16,
                        tablet: 20,
                        desktop: 24,
                      ),
                    ), // Responsive spacing
                    // Collapsible Sections
                    _buildCollapsibleSections(context, product),

                    SizedBox(
                      height: context.spacing(
                        mobile: 16,
                        tablet: 20,
                        desktop: 24,
                      ),
                    ), // Responsive spacing
                    // Reviews Preview
                    _buildReviewsPreview(context, product),

                    SizedBox(
                      height: context.spacing(
                        mobile: 80,
                        tablet: 100,
                        desktop: 120,
                      ),
                    ), // Responsive space for bottom buttons
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(context, product, cartController),
    );
  }

  Widget _buildImageGallery(BuildContext context, Product product) {
    // Added context parameter
    return Stack(
      children: [
        PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: CachedNetworkImageProvider(product.images[index]),
              initialScale: PhotoViewComputedScale.contained,
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
            );
          },
          itemCount: product.images.length,
          loadingBuilder: (context, event) => const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGold),
            ),
          ),
          onPageChanged: (index) => controller.selectImage(index),
        ),

        // Image Indicators
        if (product.images.length > 1)
          Positioned(
            bottom: context.spacing(
              mobile: 16,
              tablet: 20,
              desktop: 24,
            ), // Responsive bottom position
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                product.images.length,
                (index) => Obx(
                  () => Container(
                    width: context.spacing(
                      mobile: 6,
                      tablet: 8,
                      desktop: 10,
                    ), // Responsive indicator size
                    height: context.spacing(mobile: 6, tablet: 8, desktop: 10),
                    margin: EdgeInsets.symmetric(
                      horizontal: context.spacing(
                        mobile: 2,
                        tablet: 4,
                        desktop: 6,
                      ),
                    ), // Responsive margin
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.selectedImageIndex == index
                          ? AppTheme.primaryGold
                          : AppTheme.pureWhite.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
          ),

        // Discount Badge
        if (product.hasDiscount)
          Positioned(
            top: context.spacing(
              mobile: 50,
              tablet: 60,
              desktop: 70,
            ), // Responsive top position
            left: context.spacing(
              mobile: 16,
              tablet: 20,
              desktop: 24,
            ), // Responsive left position
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.spacing(
                  mobile: 10,
                  tablet: 12,
                  desktop: 14,
                ), // Responsive padding
                vertical: context.spacing(mobile: 4, tablet: 6, desktop: 8),
              ),
              decoration: BoxDecoration(
                color: AppTheme.primaryGold,
                borderRadius: BorderRadius.circular(context.borderRadius()),
              ),
              child: Text(
                '${product.discountPercentage.toInt()}% OFF',
                style: TextStyle(
                  color: AppTheme.premiumBlack,
                  fontSize: context.responsiveFontSize(
                    mobile: 10,
                    tablet: 12,
                    desktop: 14,
                  ), // Responsive font size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

        // Thumbnail Strip
        if (product.images.length > 1)
          Positioned(
            bottom: context.spacing(mobile: 48, tablet: 56, desktop: 64),
            left: 0,
            right: 0,
            child: SizedBox(
              height: context.cardHeight(mobile: 54, tablet: 64, desktop: 72),
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: context.spacing(
                    mobile: 12,
                    tablet: 16,
                    desktop: 20,
                  ),
                ),
                scrollDirection: Axis.horizontal,
                itemCount: product.images.length,
                separatorBuilder: (_, __) => SizedBox(
                  width: context.spacing(mobile: 8, tablet: 10, desktop: 12),
                ),
                itemBuilder: (ctx, i) => Obx(() {
                  final isActive = controller.selectedImageIndex == i;
                  return GestureDetector(
                    onTap: () => controller.selectImage(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: context.cardHeight(
                        mobile: 54,
                        tablet: 64,
                        desktop: 72,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          context.borderRadius(
                            mobile: 8,
                            tablet: 10,
                            desktop: 12,
                          ),
                        ),
                        border: Border.all(
                          color: isActive
                              ? AppTheme.primaryGold
                              : AppTheme.pureWhite.withOpacity(0.6),
                          width: isActive ? 2 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.premiumBlack.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                        imageUrl: product.images[i],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProductHeader(BuildContext context, Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: context.responsiveFontSize(
              mobile: 24,
              tablet: 28,
              desktop: 32,
            ), // Responsive font size
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),

        SizedBox(height: context.spacing()), // Responsive spacing

        Text(
          product.category,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppTheme.mediumGrey,
            fontSize: context.responsiveFontSize(
              mobile: 16,
              tablet: 18,
              desktop: 20,
            ), // Responsive font size
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

        SizedBox(
          height: context.spacing(mobile: 12, tablet: 16, desktop: 20),
        ), // Responsive spacing

        Row(
              children: [
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppTheme.primaryGold,
                    fontWeight: FontWeight.bold,
                    fontSize: context.responsiveFontSize(
                      mobile: 26,
                      tablet: 30,
                      desktop: 34,
                    ), // Responsive font size
                  ),
                ),
                if (product.hasDiscount) ...[
                  SizedBox(
                    width: context.spacing(mobile: 8, tablet: 12, desktop: 16),
                  ), // Responsive spacing
                  Text(
                    '\$${product.originalPrice!.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      decoration: TextDecoration.lineThrough,
                      color: AppTheme.mediumGrey,
                      fontSize: context.responsiveFontSize(
                        mobile: 16,
                        tablet: 18,
                        desktop: 20,
                      ), // Responsive font size
                    ),
                  ),
                ],
              ],
            )
            .animate()
            .fadeIn(delay: 400.ms, duration: 600.ms)
            .slideX(begin: -0.3, end: 0),
      ],
    );
  }

  Widget _buildRatingSection(BuildContext context, Product product) {
    return Row(
      children: [
        RatingBarIndicator(
          rating: product.rating,
          itemBuilder: (context, index) =>
              const Icon(Icons.star, color: AppTheme.primaryGold),
          itemCount: 5,
          itemSize: context.iconSize(
            mobile: 18,
            tablet: 20,
            desktop: 22,
          ), // Responsive star size
        ),
        SizedBox(width: context.spacing()), // Responsive spacing
        Text(
          '${product.rating}',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: context.responsiveFontSize(
              mobile: 16,
              tablet: 18,
              desktop: 20,
            ), // Responsive font size
          ),
        ),
        SizedBox(width: context.spacing()), // Responsive spacing
        Text(
          '(${product.reviewCount} reviews)',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.mediumGrey,
            fontSize: context.responsiveFontSize(), // Responsive font size
          ),
        ),
      ],
    ).animate().fadeIn(delay: 600.ms, duration: 600.ms);
  }

  Widget _buildBenefitsRow(BuildContext context) {
    return ResponsiveUtils.getResponsiveLayout(
      context: context,
      mobile: Column(
        children: [
          _benefitPill(context, Icons.local_shipping_outlined, 'Free Shipping'),
          SizedBox(height: context.spacing(mobile: 8, tablet: 10, desktop: 12)),
          _benefitPill(context, Icons.repeat_outlined, '7-Day Easy Returns'),
          SizedBox(height: context.spacing(mobile: 8, tablet: 10, desktop: 12)),
          _benefitPill(
            context,
            Icons.verified_user_outlined,
            '1-Year Warranty',
          ),
        ],
      ),
      tablet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _benefitPill(
              context,
              Icons.local_shipping_outlined,
              'Free Shipping',
            ),
          ),
          SizedBox(width: context.spacing()),
          Expanded(
            child: _benefitPill(
              context,
              Icons.repeat_outlined,
              '7-Day Easy Returns',
            ),
          ),
          SizedBox(width: context.spacing()),
          Expanded(
            child: _benefitPill(
              context,
              Icons.verified_user_outlined,
              '1-Year Warranty',
            ),
          ),
        ],
      ),
      desktop: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _benefitPill(
              context,
              Icons.local_shipping_outlined,
              'Free Shipping',
            ),
          ),
          SizedBox(width: context.spacing()),
          Expanded(
            child: _benefitPill(
              context,
              Icons.repeat_outlined,
              '7-Day Easy Returns',
            ),
          ),
          SizedBox(width: context.spacing()),
          Expanded(
            child: _benefitPill(
              context,
              Icons.verified_user_outlined,
              '1-Year Warranty',
            ),
          ),
        ],
      ),
    );
  }

  Widget _benefitPill(BuildContext context, IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.spacing(mobile: 10, tablet: 12, desktop: 14),
        horizontal: context.spacing(mobile: 12, tablet: 16, desktop: 20),
      ),
      decoration: BoxDecoration(
        color: AppTheme.lightGrey,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppTheme.primaryGold.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: context.iconSize(mobile: 18, tablet: 20, desktop: 22),
            color: AppTheme.premiumBlack,
          ),
          SizedBox(width: context.spacing(mobile: 8, tablet: 10, desktop: 12)),
          Text(
            label,
            style: TextStyle(
              fontSize: context.responsiveFontSize(
                mobile: 12,
                tablet: 14,
                desktop: 16,
              ),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context, Product product) {
    return Container(
          padding: context.responsiveMargin, // Responsive padding
          decoration: BoxDecoration(
            color: AppTheme.lightGrey,
            borderRadius: BorderRadius.circular(context.borderRadius()),
          ),
          child: Column(
            children: [
              _buildDetailRow(
                context,
                'Metal Type',
                product.metalType,
              ), // Pass context
              if (product.stoneType != null) ...[
                SizedBox(
                  height: context.spacing(mobile: 8, tablet: 12, desktop: 16),
                ), // Responsive spacing
                _buildDetailRow(
                  context,
                  'Stone Type',
                  product.stoneType!,
                ), // Pass context
              ],
              SizedBox(
                height: context.spacing(mobile: 8, tablet: 12, desktop: 16),
              ), // Responsive spacing
              _buildDetailRow(
                context,
                'Availability',
                product.isInStock ? 'In Stock' : 'Out of Stock',
              ), // Pass context
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 800.ms, duration: 600.ms)
        .slideY(begin: 0.3, end: 0);
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    // Added context parameter
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppTheme.darkGrey,
            fontWeight: FontWeight.w500,
            fontSize: context.responsiveFontSize(), // Responsive font size
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: AppTheme.premiumBlack,
            fontWeight: FontWeight.w600,
            fontSize: context.responsiveFontSize(), // Responsive font size
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context, Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: context.responsiveFontSize(
              mobile: 20,
              tablet: 22,
              desktop: 24,
            ), // Responsive font size
          ),
        ),
        SizedBox(
          height: context.spacing(mobile: 8, tablet: 12, desktop: 16),
        ), // Responsive spacing
        Text(
          product.description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.6,
            fontSize: context.responsiveFontSize(
              mobile: 16,
              tablet: 18,
              desktop: 20,
            ), // Responsive font size
          ),
        ),
      ],
    ).animate().fadeIn(delay: 1000.ms, duration: 600.ms);
  }

  Widget _buildInfoCards(BuildContext context) {
    final delivery = _infoCard(
      context,
      icon: Icons.local_shipping_outlined,
      title: 'Delivery',
      subtitle: '3-5 business days',
      body:
          'Orders ship with tracking. Priority options available at checkout.',
    );
    final returns = _infoCard(
      context,
      icon: Icons.assignment_return_outlined,
      title: 'Returns',
      subtitle: 'Hassle-free returns',
      body:
          'Return unworn items within 7 days. Instant store credit available.',
    );

    return ResponsiveUtils.getResponsiveLayout(
      context: context,
      mobile: Column(
        children: [
          delivery,
          SizedBox(
            height: context.spacing(mobile: 12, tablet: 16, desktop: 20),
          ),
          returns,
        ],
      ),
      tablet: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: delivery),
          SizedBox(width: context.spacing(mobile: 12, tablet: 16, desktop: 20)),
          Expanded(child: returns),
        ],
      ),
      desktop: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: delivery),
          SizedBox(width: context.spacing(mobile: 12, tablet: 16, desktop: 20)),
          Expanded(child: returns),
        ],
      ),
    );
  }

  Widget _infoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String body,
  }) {
    return Container(
      padding: context.responsivePadding,
      decoration: BoxDecoration(
        color: AppTheme.pureWhite,
        borderRadius: BorderRadius.circular(context.borderRadius()),
        boxShadow: [
          BoxShadow(
            color: AppTheme.premiumBlack.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: AppTheme.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.primaryGold, size: context.iconSize()),
              SizedBox(width: context.spacing()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: context.responsiveFontSize(
                        mobile: 16,
                        tablet: 18,
                        desktop: 20,
                      ),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.mediumGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: context.spacing(mobile: 10, tablet: 12, desktop: 14),
          ),
          Text(body, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }

  Widget _buildCollapsibleSections(BuildContext context, Product product) {
    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.only(
              top: context.spacing(mobile: 8, tablet: 10, desktop: 12),
            ),
            title: Text(
              'Materials & Care',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: context.responsiveFontSize(
                  mobile: 16,
                  tablet: 18,
                  desktop: 20,
                ),
              ),
            ),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Crafted in ${product.metalType}. Store separately and avoid harsh chemicals for lasting shine.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.spacing(mobile: 8, tablet: 10, desktop: 12)),
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.only(
              top: context.spacing(mobile: 8, tablet: 10, desktop: 12),
            ),
            title: Text(
              'Size & Fit',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: context.responsiveFontSize(
                  mobile: 16,
                  tablet: 18,
                  desktop: 20,
                ),
              ),
            ),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Check our size guide to find your perfect fit. Adjustable options available for select pieces.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsPreview(BuildContext context, Product product) {
    return Container(
      padding: context.responsivePadding,
      decoration: BoxDecoration(
        color: AppTheme.pureWhite,
        border: Border.all(color: AppTheme.lightGrey),
        borderRadius: BorderRadius.circular(context.borderRadius()),
      ),
      child: Row(
        children: [
          Icon(
            Icons.reviews_outlined,
            color: AppTheme.primaryGold,
            size: context.iconSize(),
          ),
          SizedBox(width: context.spacing()),
          Expanded(
            child: Text(
              '${product.reviewCount} customer reviews',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          TextButton(
            onPressed: () =>
                Get.snackbar('Reviews', 'Reviews screen coming soon'),
            child: const Text('Read all'),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    Product product,
    CartController cartController,
  ) {
    return Container(
      padding: context.responsivePadding, // Responsive padding
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
        child: ResponsiveUtils.getResponsiveLayout(
          // Use responsive layout
          context: context,
          mobile: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    cartController.addToCart(product);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.premiumBlack,
                    foregroundColor: AppTheme.pureWhite,
                    padding: EdgeInsets.symmetric(
                      vertical: context.spacing(
                        mobile: 12,
                        tablet: 16,
                        desktop: 20,
                      ),
                    ), // Responsive padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        context.borderRadius(),
                      ),
                    ),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: context.responsiveFontSize(
                        mobile: 14,
                        tablet: 16,
                        desktop: 18,
                      ), // Responsive font size
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: context.spacing(mobile: 12, tablet: 16, desktop: 20),
              ), // Responsive spacing
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    cartController.addToCart(product);
                    Get.toNamed('/checkout');
                  },
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                      fontSize: context.responsiveFontSize(
                        mobile: 14,
                        tablet: 16,
                        desktop: 18,
                      ), // Responsive font size
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          tablet: Row(
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    cartController.addToCart(product);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.premiumBlack,
                    foregroundColor: AppTheme.pureWhite,
                    padding: EdgeInsets.symmetric(
                      vertical: context.spacing(
                        mobile: 12,
                        tablet: 16,
                        desktop: 20,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        context.borderRadius(),
                      ),
                    ),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: context.responsiveFontSize(
                        mobile: 14,
                        tablet: 16,
                        desktop: 18,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: context.spacing(mobile: 12, tablet: 16, desktop: 20),
              ),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    cartController.addToCart(product);
                    Get.toNamed('/checkout');
                  },
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                      fontSize: context.responsiveFontSize(
                        mobile: 14,
                        tablet: 16,
                        desktop: 18,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
