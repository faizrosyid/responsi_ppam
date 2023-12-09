import 'dart:convert';
import 'package:responsi_ppam/models/dessert_model.dart';
import 'package:http/http.dart' as http;

class Dessert{
  List<DessertModel> dessert=[];

  Future<void> getDessert()async{
    String url="https://www.themealdb.com/api/json/v1/1/filter.php?c=dessert";
    var response= await http.get(Uri.parse(url));
    var jsonData= jsonDecode(response.body);

    jsonData["meals"].forEach((element){
      if(element["strMeal"]!=null && element['strMealThumb']!=null){
        DessertModel dessertModel = DessertModel(
            id: element["idMeal"],
            name: element["strMeal"],
            image: element["strMealThumb"],
        );
        dessert.add(dessertModel);
      }
    });

  }
}