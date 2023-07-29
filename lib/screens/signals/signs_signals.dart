import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../admob/admob.dart';

class Photo {
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo(
      {required this.id,
      required this.title,
      required this.url,
      required this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}

class SignsSignalsPage extends StatefulWidget {
  final int id;
  final String title;

  const SignsSignalsPage({Key? key, required this.id, required this.title})
      : super(key: key);
  @override
  _SignsSignalsPageState createState() => _SignsSignalsPageState();
}

class _SignsSignalsPageState extends State<SignsSignalsPage> {
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    AdHelper.bannerSignal2.load();
    super.initState();
    _fetchPhotos();
  }

  final AdWidget adQuiz = AdWidget(ad: AdHelper.bannerSignal2);

  Future<void> _fetchPhotos() async {
    final response = await DefaultAssetBundle.of(context)
        .loadString('assets/data/signals.json');

    final data = json.decode(response);
    setState(() {
      _data = List<Map<String, dynamic>>.from(
          data.where((x) => x["id"] == widget.id).map((x) => {
                "title": x["title"],
                "url": x["url"],
              }));
    });
  }

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
          : Column(
              children: [
                Expanded(
                  child: GridView(
                    scrollDirection: Axis.vertical,
                    controller: ScrollController(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    children: List.generate(_data.length, (index) {
                      return Container(
                        padding: const EdgeInsets.all(0),
                        color: Colors.white,
                        margin: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(32.0))),
                                  contentPadding:
                                      const EdgeInsets.only(top: 10.0),
                                  content: SizedBox(
                                    width: 300.0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              "العلامة الطرقية",
                                              textAlign: TextAlign.right,
                                              style: GoogleFonts.almarai(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        const Divider(
                                          color: Colors.grey,
                                          height: 4.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30.0, right: 30.0),
                                          child:
                                              Image.asset(_data[index]["url"]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(30.0),
                                          child: Text(
                                            _data[index]["title"],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.almarai(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                top: 20.0, bottom: 20.0),
                                            decoration: const BoxDecoration(
                                              color: Colors.yellow,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(32.0),
                                                  bottomRight:
                                                      Radius.circular(32.0)),
                                            ),
                                            child: Text(
                                              "فهمت",
                                              style: GoogleFonts.almarai(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop(showDialog);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Center(
                            child: GridTile(
                              child: Image.asset(
                                _data[index]["url"],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
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
    );
  }
}
