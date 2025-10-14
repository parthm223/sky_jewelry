import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/product_model.dart';

class WishlistController extends GetxController {
  final _storage = GetStorage();
  final RxList<Product> _items = <Product>[].obs;

  List<Product> get items => _items;
  int get itemCount => _items.length;
  bool get isEmpty => _items.isEmpty;

  @override
  void onInit() {
    super.onInit();
    _loadWishlistFromStorage();
  }

  void _loadWishlistFromStorage() {
    final wishlistData = _storage.read('wishlist_items');
    if (wishlistData != null) {
      final List<dynamic> wishlistList = wishlistData;
      _items.value = wishlistList.map((item) => Product.fromJson(item)).toList();
    }
  }

  void _saveWishlistToStorage() {
    final wishlistData = _items.map((item) => item.toJson()).toList();
    _storage.write('wishlist_items', wishlistData);
  }

  void toggleWishlist(Product product) {
    if (isInWishlist(product.id)) {
      _items.removeWhere((item) => item.id == product.id);
      Get.snackbar(
        'Removed from Wishlist',
        '${product.name} removed from wishlist',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } else {
      _items.add(product);
      Get.snackbar(
        'Added to Wishlist',
        '${product.name} added to wishlist',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
    _saveWishlistToStorage();
  }

  bool isInWishlist(String productId) {
    return _items.any((item) => item.id == productId);
  }

  void clearWishlist() {
    _items.clear();
    _storage.remove('wishlist_items');
  }
}
