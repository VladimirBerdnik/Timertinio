import 'dart:convert';

import 'package:timertinio/modules/cart/data/OrderModel.dart';

class AppState {
  final Order order;

  AppState(this.order);

  AppState.emptyState() : order = Order();

  static AppState fromJson(dynamic json) => AppState(Order.fromJson(jsonDecode(json['order'])));

  dynamic toJson() => {'order': jsonEncode(order.toJson())};
}
