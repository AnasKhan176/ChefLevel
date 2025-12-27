import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FavouriteReceipeController extends GetxController {
  RxMap<int, bool> favorites = <int, bool>{}.obs;

  void toggleFavorite(int id) {
    favorites[id] = !(favorites[id] ?? false);
  }

  bool isFavorite(int id) {
    return favorites[id] ?? false;
  }

}
