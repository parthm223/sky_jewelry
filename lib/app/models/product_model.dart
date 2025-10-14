class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final List<String> images;
  final String category;
  final String metalType;
  final String? stoneType;
  final double rating;
  final int reviewCount;
  final bool isInStock;
  final Map<String, dynamic>? specifications;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.images,
    required this.category,
    required this.metalType,
    this.stoneType,
    required this.rating,
    required this.reviewCount,
    required this.isInStock,
    this.specifications,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      originalPrice: json['originalPrice']?.toDouble(),
      images: List<String>.from(json['images']),
      category: json['category'],
      metalType: json['metalType'],
      stoneType: json['stoneType'],
      rating: json['rating'].toDouble(),
      reviewCount: json['reviewCount'],
      isInStock: json['isInStock'],
      specifications: json['specifications'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'originalPrice': originalPrice,
      'images': images,
      'category': category,
      'metalType': metalType,
      'stoneType': stoneType,
      'rating': rating,
      'reviewCount': reviewCount,
      'isInStock': isInStock,
      'specifications': specifications,
    };
  }

  bool get hasDiscount => originalPrice != null && originalPrice! > price;
  double get discountPercentage =>
      hasDiscount ? ((originalPrice! - price) / originalPrice! * 100) : 0;
}
