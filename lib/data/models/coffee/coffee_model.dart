class CoffeeModel {
  final String coffeeId;
  final String name;
  final String type;
  final String price;
  final String image;
  final String description;

  CoffeeModel({
    required this.coffeeId,
    required this.name,
    required this.type,
    required this.price,
    required this.image,
    required this.description,
  });

  CoffeeModel copyWith({
    String? coffeeId,
    String? name,
    String? type,
    String? price,
    String? image,
    String? description,
  }) {
    return CoffeeModel(
      coffeeId: coffeeId ?? this.coffeeId,
      name: name ?? this.name,
      type: type ?? this.type,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
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
    };
  }

  @override
  String toString() {
    return '''
    CoffeeModel{coffeeId: $coffeeId,
    name: $name,
    type: $type,
    price: $price,
    image: $image,
    description: $description
    ''';
  }
}
