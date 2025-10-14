import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sky_jewelry/app/core/app_theme.dart';
import 'package:sky_jewelry/app/views/widgets/category_card.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Rings',
      'Earrings',
      'Necklaces',
      'Bracelets',
      'Watches',
      'Pendants',
      'Chains',
      'Bangles',
      'Anklets',
      'Brooches',
      'Cufflinks',
      'Charms',
    ];

    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(title: const Text('Categories'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Container(
              height: 120,
              child: CategoryCard(
                category: categories[index],
                onTap: () {
                  Get.snackbar(
                    'Category Selected',
                    '${categories[index]} products coming soon!',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
