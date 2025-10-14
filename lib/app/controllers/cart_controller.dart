import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartController extends GetxController {
  final _storage = GetStorage();
  final RxList<CartItem> _items = <CartItem>[].obs;
  final RxBool _isLoading = false.obs;

  List<CartItem> get items => _items;
  bool get isLoading => _isLoading.value;
  int get itemCount => _items.length;
  double get totalAmount => _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  bool get isEmpty => _items.isEmpty;

  @override
  void onInit() {
    super.onInit();
    _loadCartFromStorage();
  }

  void _loadCartFromStorage() {
    final cartData = _storage.read('cart_items');
    if (cartData != null) {
      final List<dynamic> cartList = cartData;
      _items.value = cartList.map((item) => CartItem.fromJson(item)).toList();
    }
  }

  void _saveCartToStorage() {
    final cartData = _items.map((item) => item.toJson()).toList();
    _storage.write('cart_items', cartData);
  }

  void addToCart(Product product, {int quantity = 1}) {
    final existingIndex = _items.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex != -1) {
      _items[existingIndex].quantity += quantity;
    } else {
      final cartItem = CartItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        product: product,
        quantity: quantity,
        addedAt: DateTime.now(),
      );
      _items.add(cartItem);
    }
    
    _saveCartToStorage();
    Get.snackbar(
      'Added to Cart',
      '${product.name} added to cart',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void removeFromCart(String itemId) {
    _items.removeWhere((item) => item.id == itemId);
    _saveCartToStorage();
  }

  void updateQuantity(String itemId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(itemId);
      return;
    }
    
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      _items[index].quantity = quantity;
      _saveCartToStorage();
    }
  }

  void clearCart() {
    _items.clear();
    _storage.remove('cart_items');
  }

  bool isInCart(String productId) {
    return _items.any((item) => item.product.id == productId);
  }

  int getQuantity(String productId) {
    final item = _items.firstWhereOrNull((item) => item.product.id == productId);
    return item?.quantity ?? 0;
  }
}
