import 'package:timertinio/modules/cart/data/OrderModel.dart';
import 'package:timertinio/state/actions.dart';
import 'package:timertinio/state/state.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(orderReducer(state.order, action));
}

Order orderReducer(Order order, action) {
  if (action is AddItemAction) {
    return addItemReducer(order, action);
  } else if (action is RemoveItemAction) {
    return removeItemReducer(order, action);
  } else if (action is ChangeQuantityAction) {
    return changeQuantityReducer(order, action);
  }

  return order;
}

Order addItemReducer(Order order, AddItemAction action) {
  order.add(action.product, action.quantity);

  return order;
}

Order removeItemReducer(Order order, RemoveItemAction action) {
  order.remove(action.product);

  return order;
}

Order changeQuantityReducer(Order order, ChangeQuantityAction action) {
  order.changeQuantity(action.product, action.newQuantity);

  return order;
}
