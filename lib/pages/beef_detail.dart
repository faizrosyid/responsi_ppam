import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:responsi_ppam/models/beef_detail_model.dart';
import 'package:responsi_ppam/services/beef_detail_service.dart';
import 'package:url_launcher/url_launcher.dart';

class BeefDetail extends StatefulWidget {
  String idTangkap;

  BeefDetail({required this.idTangkap});

  @override
  State<BeefDetail> createState() => _BeefDetailState();
}

class _BeefDetailState extends State<BeefDetail> {
  List<BeefDetailModel> beefssDetail = [];
  bool _loading = true;
  int currentIndex = 0;

  @override
  void initState() {
    getBeefDetail();
    super.initState();
  }

  getBeefDetail() async {
    BeefDetailServ beefDetailData = BeefDetailServ();
    await beefDetailData.getBeefDetail(widget.idTangkap);
    beefssDetail = beefDetailData.beefDetail;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Beef Detail",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
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
          itemCount: beefssDetail.length,
          itemBuilder: (context, index) {
            return ShowDetail(
              name: beefssDetail[index].name!,
              image: beefssDetail[index].image!,
              area: beefssDetail[index].area!,
              category: beefssDetail[index].category!,
              instructions: beefssDetail[index].instructions!,
              youtube: beefssDetail[index].youtube!,
              onTap: () {
                setState(() {
                  currentIndex = index;
                });
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (beefssDetail.isNotEmpty) {
            _launchUrl(beefssDetail[currentIndex].youtube!);
          }
        },
        child: Icon(Icons.search),
      ),
    );
  }
}

class ShowDetail extends StatelessWidget {
  final String name, image, area, category, instructions, youtube;
  final VoidCallback onTap;

  ShowDetail({
    required this.name,
    required this.image,
    required this.area,
    required this.category,
    required this.instructions,
    required this.youtube,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            Text(area),
            SizedBox(height: 20),
          ],
        ),
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
