import 'package:flutter/material.dart';

import '../dummy-data.dart';

class MealDetailPage extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavourite;

  MealDetailPage(this.toggleFavorite, this.isFavourite);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final mealDetail = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    Widget buildHeader(String title, Widget widget) {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 10,
            ),
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          Container(
            width: 270,
            height: 150,
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).accentColor,
                )),
            child: widget,
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(mealDetail.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 270,
              width: double.infinity,
              child: Image.network(
                mealDetail.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildHeader(
              "Ingredients",
              ListView.builder(
                itemBuilder: (ctx, index) {
                  return Container(
                    margin: EdgeInsets.all(2),
                    padding: EdgeInsets.all(3),
                    child: Text(
                      mealDetail.ingredients[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  );
                },
                itemCount: mealDetail.ingredients.length,
              ),
            ),
            buildHeader(
              "Steps",
              ListView.builder(
                itemBuilder: (ctx, index) {
                  return Container(
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Text('# ${index + 1}'),
                          ),
                          title: Text(
                            mealDetail.steps[index],
                            style: TextStyle(
                              fontFamily: 'Raleway',
                            ),
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).accentColor,
                        ),
                      ],
                    ),
                  );
                },
                itemCount: mealDetail.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavourite(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () {
          toggleFavorite(mealId);
        },
      ),
    );
  }
}
