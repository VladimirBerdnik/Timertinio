import 'package:flutter/material.dart';
import 'package:timertinio/modules/activity/widgets/activities-group-page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ActivitiesGroupPage(),
    );
  }
}
