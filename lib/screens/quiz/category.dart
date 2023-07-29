import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:syi9a/admob/admob.dart';
import 'package:syi9a/screens/quiz/question.dart';

import '../../admob/interAds.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    AdHelper.bannerQuiz.load();
    adsQuiz.createInterstitialAd(AdHelper.interQuiz);
    super.initState();
  }

  final AdWidget adQuiz = AdWidget(ad: AdHelper.bannerQuiz);

  /// inter ads
  InterAds adsQuiz = InterAds();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Text(
            'سلاسل الامتحان',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: Directionality(
            textDirection: TextDirection.ltr,
            child: SafeArea(
              child: Container(
                  padding: EdgeInsets.all(8.0),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 15),
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              final int number = index + 1;
                              return ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).cardColor),
                                ),
                                onPressed: () {
                                  adsQuiz.showInterstitialAd();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          QuizPage(category: number.toString()),
                                    ),
                                  );
                                },
                                child: Text(
                                  '$number',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
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
                      ])),
            )));
  }
}
