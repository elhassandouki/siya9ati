import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:syi9a/admob/interAds.dart';
import '../../admob/admob.dart';
import '../../main.dart';
import 'package:connectivity/connectivity.dart';

class DetailCoursPage extends StatefulWidget {
  final int id;
  final String title;

  const DetailCoursPage({super.key, required this.id, required this.title});

  @override
  _DetailCoursPageState createState() => _DetailCoursPageState();
}

class _DetailCoursPageState extends State<DetailCoursPage> {
  List<Map<String, dynamic>> _data = [];
  int index_current = 0;
  Timer? timer;
  InterAds interCours = InterAds();

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    AdHelper.bannerCour2.load();
    super.initState();
    _getData();

    timer = Timer.periodic(const Duration(seconds: 180), (timer) {
      interCours.createInterstitialAd(AdHelper.interdCour);
      interCours.showInterstitialAd();
    });
  }

  final AdWidget adQuiz = AdWidget(ad: AdHelper.bannerCour2);

  ///https://elhassandouki.github.io/data3.json
  Future<void> _getData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('عذرا، لا يمكنك الدخول ، تأكد من اتصالك بالأنترنت.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp())),
                child: Text('موافق'),
              ),
            ],
          );
        },
      );
    } else {
      final response = await http
          .get(Uri.parse('https://goubraim.github.io/data/json/cours.json'));

      final data = json.decode(response.body);
      setState(() {
        _data = List<Map<String, dynamic>>.from(
            data.where((x) => x["id"] == widget.id).map((x) => {
                  "title": x["title"],
                  "description": x["description"],
                  "image": x["image"],
                }));
      });
    }
  }

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: _data.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(children: [
              Expanded(
                child: Stack(
                  children: [
                    CarouselSlider.builder(
                      itemCount: _data.length,
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        return Container(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 2 / 5,
                                width:
                                    MediaQuery.of(context).size.width * 19 / 20,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    _data[index]["image"],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "${index + 1} / ${_data.length}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Expanded(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      19 /
                                      20,
                                  child: Card(
                                    color: Colors.grey[400],
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SingleChildScrollView(
                                        child: Text(
                                          _data[index]["description"],
                                          textDirection: TextDirection.rtl,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      carouselController: _controller,
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            index_current = index;
                          });
                        },
                        height: MediaQuery.of(context).size.height,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: ClipRRect(
                  child: SizedBox(
                    height: 50,
                    width: 320,
                    child: adQuiz,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ElevatedButton(
                      onPressed: () {
                        _controller.previousPage();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColorDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 15.0,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                  /////
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ElevatedButton(
                      onPressed: () => {
                        _controller.nextPage(),
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColorDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 15.0,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 2 / 100)
            ]),
    );
  }
}
