import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsi_ppam/models/beef_model.dart';
import 'package:responsi_ppam/pages/beef_detail.dart';
import 'package:responsi_ppam/services/beef_service.dart';

class BeefPage extends StatefulWidget {
  const BeefPage({super.key});

  @override
  State<BeefPage> createState() => _BeefPageState();
}

class _BeefPageState extends State<BeefPage> {
  List<BeefModel> beefs = [];
  bool _loading = true;

  @override
  void initState() {
    getBeefData();
    super.initState();
  }

  getBeefData() async {
    Beef beefclass = Beef();
    await beefclass.getBeef();
    beefs = beefclass.beef;
    setState(() {
      _loading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Beef Meals",
          style: TextStyle(fontWeight: FontWeight.bold),
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
                      itemCount: beefs.length,
                      itemBuilder: (context, index) {
                        return BlogTile(
                          name: beefs[index].name!,
                          image: beefs[index].image!,
                          id: beefs[index].id!,
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
                builder: (context) => BeefDetail(idTangkap: id)));
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
