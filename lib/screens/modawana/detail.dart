import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

import '../../admob/admob.dart';
import '../../main.dart';

class Detailmodawana extends StatefulWidget {
  final int id;
  final String title;

  Detailmodawana({required this.id, required this.title});

  @override
  _DetailmodawanaState createState() => _DetailmodawanaState();
}

class _DetailmodawanaState extends State<Detailmodawana> {
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    AdHelper.bannerModawana2.load();
    super.initState();
    _getData();
  }

  final AdWidget adQuiz = AdWidget(ad: AdHelper.bannerModawana2);

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
          .get(Uri.parse('https://goubraim.github.io/data/json/modawana.json'));

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
          textDirection: TextDirection.rtl,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: _data.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        _data[0]["description"],
                        textDirection: TextDirection.rtl,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
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
