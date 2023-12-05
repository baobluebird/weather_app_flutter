
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class FallService{
  static  const String url = 'https://hai3052002.pythonanywhere.com/total_data/all?fbclid=IwAR1ySI1mmTEQ4pvSA_Dytq0_GXaZANRB2xL8sxDsYJD9gWhl7RHaNK3BEJw';

  static List<User> parsePost(String responeBody){
    var list = json.decode(responeBody) as List<dynamic>;
    List<User> posts = list.map((model) => User.fromJson(model)).toList();
    return posts;
  }
  static Future<List<User>> fetchPosts({int page = 1}) async{
    final responese = await http.get(Uri.parse(url));
    if(responese.statusCode == 200){
      return compute(parsePost,responese.body);
    }else if(responese.statusCode == 404){
      throw Exception('Not found');
    }else{
      throw Exception('Can\'t get post');
    }
  }
}
