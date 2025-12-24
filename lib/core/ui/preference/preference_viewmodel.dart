import 'package:flutter/cupertino.dart';
import 'package:food_chef/core/domain/models/food_model.dart';
import 'package:food_chef/core/utils/database_service.dart';

class PreferenceViewModel extends ChangeNotifier {
  List<FoodModel> foods = [
    FoodModel(name: "South Indian"),
    FoodModel(name: "Punjabi"),
    FoodModel(name: "Chinese"),
    FoodModel(name: "Continental"),
  ];

  void toggleSelection(int index) {
    foods[index].selected = !foods[index].selected;
    notifyListeners();
  }

  Future<void> savePreferences() async {
    final db = await DatabaseService.database;
    await db.delete('preferences');

    for (var food in foods.where((f) => f.selected)) {
      await db.insert('preferences', {'food': food.name});
    }
  }
}