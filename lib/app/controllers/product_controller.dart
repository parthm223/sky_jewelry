import 'package:get/get.dart';
import '../models/product_model.dart';

class ProductController extends GetxController {
  final Rx<Product?> _currentProduct = Rx<Product?>(null);
  final RxInt _selectedImageIndex = 0.obs;
  final RxBool _isLoading = false.obs;

  Product? get currentProduct => _currentProduct.value;
  int get selectedImageIndex => _selectedImageIndex.value;
  bool get isLoading => _isLoading.value;

  void setProduct(Product product) {
    _currentProduct.value = product;
    _selectedImageIndex.value = 0;
  }

  void selectImage(int index) {
    _selectedImageIndex.value = index;
  }

  Future<void> loadProduct(String productId) async {
    try {
      _isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock product loading - in real app, fetch from API
      // For now, we'll use the product passed via arguments
    } catch (e) {
      Get.snackbar('Error', 'Failed to load product details');
    } finally {
      _isLoading.value = false;
    }
  }
}
