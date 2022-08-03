import 'dart:convert';

import 'package:flutter_base_bloc_list/model/post.dart';
import 'package:http/http.dart' as http;

class DataService{
  final _baseUrl = 'jsonplaceholder.typicode.com';

  ///gzn_dart_http_future
  Future<List<Post>> getPost() async{
      try{
        final url = Uri.https(_baseUrl, '/posts');
        final response = await http.get(url);
        final json = jsonDecode(response.body) as List;
        final res = json.map((e) => Post.fromJson(e)).toList();
        return res;
      } on Error catch(e){
        throw e;
      }
  }
}