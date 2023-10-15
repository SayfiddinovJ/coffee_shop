class CoffeeModel {
  final String coffeeId;
  final String name;
  final String type;
  final String price;
  final String image;
  final String description;
  final String createdAt;

  CoffeeModel({
    required this.coffeeId,
    required this.name,
    required this.type,
    required this.price,
    required this.image,
    required this.description,
    required this.createdAt,
  });

  CoffeeModel copyWith({
    String? coffeeId,
    String? name,
    String? type,
    String? price,
    String? image,
    String? description,
    String? createdAt,
  }) {
    return CoffeeModel(
      coffeeId: coffeeId ?? this.coffeeId,
      name: name ?? this.name,
      type: type ?? this.type,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory CoffeeModel.fromJson(Map<String, dynamic> json) {
    return CoffeeModel(
      coffeeId: json['coffeeId'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      price: json['price'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coffeeId': coffeeId,
      'name': name,
      'type': type,
      'price': price,
      'image': image,
      'description': description,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return '''
    coffeeId: $coffeeId,
    name: $name,
    type: $type,
    price: $price,
    image: $image,
    description: $description
    createdAt: $createdAt
    ''';
  }
}
