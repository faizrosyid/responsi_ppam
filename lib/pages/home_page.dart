import 'package:flutter/material.dart';
import 'package:responsi_ppam/pages/beef_page.dart';
import 'package:responsi_ppam/pages/chicken_page.dart';
import 'package:responsi_ppam/pages/dessert_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Categories",
          style: TextStyle(
              fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 15),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BeefPage()));
                },
                child: Card(
                  child: Column(
                    children: [
                      Image.asset("images/beef.png", height: 200,),
                      Text("Beef", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      Text("Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2]", style: TextStyle(fontSize: 12),),
                      SizedBox(height: 5,)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChickenPage()));
                },
                child: Card(
                  child: Column(
                    children: [
                      Image.asset("images/chicken.png", height: 200,),
                      Text("Chicken", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      Text("Chicken is a type of domesticated fowl, a subspecies of the red junglefowl. It is one of the most common and widespread domestic animals, with a total population of more than 19 billion as of 2011.[1] Humans commonly keep chickens as a source of food (consuming both their meat and eggs) and, more rarely, as pets.", style: TextStyle(fontSize: 12),),
                      SizedBox(height: 5,)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DessertPage()));
                },
                child: Card(
                  child: Column(
                    children: [
                      Image.asset("images/dessert.png", height: 200,),
                      Text("Dessert", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      Text("Dessert is a course that concludes a meal. The course usually consists of sweet foods, such as confections dishes or fruit, and possibly a beverage such as dessert wine or liqueur, however in the United States it may include coffee, cheeses, nuts, or other savory items regarded as a separate course elsewhere. In some parts of the world, such as much of central and western Africa, and most parts of China, there is no tradition of a dessert course to conclude a meal.\r\n\r\nThe term dessert can apply to many confections, such as biscuits, cakes, cookies, custards, gelatins, ice creams, pastries, pies, puddings, and sweet soups, and tarts. Fruit is also commonly found in dessert courses because of its naturally occurring sweetness. Some cultures sweeten foods that are more commonly savory to create desserts.", style: TextStyle(fontSize: 12),),
                      SizedBox(height: 5,)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,)
            ],
          ),
        ),
      ),
    );
  }
}
