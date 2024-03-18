import 'package:coffee_shop/data/models/product/product_model.dart';
import 'package:coffee_shop/data/models/status.dart';
import 'package:equatable/equatable.dart';

class ProductState extends Equatable {
  final String statusText;
  final ProductModel productModel;
  final List<ProductModel> products;
  final FormStatus status;

  const ProductState({
    required this.statusText,
    required this.productModel,
    required this.products,
    required this.status,
  });

  ProductState copyWith({
    String? statusText,
    int? count,
    ProductModel? productModel,
    List<ProductModel>? products,
    FormStatus? status,
  }) {
    return ProductState(
      statusText: statusText ?? this.statusText,
      productModel: productModel ?? this.productModel,
      products: products ?? this.products,
      status: status ?? this.status,
    );
  }

  String canRequest() {
    if (productModel.name.isEmpty) return 'Name';
    if (productModel.price.isEmpty) return 'Price';
    if (productModel.image.isEmpty) return 'Image';
    if (productModel.barcode.isEmpty) return 'Barcode';
    if (productModel.description.isEmpty) return 'Description';
    return '';
  }

  @override
  List<Object?> get props => [statusText, status, productModel, products];
}
