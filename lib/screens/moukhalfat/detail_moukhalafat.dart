import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

import '../../admob/admob.dart';
import '../../main.dart';

class DeatilMoukhalafatPage extends StatefulWidget {
  final int id;
  final String title;

  DeatilMoukhalafatPage({required this.id, required this.title});

  @override
  _DeatilMoukhalafatPageState createState() => _DeatilMoukhalafatPageState();
}

class _DeatilMoukhalafatPageState extends State<DeatilMoukhalafatPage> {
  List<dynamic> _data = [];

  ///https://elhassandouki.github.io/data3.json
  Future<void> getData() async {
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
      final response = await http.get(
          Uri.parse('https://goubraim.github.io/data/json/mokhalafat.json'));
      final data = json.decode(response.body);
      setState(() {
        _data = List<Map<String, dynamic>>.from(
            data.where((x) => x["id"] == widget.id).map((x) => {
                  "title": x["title"],
                  "subtitle": x["subtitle"],
                  "description": x["description"],
                  "image": x["image"],
                }));
      });
    }
  }

  @override
  void initState() {
    AdHelper.bannerMokhalafa2.load();
    super.initState();
    getData();
  }

  final AdWidget adQuiz = AdWidget(ad: AdHelper.bannerMokhalafa2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(
          widget.title,
          textDirection: TextDirection.rtl,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.keyboard_backspace),
              onPressed: () {
                Navigator.pop(context);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: _data.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      final item = _data[index];
                      return Card(
                          color: Colors.grey,
                          //color: Theme.of(context).cardColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: ListTile(
                                  title: Text(
                                    item['title'],
                                    textDirection: TextDirection.rtl,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  // subtitle: Text(item['title']),
                                  // trailing: Text(item['title']),
                                ),
                              ),
                              Container(
                                // color: Colors.green,
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 1 / 12,
                                child: ListTile(
                                  // title: Text(item['title']),
                                  // subtitle: Text(item['title']),
                                  subtitle: Text(
                                    item['subtitle'],
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ));
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
    );
  }
}
