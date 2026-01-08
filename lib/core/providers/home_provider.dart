import 'package:flutter/material.dart';
import 'package:food_chef/core/domain/models/home/home_recipes_model.dart';

class HomeScreenProvider extends ChangeNotifier {
  final int _pageSize = 10;
  int _currentPage = 1;

  List<TailoredRecipe>? _tailoredRecipeList = [];
  List<Chef>? _chefList = [];
  List<PopularTechnique>? _popularRecipeList = [];

  int get currentPage => _currentPage;
  int get pageSize => _pageSize;

  List<TailoredRecipe>? get tailoredRecipesData => _tailoredRecipeList;
  List<Chef>? get masterChefData => _chefList;
  List<PopularTechnique>? get popularTechniquesData => _popularRecipeList;

  void setHomeRecipesData(Data? data) {
    
    _tailoredRecipeList = data?.tailoredRecipes ?? [];
    _chefList = data?.chefs ?? [];
    _popularRecipeList = data?.popularTechniques ?? [];

    print(_tailoredRecipeList!.length);
    print(_chefList!.length);
    print(_popularRecipeList!.length);

    notifyListeners();
  }

  void loadMoreData() {
    _currentPage++;
    notifyListeners();
  }
}
