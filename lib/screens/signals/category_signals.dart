import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:syi9a/screens/signals/signs_signals.dart';

import '../../admob/admob.dart';
//import '../../admob/interAds.dart';

class CategorySignalsPage extends StatefulWidget {
  @override
  _CategorySignalsPageState createState() => _CategorySignalsPageState();
}

class _CategorySignalsPageState extends State<CategorySignalsPage> {
  List<Map<String, dynamic>> _data = [];

  Future<void> _fetchData() async {
    final response = await DefaultAssetBundle.of(context)
        .loadString('assets/data/categorysignalse.json');

    final data = json.decode(response);
    setState(() {
      _data = List<Map<String, dynamic>>.from(data);
    });
  }

  @override
  void initState() {
    AdHelper.bannerSignal.load();
    //adsSignal.createInterstitialAd(AdHelper.interSignal);
    super.initState();
    _fetchData();
  }

  /// inter ads
  //InterAds adsSignal = InterAds();
  final AdWidget adQuiz = AdWidget(ad: AdHelper.bannerSignal);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'العلامات والاشارات',
            textDirection: TextDirection.rtl,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          centerTitle: true,
        ),
        body: _data.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(children: [
                Expanded(
                    child: GridView(
                  scrollDirection: Axis.vertical,
                  controller: ScrollController(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  children: List.generate(_data.length, (index) {
                    return Container(
                      padding: const EdgeInsets.all(0),
                      color: Colors.white,
                      margin: const EdgeInsets.all(2.0),
                      child: GestureDetector(
                        onTap: () => {
                          //adsSignal.showInterstitialAd(),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignsSignalsPage(
                                      title: _data[index]["title"],
                                      id: _data[index]["id"])))
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 1 / 6,
                                width:
                                    MediaQuery.of(context).size.width * 2 / 5,
                                child: ClipRRect(
                                  child: Image.asset(_data[index]["icon"]
                                      //fit: BoxFit.cover,
                                      ),
                                )),
                            Divider(),
                            Text(_data[index]["title"],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ))
                          ],
                        ),
                      ),
                    );
                  }),
                ))
              ]));
  }
}
