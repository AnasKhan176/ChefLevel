import 'dart:convert';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:http/http.dart' as http;

class ApiService extends GetxService {
  static ApiService get to => Get.find();
  Future<http.Response> postApi({
  required String url,
  required Map<String, dynamic> body, required Map<String, String> headerData}) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headerData,
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
