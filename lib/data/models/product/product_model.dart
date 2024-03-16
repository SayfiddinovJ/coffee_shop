class ProductModel {
  final String productId;
  final String name;
  final String price;
  final String count;
  final String image;
  final String description;
  final String createdAt;
  final String piece;

  ProductModel({
    required this.productId,
    required this.name,
    required this.price,
    required this.count,
    required this.image,
    required this.description,
    required this.createdAt,
    required this.piece,
  });

  ProductModel copyWith({
    String? productId,
    String? name,
    String? price,
    String? count,
    String? image,
    String? description,
    String? createdAt,
    String? piece,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      count: count ?? this.count,
      image: image ?? this.image,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      piece: piece?? this.piece,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'] ?? '',
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      count: json['count'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['createdAt'] ?? '',
      piece: json['piece']?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'count': count,
      'image': image,
      'description': description,
      'createdAt': createdAt,
      'piece': piece,
    };
  }

  @override
  String toString() {
    return '''
    productId: $productId,
    name: $name,
    price: $price,
    count: $count,
    image: $image,
    description: $description
    createdAt: $createdAt
    piece: $piece
    ''';
  }
}
