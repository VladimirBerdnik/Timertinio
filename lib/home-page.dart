import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:timertinio/modules/cart/data/OrderModel.dart';
import 'package:timertinio/modules/cart/widgets/cart-page.dart';
import 'package:timertinio/modules/catalogue/widgets/categories-list-page.dart';
import 'package:timertinio/modules/home/widgets/contacts-page.dart';
import 'package:timertinio/modules/home/widgets/questions-page.dart';
import 'package:timertinio/state/state.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  static List<Widget> homeScreenPages = [
    CategoriesListPage(),
    QuestionsPage(),
    ContactsPage(),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _appBar = new AppBar(
    centerTitle: true,
    elevation: 1.0,
    title: Text("Пряники в Челябинске", style: TextStyle(fontWeight: FontWeight.bold)),
    actions: <Widget>[
      StoreConnector<AppState, Order>(
          converter: (store) => store.state.order,
          builder: (context, Order order) {
            // TODO refactor to simplify, maybe extract component to separate file
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );
                  },
                  child: Badge(
                    showBadge: !order.isEmpty(),
                    badgeContent: Text(order.getItemsCount().toString()),
                    child: Icon(Icons.shopping_cart),
                  )),
            );
          })
    ],
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _appBar,
      body: homeScreenPages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Категории")),
          BottomNavigationBarItem(icon: Icon(Icons.help), title: Text("Частые вопросы")),
          BottomNavigationBarItem(icon: Icon(Icons.info), title: Text("Контакты")),
        ],
      ),
    );
  }
}
