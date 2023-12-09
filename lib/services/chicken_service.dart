import 'dart:convert';
import 'package:responsi_ppam/models/chicken_model.dart';
import 'package:http/http.dart' as http;

class Chicken{
  List<ChickenModel> chicken=[];

  Future<void> getChicken()async{
    String url="https://www.themealdb.com/api/json/v1/1/filter.php?c=chicken";
    var response= await http.get(Uri.parse(url));
    var jsonData= jsonDecode(response.body);

    jsonData["meals"].forEach((element){
      if(element["strMeal"]!=null && element['strMealThumb']!=null){
        ChickenModel chickenModel = ChickenModel(
            id: element["idMeal"],
            name: element["strMeal"],
            image: element["strMealThumb"],
        );
        chicken.add(chickenModel);
      }
    });

  }
}