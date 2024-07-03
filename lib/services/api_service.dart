import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:smarty_editor_with_block/model/post_model.dart';
import 'package:smarty_editor_with_block/utils/api_constants.dart';

class ApiService {
  

  Future<List<PostModel>> fetchPosts() async {
    final response = await Dio().get(ApiEndpoints.POSTs_API);

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      return data.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}