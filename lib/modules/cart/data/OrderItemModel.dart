import 'dart:math';

import 'package:timertinio/modules/catalogue/data/ProductModel.dart';

class OrderItem {
  final Product _product;
  double _quantity;

  OrderItem(this._product, this._quantity);

  void changeQuantity(double newQuantity) {
    _quantity = max(newQuantity, 1.0);
  }

  double getTotal() {
    return _quantity * _product.unitsPerPackage * _product.pricePerUnit;
  }

  Product get product => _product;

  double get quantity => _quantity;

  toJson() {
    return {
      'product': _product.toJson(),
      'quantity': _quantity,
    };
  }

  static OrderItem fromJson(json) {
    return OrderItem(Product.fromJson(json['product']), json['quantity'] as double);
  }
}
