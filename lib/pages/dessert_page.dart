import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsi_ppam/models/dessert_model.dart';
import 'package:responsi_ppam/pages/dessert_detail.dart';
import 'package:responsi_ppam/services/dessert_service.dart';

class DessertPage extends StatefulWidget {
  const DessertPage({super.key});

  @override
  State<DessertPage> createState() => _DessertPageState();
}

class _DessertPageState extends State<DessertPage> {
  List<DessertModel> dessert = [];
  bool _loading = true;

  @override
  void initState() {
    getDessertData();
    super.initState();
  }

  getDessertData() async {
    Dessert dessertclass = Dessert();
    await dessertclass.getDessert();
    dessert = dessertclass.dessert;
    setState(() {
      _loading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[300],
        title: Text(
          "Dessert Meals",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dessert.length,
                      itemBuilder: (context, index) {
                        return BlogTile(
                          name: dessert[index].name!,
                          image: dessert[index].image!,
                          id: dessert[index].id!,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class BlogTile extends StatelessWidget {
  String name, image, id;

  BlogTile({required this.name, required this.image, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DessertDetail(idTangkap: id)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: image,
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
