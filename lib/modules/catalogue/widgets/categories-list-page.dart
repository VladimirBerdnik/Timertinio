import 'package:flutter/material.dart';
import 'package:timertinio/modules/catalogue/data/CategoriesRepository.dart';
import 'package:timertinio/modules/catalogue/widgets/category-card.dart';

class CategoriesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = CategoriesRepository.fetchAll();

    return ListView.builder(
        itemCount: categories.length, itemBuilder: (context, index) => CategoryCard(categories[index]));
  }
}
