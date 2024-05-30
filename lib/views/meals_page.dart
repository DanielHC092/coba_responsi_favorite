import 'package:flutter/material.dart';
import 'package:latihan_responsi_plug_e/models/MealsModel.dart';
import '../views/meal_details_page.dart';
import '../api/api_data_source.dart';

class MealsPage extends StatefulWidget {
  final String category;

  const MealsPage({super.key, required this.category});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        centerTitle: true,
      ),
      body: _buildMealList(),
    );
  }

  Widget _buildMealList() {
    return FutureBuilder(
      future: ApiDataSource.instance.loadMeals(widget.category),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingSection();
        }
        if (snapshot.hasData) {
          MealsModel mealsModel = MealsModel.fromJson(snapshot.data);
          return _buildSuccessSection(mealsModel);
        }
        return _buildErrorSection();
      },
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: Text("Error"),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(MealsModel data) {
    if (data.meals == null || data.meals!.isEmpty) {
      return Center(
        child: Text("No meals found for this category."),
      );
    }
    return ListView.builder(
      itemCount: data.meals?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        Meals meal = data.meals![index];
        return _buildMealItem(meal);
      },
    );
  }

  Widget _buildMealItem(Meals meal) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(meal.strMealThumb ?? ''),
      ),
      title: Text(meal.strMeal ?? 'Unknown'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealDetailsPage(idMeal: meal.idMeal!),
          ),
        );
      },
    );
  }
}
