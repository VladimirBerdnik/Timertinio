import 'package:timertinio/modules/catalogue/data/ProductModel.dart';

class AddItemAction {
  final Product product;
  final double quantity;

  AddItemAction(this.product, this.quantity);
}

class RemoveItemAction {
  final Product product;

  RemoveItemAction(this.product);
}

class ChangeQuantityAction {
  final Product product;
  final double newQuantity;

  ChangeQuantityAction(this.product, this.newQuantity);
}
