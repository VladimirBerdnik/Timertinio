import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:timertinio/modules/catalogue/data/CategoryModel.dart';
import 'package:timertinio/modules/catalogue/widgets/category-page.dart';

class CategoryCard extends StatefulWidget {
  CategoryCard(this.category);

  final Category category;

  @override
  State<StatefulWidget> createState() => CategoryCardState();
}

class CategoryCardState extends State<CategoryCard> {
  Category _category;

  @override
  void initState() {
    _category = widget.category;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // TODO calculate in parent?
    double bottomBarSize = 56.0;
    double topBarSize = 56.0 + 24.0;
    double paddingSize = 4.0;
    double itemsCount = 3.0;

    double availableWidth = size.width - paddingSize * 2;
    double availableHeight = size.height - bottomBarSize - topBarSize - paddingSize * itemsCount * 2;

    double aspectRatio = availableWidth / (availableHeight / itemsCount);
    return Card(
      child: Stack(children: <Widget>[
        AspectRatio(
          aspectRatio: aspectRatio,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    alignment: FractionalOffset.center,
                    image: AssetImage(_category.images.first))),
          ),
        ),
        Center(
          child: ClipRect(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ),
              child: Container(
                alignment: Alignment.center,
                height: 70.0,
                color: Colors.white.withOpacity(0.3),
                child: ListTile(
                    title: Text(_category.name, style: TextStyle(fontSize: 24)),
                    subtitle: Text(_category.intro, style: TextStyle(fontSize: 16)),
                    trailing: Icon(Icons.chevron_right, size: 36),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CategoryPage(_category)),
                      );
                    }),
              ),
            ),
          ),
        ),
      ], alignment: AlignmentDirectional.bottomStart),
    );
  }
}
