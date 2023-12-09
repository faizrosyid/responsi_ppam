import 'dart:convert';
import 'package:responsi_ppam/models/beef_detail_model.dart';
import 'package:http/http.dart' as http;

class BeefDetailServ{
  List<BeefDetailModel> beefDetail=[];


  Future<void> getBeefDetail(String id)async{
    String url="https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id";
    var response= await http.get(Uri.parse(url));
    var jsonData= jsonDecode(response.body);

    jsonData["meals"].forEach((element){
      if(element["strMeal"]!=null && element['strMealThumb']!=null){
        BeefDetailModel beefDetailModel = BeefDetailModel(
          id: element["idMeal"],
          name: element["strMeal"],
          image: element["strMealThumb"],
          area: element["strArea"],
          category: element["strCategories"],
          instructions: element["strInstructions"],
        );
        beefDetail.add(beefDetailModel);
      }
    });

  }
}