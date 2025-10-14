import 'package:get/get.dart';
import '../models/product_model.dart';

class MetalsController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<Product> allProducts = <Product>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    loadMetalProducts();
  }

  Future<void> loadMetalProducts() async {
    try {
      isLoading.value = true;
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      allProducts.value = [
        Product(
          id: '1',
          name: 'Gold Diamond Ring',
          price: 25000,
          images: ['/placeholder.svg?height=300&width=300'],
          category: 'Rings',
          metalType: 'gold',
          stoneType: 'Diamond',
          description: 'Elegant 18K gold ring with premium diamonds',
          rating: 4.8,
          reviewCount: 124,
          isInStock: true,
        ),
        Product(
          id: '2',
          name: 'Silver Pearl Necklace',
          price: 8000,
          images: ['/placeholder.svg?height=300&width=300'],
          category: 'Necklaces',
          metalType: 'silver',
          stoneType: 'Pearl',
          description: 'Sterling silver necklace with cultured pearls',
          rating: 4.6,
          reviewCount: 89,
          isInStock: true,
        ),
        Product(
          id: '3',
          name: 'Platinum Engagement Ring',
          price: 45000,
          images: ['/placeholder.svg?height=300&width=300'],
          category: 'Rings',
          metalType: 'platinum',
          stoneType: 'Diamond',
          description: 'Luxury platinum ring with solitaire diamond',
          rating: 4.9,
          reviewCount: 67,
          isInStock: true,
        ),
        Product(
          id: '4',
          name: 'Rose Gold Earrings',
          price: 15000,
          images: ['/placeholder.svg?height=300&width=300'],
          category: 'Earrings',
          metalType: 'rose_gold',
          stoneType: 'Ruby',
          description: 'Delicate rose gold drop earrings with ruby accents',
          rating: 4.7,
          reviewCount: 156,
          isInStock: true,
        ),
        Product(
          id: '5',
          name: 'Gold Tennis Bracelet',
          price: 32000,
          images: ['/placeholder.svg?height=300&width=300'],
          category: 'Bracelets',
          metalType: 'gold',
          stoneType: 'Diamond',
          description: '18K gold tennis bracelet with brilliant cut diamonds',
          rating: 4.8,
          reviewCount: 92,
          isInStock: true,
        ),
        Product(
          id: '6',
          name: 'Silver Chain Necklace',
          price: 5500,
          images: ['/placeholder.svg?height=300&width=300'],
          category: 'Necklaces',
          metalType: 'silver',
          description: 'Classic sterling silver chain necklace',
          rating: 4.5,
          reviewCount: 203,
          isInStock: true,
        ),
      ];
      
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products');
    } finally {
      isLoading.value = false;
    }
  }

  List<Product> getProductsByMetal(String metalType) {
    return allProducts.where((product) => 
      product.metalType.toLowerCase() == metalType.toLowerCase()
    ).toList();
  }
}
