import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:timertinio/home-page.dart';
import 'package:timertinio/state/state.dart';
import 'package:timertinio/state/store.dart';
import 'package:redux/redux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Store store = await getStore();

  runApp(new MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final store;

  const MyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: new MaterialApp(
        title: 'Timertinio',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            primaryColor: Colors.black,
            accentColor: Colors.black,
            bottomAppBarColor: Colors.white,
            appBarTheme: AppBarTheme(color: Colors.white),
            primaryIconTheme: IconThemeData(color: Colors.black),
            primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.black, fontFamily: "Aveny")),
            textTheme: TextTheme(headline6: TextStyle(color: Colors.black))),
        home: new HomePage(),
      ),
    );
  }
}
