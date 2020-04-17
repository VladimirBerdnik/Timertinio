import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:timertinio/modules/cart/data/OrderItemModel.dart';
import 'package:timertinio/state/actions.dart';
import 'package:timertinio/state/state.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic>(
        converter: (store) => store,
        builder: (context, store) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 1.0,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.chevron_left),
                ),
                title: Text("Заказ на сумму " + store.state.order.getTotal().toString() + " руб.",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              body: ListView(children: <Widget>[
                ...store.state.order.orderItems
                    .toList()
                    .map((OrderItem item) => getCartProductWidget(context, store, item))
                // state.order.getItems
              ]));
        });
  }

  getCartProductWidget(context, store, OrderItem item) {
    final double productImageWidth = MediaQuery.of(context).size.width / 4;

    String packageDescription =
        item.product.package + " = " + item.product.unitsPerPackage.toInt().toString() + " " + item.product.unit;

    TextEditingController itemQuantityFieldController = TextEditingController();
    itemQuantityFieldController.text = item.quantity.toInt().toString();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(item.product.name, style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.remove_circle),
                            onPressed: () {
                              store.dispatch(ChangeQuantityAction(item.product, item.quantity - 1));
                              itemQuantityFieldController.text = item.quantity.toInt().toString();
                            }),
                        ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 30),
                            child: TextFormField(
                              controller: itemQuantityFieldController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              onEditingComplete: () {
                                store.dispatch(
                                    ChangeQuantityAction(item.product, double.parse(itemQuantityFieldController.text)));
                              },
                            )),
                        IconButton(
                            icon: Icon(Icons.add_circle),
                            onPressed: () {
                              // TODO optimize this ugly usage and code formatting
                              store.dispatch(ChangeQuantityAction(item.product, item.quantity + 1));
                              itemQuantityFieldController.text = item.quantity.toInt().toString();
                            }),
                      ],
                    ),
                  ],
                ),
                Image.asset(item.product.images.first, width: productImageWidth),
                IconButton(icon: Icon(Icons.delete), onPressed: () => {store.dispatch(RemoveItemAction(item.product))}),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(packageDescription + ", цена " + item.product.getPriceLabel()),
                Text(
                  item.getTotal().toInt().toString() + " руб.",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
