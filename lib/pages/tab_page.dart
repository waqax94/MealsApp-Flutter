import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import './category_page.dart';
import './favorite_page.dart';
import '../models/meal.dart';

class TabPage extends StatefulWidget {
  final List<Meal> favouriteMeals;

  TabPage(this.favouriteMeals);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  List<Map<String, Object>> _pages;

  int _selectedIndex = 0;

  @override
  void initState() {
    _pages = [
    {'page': CategoryPage(), 'title': 'Categories'},
    {'page': FavoritePage(widget.favouriteMeals), 'title': 'Favorites'}
  ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.shifting,
        elevation: 6,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.category),
            title: Text("Categories"),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.favorite),
            title: Text("Favorites"),
          )
        ],
      ),
    );
  }
}
