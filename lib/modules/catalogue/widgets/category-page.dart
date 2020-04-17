import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:timertinio/modules/cart/data/OrderModel.dart';
import 'package:timertinio/modules/cart/widgets/cart-page.dart';
import 'package:timertinio/modules/catalogue/data/CategoryModel.dart';
import 'package:timertinio/modules/catalogue/data/ProductModel.dart';
import 'package:timertinio/modules/catalogue/data/ProductsRepository.dart';
import 'package:timertinio/modules/catalogue/widgets/product-card.dart';
import 'package:timertinio/state/state.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage(this.category);

  final Category category;

  @override
  State<StatefulWidget> createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage> {
  Category _category;

  @override
  void initState() {
    _category = widget.category;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> products = ProductsRepository.fetchByCategory(_category);

    final topBar = new AppBar(
      centerTitle: true,
      elevation: 1.0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.chevron_left),
      ),
      title: Text(_category.name, style: TextStyle(fontWeight: FontWeight.bold)),
    );

    Widget getCategoryDescription(Category category) {
      MediaQueryData mediaQueryData = MediaQuery.of(context);
      Orientation orientation = mediaQueryData.orientation;
      double height =
          orientation == Orientation.landscape ? mediaQueryData.size.height / 3 : mediaQueryData.size.width / 2;

      return Column(
        children: <Widget>[
          CarouselSlider(
              enlargeCenterPage: true,
              height: height,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 2),
              items: category.images.map((image) {
                return Image.asset(image);
              }).toList()),
          ListTile(
            subtitle: Text(category.description),
          ),
        ],
      );
    }

    return Scaffold(
        appBar: topBar,
        body: ListView(children: <Widget>[
          getCategoryDescription(_category),
          Divider(),
          ...products.toList().map((product) => ProductCard(product)),
          Padding(
            padding: EdgeInsets.all(48),
          )
        ]),
        floatingActionButton: StoreConnector<AppState, Order>(
            converter: (store) => store.state.order,
            builder: (context, Order order) {
              return order.isEmpty()
                  ? SizedBox.shrink()
                  : Badge(
                      badgeContent: Text(order.getItemsCount().toString()),
                      child: FloatingActionButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CartPage()),
                            );
                          },
                          child: Icon(Icons.shopping_cart)),
                    );
            }));
  }
}
