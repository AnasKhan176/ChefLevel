import 'package:flutter/material.dart';
import 'package:food_chef/core/domain/models/home/chef_list_model.dart';
import 'package:food_chef/core/domain/models/home/home_recipes_model.dart';
import 'package:food_chef/core/domain/models/home/popular_technique_list_model.dart';
import 'package:food_chef/core/domain/models/home/tailored_recipes_list_model.dart';

class HomeScreenProvider extends ChangeNotifier {
  final int _pageSize = 10;
  int _currentPage = 1;
  bool _isFavoriteHome = false;
  bool _isFavoriteTailoredAll = false;
  bool _isFavoriteMasterChefAll = false;
  bool _isFavoritePopularTechniqueAll = false;


  // Home Data List
  List<TailoredRecipe>? _tailoredRecipeHomeList = [];
  List<Chef>? _chefHomeList = [];
  List<PopularTechnique>? _popularRecipeHomeList = [];

  // See all Tailored recipies, master chef, Popular Technique recipies
  List<TailoredAllRecipiesResult>? _tailoredRecipiesAllList = [];
  List<ChefAllResult>? _masterChefAllList = [];
  List<PopuarTechniqueAllResult>? _popularTechniqueAllList = [];

  // Get Home Data List
  List<TailoredRecipe>? get tailoredRecipesHomeData => _tailoredRecipeHomeList;
  List<Chef>? get masterChefHomeData => _chefHomeList;
  List<PopularTechnique>? get popularTechniquesHomeData =>
      _popularRecipeHomeList;

  // See all Get Tailored recipies, Master Chef, Popular Technique recipies
  List<TailoredAllRecipiesResult>? get tailoredRecipiesAllData =>
      _tailoredRecipiesAllList;
  List<ChefAllResult>? get masterChefAllData => _masterChefAllList;
  List<PopuarTechniqueAllResult>? get popularTechniqueAllData =>
      _popularTechniqueAllList;

  bool get isFavoriteHome => _isFavoriteHome;
  bool get isFavoriteTailoredAll => _isFavoriteTailoredAll;
  bool get isFavoriteMasterChefAll => _isFavoriteMasterChefAll;
  bool get isFavoritePopularTechniqueAll => _isFavoritePopularTechniqueAll;


  int get currentPage => _currentPage;
  int get pageSize => _pageSize;

  void setHomeRecipesData(HomeData? data) {
    _tailoredRecipeHomeList = data?.tailoredRecipes ?? [];
    _chefHomeList = data?.chefs ?? [];
    _popularRecipeHomeList = data?.popularTechniques ?? [];
    notifyListeners();
  }

  void setTailoredAllRecipiesData(TailoredRecipesAllData? data) {
    _tailoredRecipiesAllList = data?.results ?? [];
    notifyListeners();
  }

  void setMasterChefAllData(ChefAllData? data) {
    _masterChefAllList = data?.results ?? [];
    notifyListeners();
  }

  void setPopularTechniqueAllData(PopuarTechniqueAllData? data) {
    _popularTechniqueAllList = data?.results ?? [];
    notifyListeners();
  }

  void setIsFavoriteTailoredHome(bool isClicked) {
    _isFavoriteHome = isClicked;
    notifyListeners();
  }
  void setIsFavoriteTailoredAll(bool isClicked) {
    _isFavoriteTailoredAll = isClicked;
    notifyListeners();
  }
  void setIsFavoriteMasterChefdAll(bool isClicked) {
    _isFavoriteMasterChefAll = isClicked;
    notifyListeners();
  }
  void setIsFavoritePopularTechniqueAll(bool isClicked) {
    _isFavoritePopularTechniqueAll = isClicked;
    notifyListeners();
  }

  void loadMoreData() {
    _currentPage++;
    notifyListeners();
  }
}
