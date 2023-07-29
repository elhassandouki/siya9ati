import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:syi9a/admob/interAds.dart';
import 'package:syi9a/screens/cours/detail_cours.dart';
import '../../admob/admob.dart';

List<Cours> courses = [];

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  Future<List<dynamic>> _loadCourses() async {
    String jsonString = await rootBundle.loadString('assets/data/course.json');
    List<dynamic> coursesJson = jsonDecode(jsonString);
    courses = coursesJson
        .map((courseJson) => Cours(
              id: courseJson['id'],
              title: courseJson['title'],
              image: courseJson['image'],
            ))
        .toList();
    return coursesJson;
  }

  /// inter ads
  InterAds adsCour = InterAds();

  @override
  void initState() {
    adsCour.createInterstitialAd(AdHelper.interCour);
    AdHelper.bannerCour.load();
    super.initState();
    _loadCourses();
  }

  final AdWidget adQuiz = AdWidget(ad: AdHelper.bannerCour);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Text(
            'دروس نظرية',
            textDirection: TextDirection.rtl,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: Directionality(
            textDirection: TextDirection.ltr,
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
                                  color: const Color(0xfffbb448),
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.arrow_back_ios_new,
                                      color: Colors.white,
                                    ),
                                    title: Text(
                                      item["title"].toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    //subtitle: Text(item["subtitle"].toString()),
                                    trailing: const Icon(
                                      color: Colors.white,
                                      Icons.library_books,
                                    ),
                                    onTap: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailCoursPage(
                                                    id: item["id"],
                                                    title: item["title"])),
                                      ),
                                      adsCour.showInterstitialAd(),
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
                  ClipRRect(
                    child: SizedBox(
                      height: 50,
                      width: 320,
                      child: adQuiz,
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
