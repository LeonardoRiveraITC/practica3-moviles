import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:pmsn20232/models/popular_model.dart';
class ApiPopoular{
  Uri link = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=5019e68de7bc112f4e4337a500b96c56&language=es-MX&page=1');
 
  Future<List<PopularModel>?> getAllPopular() async{
      var response = await http.get(link);
      if(response.statusCode==200){
        var jsonResponse  = jsonDecode(response.body)['results'] as List;
        return jsonResponse.map((popular) => PopularModel.fromMap(popular)).toList();
      }
      return null;
  }

}