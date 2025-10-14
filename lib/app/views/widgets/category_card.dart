import 'package:flutter/material.dart';
import 'package:sky_jewelry/app/core/app_theme.dart';

class CategoryCard extends StatelessWidget {
  final String category;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: AppTheme.pureWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.premiumBlack.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppTheme.primaryGold.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getCategoryIcon(category),
                color: AppTheme.primaryGold,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'rings':
        return Icons.circle_outlined;
      case 'earrings':
        return Icons.hearing;
      case 'necklaces':
        return Icons.favorite_outline;
      case 'bracelets':
        return Icons.watch_outlined;
      case 'watches':
        return Icons.access_time;
      case 'pendants':
        return Icons.diamond_outlined;
      default:
        return Icons.diamond;
    }
  }
}
