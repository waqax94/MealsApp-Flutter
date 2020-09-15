import 'package:flutter/material.dart';

import './dummy-data.dart';
import './models/meal.dart';
import './pages/category_meal_page.dart';
import './pages/filters_page.dart';
import './pages/meal_details_page.dart';
import './pages/tab_page.dart';
import './pages/category_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    "lactose": false,
    "vegan": false,
    "vegetarian": false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _selectFilters(Map<String, bool> currentFilters) {
    setState(() {
      _filters = currentFilters;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorites(String mealId) {
    final favouriteIndex =
        _favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if (favouriteIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(favouriteIndex);
      });
    } else {
      setState(() {
        _favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isFavourite(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepOrangeAccent,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline5: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
            ),
      ),
      title: 'Deli Meals',
      //home: CategoryScreen(),
      routes: {
        '/': (ctx) => TabPage(_favouriteMeals),
        CategoryMealPage.routeName: (ctx) => CategoryMealPage(_availableMeals),
        MealDetailPage.routeName: (ctx) => MealDetailPage(_toggleFavorites, _isFavourite),
        FiltersPage.routeName: (ctx) => FiltersPage(_filters, _selectFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.name);
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoryPage(),
        );
      },
    );
  }
}
