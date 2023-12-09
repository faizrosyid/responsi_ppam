import 'dart:convert';
import 'package:responsi_ppam/models/chicken_detail_model.dart';
import 'package:http/http.dart' as http;

class ChickenDetailServ{
  List<ChickenDetailModel> chickenDetail=[];


  Future<void> getChickenDetail(String id)async{
    String url="https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id";
    var response= await http.get(Uri.parse(url));
    var jsonData= jsonDecode(response.body);

    jsonData["meals"].forEach((element){
      if(element["strMeal"]!=null && element['strMealThumb']!=null){
        ChickenDetailModel chickenDetailModel = ChickenDetailModel(
          id: element["idMeal"],
          name: element["strMeal"],
          image: element["strMealThumb"],
          area: element["strArea"],
          category: element["strCategory"],
          instructions: element["strInstructions"],
          youtube: element["strYoutube"],
        );
        chickenDetail.add(chickenDetailModel);
      }
    });

  }
}