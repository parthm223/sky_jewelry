import 'package:get/get.dart';
import '../models/metal_type.dart';
import '../models/product_model.dart';

class FilterController extends GetxController {
  final RxList<MetalType> selectedMetalTypes = <MetalType>[].obs;
  final RxDouble minPrice = 0.0.obs;
  final RxDouble maxPrice = 100000.0.obs;
  final RxString selectedCategory = ''.obs;

  void toggleMetalType(MetalType metalType) {
    if (selectedMetalTypes.contains(metalType)) {
      selectedMetalTypes.remove(metalType);
    } else {
      selectedMetalTypes.add(metalType);
    }
  }

  void clearMetalFilters() {
    selectedMetalTypes.clear();
  }

  void setPriceRange(double min, double max) {
    minPrice.value = min;
    maxPrice.value = max;
  }

  void setCategory(String category) {
    selectedCategory.value = category;
  }

  void clearAllFilters() {
    selectedMetalTypes.clear();
    minPrice.value = 0.0;
    maxPrice.value = 100000.0;
    selectedCategory.value = '';
  }

  List<Product> filterProducts(List<Product> products) {
    return products.where((product) {
      // Filter by metal type
      if (selectedMetalTypes.isNotEmpty) {
        bool hasMatchingMetal = selectedMetalTypes.any((metalType) =>
            product.metalType?.toLowerCase() == metalType.value);
        if (!hasMatchingMetal) return false;
      }

      // Filter by price range
      if (product.price < minPrice.value || product.price > maxPrice.value) {
        return false;
      }

      // Filter by category
      if (selectedCategory.isNotEmpty &&
          product.category.toLowerCase() != selectedCategory.value.toLowerCase()) {
        return false;
      }

      return true;
    }).toList();
  }
}
