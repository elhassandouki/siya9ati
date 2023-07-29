import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  String? _privacyPolicy;

  @override
  void initState() {
    super.initState();
    loadPrivacyPolicy();
  }

  Future<void> loadPrivacyPolicy() async {
    String data =
        await rootBundle.loadString('assets/data/privacy_policy.json');
    Map<String, dynamic> jsonData = jsonDecode(data);
    setState(() {
      _privacyPolicy = jsonData['description'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            _privacyPolicy ?? 'جارٍ تحميل سياسة الخصوصية ...',
            textDirection: TextDirection.rtl,
          ),
        ),
      ),
    );
  }
}
