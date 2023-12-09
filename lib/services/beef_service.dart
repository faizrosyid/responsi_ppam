import 'dart:convert';
import 'package:responsi_ppam/models/beef_model.dart';
import 'package:http/http.dart' as http;

class Beef{
  List<BeefModel> beef=[];


  Future<void> getBeef()async{
    String url="https://www.themealdb.com/api/json/v1/1/filter.php?c=beef";
    var response= await http.get(Uri.parse(url));
    var jsonData= jsonDecode(response.body);

    jsonData["meals"].forEach((element){
      if(element["strMeal"]!=null && element['strMealThumb']!=null){
        BeefModel beefModel = BeefModel(
            id: element["idMeal"],
            name: element["strMeal"],
            image: element["strMealThumb"],
        );
        beef.add(beefModel);
      }
    });

  }
}