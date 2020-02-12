import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_adressbook/models/contact.dart';
import 'package:mobile_adressbook/services/json_service.dart';
import 'contact_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    initContactData();
  }

  void initContactData() async {
    Results results = await JsonHelper().getContactData();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ContactScreen(
                results: results,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
