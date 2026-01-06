import 'package:dio/dio.dart';
import 'package:food_chef/core/domain/models/home/home_recipes_model.dart';
import 'package:food_chef/core/domain/network/api_exception.dart';
import 'package:food_chef/core/domain/services/home_recipes_service.dart';

class HomeRecipesRepository {
  HomeRecipesRepository(this.homeRecipesService);

  final HomeRecipesService homeRecipesService;

  Future<HomeRecipesDataModel> getHomeRecipesData(
    Map<String, dynamic> data,
    Map<String, dynamic> headersData,
  ) async {
    try {
      final response = await homeRecipesService.getHomeRecipes(
        data,
        headersData,
      );
      HomeRecipesDataModel res = HomeRecipesDataModel.fromJson(response?.data);
      print('aaaaaaaaaaaaaaaaaaaaaaaaa1');
      print(res);
      print('aaaaaaaaaaaaaaaaaaaaaaaaa2');
      return res;
    } on DioException catch (e) {
      throw APIException.fromDioError(e).toString();
    }
  }
}
