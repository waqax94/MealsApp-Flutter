import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

import '../widgets/meal_item.dart';
import '../dummy-data.dart';

class CategoryMealPage extends StatefulWidget {
  static const routeName = '/category-meal';

  final List<Meal> availableMeals;

  CategoryMealPage(this.availableMeals);

  @override
  _CategoryMealPageState createState() => _CategoryMealPageState();
}

class _CategoryMealPageState extends State<CategoryMealPage> {
  String _title;
  List<Meal> _displayMeals;
  var _initialLoad = false;

  @override
  void didChangeDependencies() {
    if (!_initialLoad) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      _title = routeArgs['title'];
      final categoryId = routeArgs['id'];
      _displayMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _initialLoad = true;
    }
    super.didChangeDependencies();
  }

  void _removeItem(String mealId) {
    setState(() {
      _displayMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: _displayMeals[index].id,
            title: _displayMeals[index].title,
            imageUrl: _displayMeals[index].imageUrl,
            duration: _displayMeals[index].duration,
            affordability: _displayMeals[index].affordability,
            complexity: _displayMeals[index].complexity,
          );
        },
        itemCount: _displayMeals.length,
      ),
    );
  }
}
