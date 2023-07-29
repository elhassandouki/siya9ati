import 'dart:io';
import 'package:flutter/services.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syi9a/navbar/pages/contact.dart';
import 'package:syi9a/screens/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/navbar/nav.dart';
import '../navbar/pages/privacy_policy.dart';
//import 'quiz.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.home;
  final InAppReview inAppReview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.home) {
      container = DashboardPage();
    } else if (currentPage == DrawerSections.rating) {
      container = PrivacyPolicy();
    } else if (currentPage == DrawerSections.apps) {
      container = HomePage();
    } else if (currentPage == DrawerSections.contact) {
      container = ContactPage();
    } else if (currentPage == DrawerSections.exit) {
      container = PrivacyPolicy();
    } else if (currentPage == DrawerSections.privacyPolicy) {
      container = PrivacyPolicy();
    }
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        flexibleSpace: Container(),
        title: Center(
            child: Text(
          "سياقتي",
          style: Theme.of(context).textTheme.headlineMedium,
        )),
      ),
      body: container,
      endDrawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Drawer(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  MyHeaderDrawer(),
                  MyDrawerList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "الرئيسة", Icons.home,
              currentPage == DrawerSections.home ? true : false),
          menuItem(2, "تقييم التطبيق", Icons.rate_review,
              currentPage == DrawerSections.rating ? true : false),
          menuItem(3, "مشاركة التطبيق", Icons.share,
              currentPage == DrawerSections.apps ? true : false),
          menuItem(4, "تواصل معنا", CupertinoIcons.paperplane,
              currentPage == DrawerSections.contact ? true : false),
          Divider(),
          menuItem(5, "سياسة الخصوصية", Icons.privacy_tip,
              currentPage == DrawerSections.exit ? true : false),
          menuItem(6, "خروج", Icons.exit_to_app,
              currentPage == DrawerSections.privacyPolicy ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Container(
      child: Material(
        color: selected ? Colors.grey[300] : Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
            setState(() {
              if (id == 1) {
                currentPage = DrawerSections.home;
              } else if (id == 2) {
                Future<void> _requestReview() => inAppReview.requestReview();
                _requestReview();
              } else if (id == 3) {
                Share.share(
                  'https://play.google.com/store/apps/developer?id=Agadev+Solutions',
                  subject: 'تحقق من التطبيق الخاص بي!',
                );
              } else if (id == 4) {
                currentPage = DrawerSections.contact;
              } else if (id == 5) {
                currentPage = DrawerSections.exit;
              } else if (id == 6) {
                currentPage = DrawerSections.home;
                showAlertDialog();
                //SystemNavigator.pop();
                //exit(0);
              }
            });
          },
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    textDirection: TextDirection.rtl,
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  child: Icon(
                    icon,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // btn rating  //

  ///////// botton exit nave bare
  void showAlertDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'تسجيل الخروج',
              textDirection: TextDirection.rtl,
            ),
            content: const Text(
              'هل أنت متأكد أنك تريد الخروج؟',
              textDirection: TextDirection.rtl,
            ),
            actions: [
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('لا')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    // Write code to delete item
                    SystemNavigator.pop();
                    exit(0);
                  },
                  child: const Text(
                    'نعم',
                  )),
            ],
          );
        });
  }
}

enum DrawerSections {
  home,
  rating,
  apps,
  contact,
  privacyPolicy,
  exit,
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items(
      {required this.title,
      required this.subtitle,
      required this.event,
      required this.img});
}
