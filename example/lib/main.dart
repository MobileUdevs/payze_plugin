import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:payze_plugin/payze_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _payzePlugin = PayzePlugin.instance;

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<bool> initPlatformState() async {
    bool? platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _payzePlugin.payzeOpen(
            Payze(
              number: "number",
              cardHolder: "cardHolder",
              expirationDate: "expirationDate",
              securityNumber: "securityNumber",
              transactionId: "transactionId",
            ),
          ) ??
          false;
    } on PlatformException {
      platformVersion = false;
    }

    return platformVersion;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(
          child: TextButton(
            onPressed: () {
              initPlatformState();
            },
            child: const Text('Get Platform version'),
          ),
        ),
      ),
    );
  }
}
