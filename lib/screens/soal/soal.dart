import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;

import '../../admob/admob.dart';
import '../../main.dart';

class QAPage extends StatefulWidget {
  @override
  _QAPageState createState() => _QAPageState();
}

class _QAPageState extends State<QAPage> {
  List<dynamic> _qaList = [];

  @override
  void initState() {
    AdHelper.bannerQuestion.load();
    super.initState();
    _fetchQAData();
  }

  final AdWidget adQuiz = AdWidget(ad: AdHelper.bannerQuestion);

  //https://elhassandouki.github.io/soal.json
  Future<void> _fetchQAData() async {
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
          .get(Uri.parse('https://elhassandouki.github.io/soal.json'));
      if (response.statusCode == 200) {
        setState(() {
          _qaList = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Text(
            'سؤال وجواب',
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
              child: _qaList.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Expanded(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: ListView.builder(
                              itemCount: _qaList.length,
                              itemBuilder: (context, index) {
                                final qa = _qaList[index];
                                return Card(
                                  color: Theme.of(context).cardColor,
                                  child: ExpansionTile(
                                    title: Text(
                                      qa['title'],
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    children: <Widget>[
                                      ListTile(
                                        title: Text(
                                          qa['description']
                                              .replaceAll("\\n", "\n"),
                                          textAlign: TextAlign.right,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      )
                                    ],
                                  ),
                                );

                                // ListTile(
                                //   title: Text(qa['title']),
                                //   subtitle: Text(qa['description']),
                                // );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
            ))));
  }
}
