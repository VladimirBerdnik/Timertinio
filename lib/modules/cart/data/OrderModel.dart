import 'package:timertinio/modules/cart/data/OrderItemModel.dart';
import 'package:timertinio/modules/catalogue/data/ProductModel.dart';

class Order {
  List<OrderItem> _orderItems = [];

  List<OrderItem> get orderItems => _orderItems;

  bool hasProduct(Product product) {
    return _orderItems.any((OrderItem item) => item.product.id == product.id);
  }

  void add(Product product, double quantity) {
    orderItems.add(OrderItem(product, quantity));
  }

  void changeQuantity(Product product, double newQuantity) {
    if (!hasProduct(product)) {
      add(product, newQuantity);

      return;
    }

    getItemForProduct(product).changeQuantity(newQuantity);
  }

  OrderItem getItemForProduct(Product product) {
    return _orderItems.firstWhere((OrderItem item) => item.product.id == product.id);
  }

  void remove(Product product) {
    _orderItems.removeWhere((OrderItem item) => item.product.id == product.id);
  }

  int getItemsCount() {
    return orderItems.length;
  }

  bool isEmpty() {
    return orderItems.isEmpty;
  }

  double getTotal() {
    double total = 0;
    _orderItems.forEach((OrderItem item) => {total = total + item.getTotal()});

    return total;
  }

  toJson() {
    List serializedItems = [];
    _orderItems.forEach((OrderItem item) {
      serializedItems.add(item.toJson());
    });

    return {'orderItems': serializedItems};
  }

  static Order fromJson(json) {
    Order order = Order();
    (json['orderItems'] as List).forEach((value) {
      order.add(Product.fromJson(value['product']), value['quantity'] as double);
    });

    return order;
  }
}
