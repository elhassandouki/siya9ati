import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;

import '../../admob/admob.dart';
import '../../admob/interAds.dart';
import '../../main.dart';

class Mawa9ifPage extends StatefulWidget {
  const Mawa9ifPage({super.key});

  @override
  _Mawa9ifPageState createState() => _Mawa9ifPageState();
}

class _Mawa9ifPageState extends State<Mawa9ifPage> {
  List<Map<String, dynamic>> _data = [];
  Timer? timer;
  InterAds mawa9if = InterAds();

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    AdHelper.bannerMawa9if.load();
    super.initState();
    _getData();

    timer = Timer.periodic(const Duration(seconds: 180), (timer) {
      mawa9if.createInterstitialAd(AdHelper.interMawa9if);
      mawa9if.showInterstitialAd();
    });
  }

  final AdWidget adQuiz = AdWidget(ad: AdHelper.bannerMawa9if);

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
          .get(Uri.parse('https://goubraim.github.io/data/json/mwakif.json'));

      final data = json.decode(response.body);
      setState(() {
        _data = List<Map<String, dynamic>>.from(data.map((x) => {
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
            'مواقف شائعة',
            textDirection: TextDirection.rtl,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: _data.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Container(
                color: const Color(0xffdcdeeb),
                child: Column(children: [
                  Expanded(
                    child: Stack(
                      children: [
                        CarouselSlider.builder(
                          itemCount: _data.length,
                          itemBuilder:
                              (BuildContext context, int index, int realIndex) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.275,
                                    width: MediaQuery.of(context).size.width *
                                        19 /
                                        20,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        _data[index]["image"],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "${index + 1} / ${_data.length}",
                                    // _data[index]["title"],
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Expanded(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          19 /
                                          20,
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            _data[index]["description"],
                                            textDirection: TextDirection.rtl,
                                            style: const TextStyle(
                                              fontSize: 20,
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
                    padding: const EdgeInsets.only(bottom: 5),
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
                          onPressed: () => _controller.previousPage(),
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
                          onPressed: () => _controller.nextPage(),
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
              ));
  }
}
