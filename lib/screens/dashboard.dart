import 'dart:convert';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<List<dynamic>> _fetchData() async {
    final data = await DefaultAssetBundle.of(context)
        .loadString('assets/data/dashboard.json');
    return json.decode(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffdcdeeb),
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
              child: Column(
                children: [
                  /* SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 150,
                    //color: Colors.blue,
                    child: Image.asset('assets/logo.png'),
                  ),*/
                  Expanded(
                    child: FutureBuilder<List<dynamic>>(
                      future: _fetchData(),
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
                                  color: Theme.of(context).cardColor,
                                  child: ListTile(
                                    trailing: const Icon(
                                      Icons.arrow_back_ios_new,
                                      color: Colors.black,
                                    ),
                                    title: Text(
                                      textAlign: TextAlign.center,
                                      item["title"].toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    //subtitle: Text(item["subtitle"].toString()),
                                    leading: Container(
                                        child: Image.asset(
                                            item["image"].toString(),
                                            fit: BoxFit.cover)),
                                    onTap: () => {
                                      Navigator.pushNamed(
                                          context, item["route"])
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
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ))));
  }
}
