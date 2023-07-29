import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;

import '../../admob/admob.dart';
import '../../main.dart';

class DetailMohimPage extends StatefulWidget {
  final int id;
  final String title;

  DetailMohimPage({required this.id, required this.title});

  @override
  _DetailMohimPageState createState() => _DetailMohimPageState();
}

class _DetailMohimPageState extends State<DetailMohimPage> {
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    AdHelper.bannerMohim2.load();
    super.initState();
    _getData();
  }

  final AdWidget adQuiz = AdWidget(ad: AdHelper.bannerMohim2);

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
      final response = await http.get(
          Uri.parse('https://goubraim.github.io/data/json/mohim-detail.json'));

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
              child: _data.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: _data.length,
                            itemBuilder: (context, index) {
                              final qa = _data[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 1),
                                child: Card(
                                  child: ListTile(
                                      title: ListTile(
                                    title: Text(
                                      qa['title'],
                                      textDirection: TextDirection.rtl,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  )),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ))));
  }
}
