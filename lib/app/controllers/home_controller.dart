import 'package:get/get.dart';
import '../models/product_model.dart';

class HomeController extends GetxController {
  final RxList<Product> _featuredProducts = <Product>[].obs;
  final RxList<String> _banners = <String>[].obs;
  final RxList<String> _categories = <String>[].obs;
  final RxBool _isLoading = false.obs;

  List<Product> get featuredProducts => _featuredProducts;
  List<String> get banners => _banners;
  List<String> get categories => _categories;
  bool get isLoading => _isLoading.value;

  /// Fallback image for invalid/broken URLs
  static const String fallbackImage =
      "https://via.placeholder.com/500x500.png?text=No+Image";

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    try {
      _isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock banner data with safe image handling
      _banners.value = [
        _safeImage(
          'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=800',
        ),
        _safeImage(
          'https://images.unsplash.com/photo-1573408301185-9146fe634ad0?w=800',
        ),
        _safeImage(
          'https://images.unsplash.com/photo-1506630448388-4e683c67ddb0?w=800',
        ),
      ];

      _categories.value = [
        'Rings',
        'Earrings',
        'Necklaces',
        'Bracelets',
        'Watches',
        'Pendants',
      ];

      // Load featured products with safe images
      _featuredProducts.value = _getMockProducts();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load home data');
    } finally {
      _isLoading.value = false;
    }
  }

  List<Product> _getMockProducts() {
    return [
      Product(
        id: '1',
        name: 'Diamond Solitaire Ring',
        description:
            'Elegant 18k gold diamond solitaire ring with brilliant cut diamond',
        price: 2499.99,
        originalPrice: 2999.99,
        images: [
          _safeImage(
            'https://images.unsplash.com/photo-1605100804763-247f67b3557e',
          ),
          _safeImage(
            'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338',
          ),
        ],
        category: 'Rings',
        metalType: '18k Gold',
        stoneType: 'Diamond',
        rating: 4.8,
        reviewCount: 124,
        isInStock: true,
      ),
      Product(
        id: '2',
        name: 'Pearl Drop Earrings',
        description: 'Classic pearl drop earrings in sterling silver setting',
        price: 299.99,
        images: [
          _safeImage(
            'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908',
          ),
        ],
        category: 'Earrings',
        metalType: 'Sterling Silver',
        stoneType: 'Pearl',
        rating: 4.6,
        reviewCount: 89,
        isInStock: true,
      ),
      Product(
        id: '3',
        name: 'Gold Chain Necklace',
        description: 'Luxurious 22k gold chain necklace with intricate design',
        price: 1899.99,
        images: [
          _safeImage(
            'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f',
          ),
        ],
        category: 'Necklaces',
        metalType: '22k Gold',
        rating: 4.9,
        reviewCount: 156,
        isInStock: true,
      ),
      Product(
        id: '4',
        name: 'Tennis Bracelet',
        description: 'Sparkling diamond tennis bracelet in white gold',
        price: 3299.99,
        originalPrice: 3799.99,
        images: [
          _safeImage(
            'https://images.unsplash.com/photo-1611591437281-460bfbe1220a',
          ),
        ],
        category: 'Bracelets',
        metalType: 'White Gold',
        stoneType: 'Diamond',
        rating: 4.7,
        reviewCount: 67,
        isInStock: true,
      ),
      Product(
        id: '5',
        name: 'Luxury Gold Watch',
        description: '24k gold luxury men’s wristwatch with leather strap',
        price: 4999.99,
        images: [
          _safeImage(
            'https://5.imimg.com/data5/SELLER/Default/2021/1/CC/ZA/TW/93318731/chronograph-rose-gold-dial-rose-gold-tone-womens-watch-mk5896-500x500.jpg',
          ),
        ],
        category: 'Watches',
        metalType: '24k Gold',
        rating: 4.9,
        reviewCount: 210,
        isInStock: true,
      ),
      Product(
        id: '6',
        name: 'Heart Pendant Necklace',
        description: 'Romantic heart-shaped pendant with rose gold finish',
        price: 799.99,
        images: [
          _safeImage(
            'https://5.imimg.com/data5/SELLER/Default/2023/11/357542800/DJ/XC/UZ/183904499/unique-double-heart-pendant-necklace-for-women-and-girls-necklace-charms.jpeg',
          ),
        ],
        category: 'Pendants',
        metalType: 'Rose Gold',
        stoneType: 'Ruby',
        rating: 4.5,
        reviewCount: 72,
        isInStock: true,
      ),
      Product(
        id: '7',
        name: 'Emerald Stud Earrings',
        description: 'Elegant emerald gemstone stud earrings in gold setting',
        price: 1199.99,
        images: [
          _safeImage(
            'https://cdn.eternz.com/thumbnails/products/ZLSTD-1022-1_891f8eba_thumbnail_1024.jpg',
          ),
        ],
        category: 'Earrings',
        metalType: '14k Gold',
        stoneType: 'Emerald',
        rating: 4.7,
        reviewCount: 55,
        isInStock: true,
      ),
      Product(
        id: '8',
        name: 'Platinum Wedding Band',
        description: 'Simple yet timeless platinum wedding band',
        price: 1599.99,
        images: [
          _safeImage(
            'https://d17anp2eo56k6j.cloudfront.net/media/catalog/product/cache/ebf27a1c268f59435b925806ebd2433d/t/i/tiffany-co-baguette-and-round-diamond-platinum-wedding-band_2_110-1-10436.jpg',
          ),
        ],
        category: 'Rings',
        metalType: 'Platinum',
        rating: 4.8,
        reviewCount: 93,
        isInStock: true,
      ),
      Product(
        id: '9',
        name: 'Diamond Choker Necklace',
        description: 'Dazzling diamond-studded choker necklace',
        price: 5499.99,
        images: [
          _safeImage(
            'https://www.orra.co.in/media/catalog/product/c/s/csn23a25.jpg',
          ),
        ],
        category: 'Necklaces',
        metalType: 'White Gold',
        stoneType: 'Diamond',
        rating: 4.9,
        reviewCount: 145,
        isInStock: true,
      ),
      Product(
        id: '10',
        name: 'Sapphire Bracelet',
        description: 'Blue sapphire bracelet in sterling silver design',
        price: 1299.99,
        images: [
          _safeImage(
            'https://mrdappers.in/cdn/shop/files/513VKWp2R6L._AC_UY1000.jpg?v=1745229678',
          ),
        ],
        category: 'Bracelets',
        metalType: 'Sterling Silver',
        stoneType: 'Sapphire',
        rating: 4.6,
        reviewCount: 60,
        isInStock: true,
      ),
    ];
  }

  /// Helper method: wraps image URLs with try-catch
  String _safeImage(String url) {
    try {
      if (url.isNotEmpty && Uri.tryParse(url)?.hasAbsolutePath == true) {
        return url;
      } else {
        return fallbackImage;
      }
    } catch (e) {
      return fallbackImage;
    }
  }
}
