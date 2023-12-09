import 'dart:convert';
import 'package:responsi_ppam/models/category_model.dart';
import 'package:http/http.dart' as http;

class Category{
  List<CategoryModel> category=[];


  Future<void> getCategory()async{
    String url="https://www.themealdb.com/api/json/v1/1/filter.php?c=beef";
    var response= await http.get(Uri.parse(url));
    var jsonData= jsonDecode(response.body);

    jsonData["meals"].forEach((element){
      if(element["strMeal"]!=null && element['strMealThumb']!=null){
        CategoryModel categoryModel = CategoryModel(
            id: element["idMeal"],
            name: element["strMeal"],
            image: element["strMealThumb"],
        );
        category.add(categoryModel);
      }
    });

  }
}