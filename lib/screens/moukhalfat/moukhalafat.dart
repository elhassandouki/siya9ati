import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
// import 'package:syi9a/screens/cours/detail_cours.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:syi9a/screens/moukhalfat/detail_moukhalafat.dart';

import '../../admob/admob.dart';
import '../../admob/interAds.dart';

List<Cours> courses = [];

class MoukhalafatPage extends StatefulWidget {
  const MoukhalafatPage({Key? key}) : super(key: key);

  @override
  _MoukhalafatPageState createState() => _MoukhalafatPageState();
}

class _MoukhalafatPageState extends State<MoukhalafatPage> {
  Future<List<dynamic>> _loadCourses() async {
    String jsonString =
        await rootBundle.loadString('assets/data/_moukhalafat.json');
    //List<dynamic> coursesJson = jsonDecode(jsonString);
    return json.decode(jsonString);
  }

  @override
  void initState() {
    AdHelper.bannerMokhalafa.load();
    adsMokhalafa.createInterstitialAd(AdHelper.interMokhalafa);
    super.initState();
    _loadCourses();
  }

  /// inter ads
  InterAds adsMokhalafa = InterAds();
  final AdWidget adQuiz = AdWidget(ad: AdHelper.bannerMokhalafa);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Text(
            'مخلفات',
            textDirection: TextDirection.rtl,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
                child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: const Color.fromARGB(255, 97, 69, 69),
                        offset: Offset(2, 4),
                        blurRadius: 5,
                        spreadRadius: 2)
                  ],
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xfffbb448),
                        Color.fromARGB(255, 243, 165, 48),
                        Color(0xffe46b10)
                      ])),
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder<List<dynamic>>(
                      future: _loadCourses(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = snapshot.data![index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 20.0),
                                child: Card(
                                  color: Theme.of(context).cardColor,
                                  child: ListTile(
                                    trailing: const Icon(
                                      Icons.arrow_back_ios_new,
                                      color: Colors.white,
                                    ),
                                    title: Text(
                                      item["title"].toString(),
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    onTap: () => {
                                      adsMokhalafa.showInterstitialAd(),
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DeatilMoukhalafatPage(
                                                      id: item["id"],
                                                      title: item["title"]
                                                          .toString())))
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('${snapshot.error}'),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ))));
  }
}

class Cours {
  final int id;
  final String title;
  final String image;

  Cours({required this.id, required this.title, required this.image});

  factory Cours.fromJson(Map<String, dynamic> json) {
    return Cours(
      id: json['id'],
      title: json['title'],
      image: json['image'],
    );
  }
}
