import 'package:flutter/material.dart';

import '../pages/category_meal_page.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(
    this.id,
    this.title,
    this.color,
  );

  void selectItem(BuildContext context) {
    Navigator.of(context).pushNamed(
      CategoryMealPage.routeName,
      arguments: {
        'id': id,
        'title': title,
      },
    );

    // MaterialPageRoute(
    //   builder: (_) {
    //     return CategoryMeal(
    //       id,
    //       title,
    //     );
    //   },
    //),
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectItem(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.7), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
