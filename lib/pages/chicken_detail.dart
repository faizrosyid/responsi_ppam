import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:responsi_ppam/models/chicken_detail_model.dart';
import 'package:responsi_ppam/services/chicken_detail_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ChickenDetail extends StatefulWidget {
  String idTangkap;

  ChickenDetail({required this.idTangkap});

  @override
  State<ChickenDetail> createState() => _ChickenDetailState();
}

class _ChickenDetailState extends State<ChickenDetail> {
  List<ChickenDetailModel> chickensDetail = [];
  bool _loading = true;
  int currentIndex = 0;

  @override
  void initState() {
    getChickenDetail();
    super.initState();
  }

  getChickenDetail() async {
    ChickenDetailServ chickenDetailData = ChickenDetailServ();
    await chickenDetailData.getChickenDetail(widget.idTangkap);
    chickensDetail = chickenDetailData.chickenDetail;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[300],
        title: Text(
          "Beef Detail",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        padding: EdgeInsets.only(top: 8),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: chickensDetail.length,
          itemBuilder: (context, index) {
            return ShowDetail(
              name: chickensDetail[index].name!,
              image: chickensDetail[index].image!,
              area: chickensDetail[index].area!,
              category: chickensDetail[index].category!,
              instructions: chickensDetail[index].instructions!,
              youtube: chickensDetail[index].youtube!,
            );
          },
        ),
      ),
    );
  }
}

class ShowDetail extends StatelessWidget {
  final String name, image, area, category, instructions, youtube;

  ShowDetail({
    required this.name,
    required this.image,
    required this.area,
    required this.category,
    required this.instructions,
    required this.youtube,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: image,
              width: MediaQuery.of(context).size.width,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5),
          Text(
            name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Category: " + category),
              SizedBox(
                width: 70,
              ),
              Text("Area: " + area),
            ],
          ),
          SizedBox(height: 20),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Instructions:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(instructions),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo[300],
                onPrimary: Colors.white,
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                _launchUrl(youtube);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_arrow),
                  SizedBox(
                    width: 30,
                  ),
                  Text("Watch Tutorial")
                ],
              )),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  final Uri _url = Uri.parse(url);
  if (!await canLaunch(_url.toString())) {
    throw Exception('Could not launch $_url');
  } else {
    await launch(_url.toString());
  }
}
