import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sky_jewelry/app/controllers/home_controller.dart';
import 'package:sky_jewelry/app/core/app_theme.dart';
import 'package:sky_jewelry/app/routes/app_routes.dart';
import 'package:sky_jewelry/app/views/widgets/product_card.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  final HomeController _homeController = Get.find<HomeController>();
  List<dynamic> _searchResults = [];
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    // Simulate search delay
    Future.delayed(const Duration(milliseconds: 500), () {
      final results = _homeController.featuredProducts
          .where(
            (product) =>
                product.name.toLowerCase().contains(query.toLowerCase()) ||
                product.category.toLowerCase().contains(query.toLowerCase()) ||
                product.metalType.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();

      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search jewelry...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: AppTheme.mediumGrey),
          ),
          style: Theme.of(context).textTheme.bodyLarge,
          onChanged: _performSearch,
        ),
        actions: [
          IconButton(
            onPressed: () {
              _searchController.clear();
              _performSearch('');
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filters
          Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('All', true),
                  const SizedBox(width: 8),
                  _buildFilterChip('Rings', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('Earrings', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('Necklaces', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('Bracelets', false),
                ],
              ),
            ),
          ),

          // Search Results
          Expanded(child: _buildSearchResults()),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        // Handle filter selection
        Get.snackbar('Filter', '$label filter selected');
      },
      selectedColor: AppTheme.primaryGold.withOpacity(0.2),
      checkmarkColor: AppTheme.primaryGold,
      labelStyle: TextStyle(
        color: isSelected ? AppTheme.primaryGold : AppTheme.darkGrey,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_isSearching) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGold),
        ),
      );
    }

    if (_searchController.text.isEmpty) {
      return _buildSearchSuggestions();
    }

    if (_searchResults.isEmpty) {
      return _buildNoResults();
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final product = _searchResults[index];
          return ProductCard(
                product: product,
                onTap: () => Get.toNamed(AppRoutes.product, arguments: product),
              )
              .animate(delay: (index * 100).ms)
              .fadeIn(duration: 600.ms)
              .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
        },
      ),
    );
  }

  Widget _buildSearchSuggestions() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 80,
            color: AppTheme.mediumGrey,
          ).animate().scale(duration: 600.ms),

          const SizedBox(height: 24),

          Text(
            'Search for jewelry',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(color: AppTheme.darkGrey),
          ).animate().fadeIn(delay: 300.ms, duration: 600.ms),

          const SizedBox(height: 12),

          Text(
            'Try searching for rings, earrings, necklaces...',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppTheme.mediumGrey),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
        ],
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: AppTheme.mediumGrey,
          ).animate().scale(duration: 600.ms),

          const SizedBox(height: 24),

          Text(
            'No results found',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(color: AppTheme.darkGrey),
          ).animate().fadeIn(delay: 300.ms, duration: 600.ms),

          const SizedBox(height: 12),

          Text(
            'Try different keywords or browse categories',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppTheme.mediumGrey),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
        ],
      ),
    );
  }
}
