import 'package:flutter/material.dart';

import '../pages/filters_page.dart';

class MainDrawer extends StatelessWidget {
  Widget buildTile(String title, IconData icon, Function openPage) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.deepOrangeAccent,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.deepOrangeAccent,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: openPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            alignment: Alignment.center,
            color: Theme.of(context).accentColor,
            child: Text(
              "Cooking Up!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900),
            ),
          ),
          buildTile(
            "Meals",
            Icons.restaurant,
            () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          buildTile(
            "Filters",
            Icons.filter,
            () {
              Navigator.of(context).pushReplacementNamed(FiltersPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
