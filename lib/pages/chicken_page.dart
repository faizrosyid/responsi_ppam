import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsi_ppam/models/chicken_model.dart';
import 'package:responsi_ppam/pages/chicken_detail.dart';
import 'package:responsi_ppam/services/chicken_service.dart';

class ChickenPage extends StatefulWidget {
  const ChickenPage({super.key});

  @override
  State<ChickenPage> createState() => _ChickenPageState();
}

class _ChickenPageState extends State<ChickenPage> {
  List<ChickenModel> chickens = [];
  bool _loading = true;

  @override
  void initState() {
    getChickenData();
    super.initState();
  }

  getChickenData() async {
    Chicken chickenclass = Chicken();
    await chickenclass.getChicken();
    chickens = chickenclass.chicken;
    setState(() {
      _loading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[300],
        title: Text(
          "Chicken Meals",
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
                      itemCount: chickens.length,
                      itemBuilder: (context, index) {
                        return BlogTile(
                          name: chickens[index].name!,
                          image: chickens[index].image!,
                          id: chickens[index].id!,
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
                builder: (context) => ChickenDetail(idTangkap: id)));
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
