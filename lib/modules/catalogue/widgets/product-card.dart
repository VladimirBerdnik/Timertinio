import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:timertinio/modules/cart/data/OrderItemModel.dart';
import 'package:timertinio/modules/catalogue/data/ProductModel.dart';
import 'package:timertinio/modules/common/widgets/fullscreen-carousel.dart';
import 'package:timertinio/state/actions.dart' as CartActions;
import 'package:timertinio/state/state.dart';
import 'package:redux/redux.dart';

class ProductCard extends StatefulWidget {
  ProductCard(this.product);

  final Product product;

  @override
  State<StatefulWidget> createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard> {
  Product _product;

  @override
  void initState() {
    _product = widget.product;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double productImageWidth = MediaQuery.of(context).size.width / 2.5;

    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FullscreenCarousel(_product.name, _product.images)),
                );
              },
              child: Stack(alignment: Alignment.bottomRight, children: <Widget>[
                Image.asset(_product.images.first, width: productImageWidth),
                Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.zoom_in,
                      color: Colors.black38,
                    )),
              ])),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(_product.name),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _product.getPriceLabel(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    StoreConnector<AppState, Store>(
                        converter: (Store store) => store,
                        builder: (context, Store store) {
                          if (!store.state.order.hasProduct(_product)) {
                            return FlatButton(
                              child: Text("В заказ"),
                              color: Colors.black12,
                              onPressed: () {
                                store.dispatch(CartActions.AddItemAction(_product, 1.0));
                              },
                            );
                          }

                          OrderItem orderItem = store.state.order.getItemForProduct(_product);

                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.remove_circle),
                                  onPressed: () {
                                    if (orderItem.quantity == 1.0) {
                                      store.dispatch(CartActions.RemoveItemAction(_product));
                                    } else {
                                      store
                                          .dispatch(CartActions.ChangeQuantityAction(_product, orderItem.quantity - 1));
                                    }
                                  }),
                              Text(orderItem.quantity.toInt().toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              IconButton(
                                  icon: Icon(Icons.add_circle),
                                  onPressed: () {
                                    // TODO optimize this ugly usage and code formatting
                                    store.dispatch(CartActions.ChangeQuantityAction(_product, orderItem.quantity + 1));
                                  }),
                            ],
                          );
                        })
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
