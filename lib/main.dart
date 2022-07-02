import 'package:esh7n/providers/dialog_provider.dart';
import 'package:esh7n/providers/etisalat_provider.dart';
import 'package:esh7n/providers/orange_provider.dart';
import 'package:esh7n/providers/we_provider.dart';
import 'package:esh7n/screens/home.dart';
import 'package:esh7n/providers/vodafone_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => VodafoneProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EtisalatProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrangeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AlertDialogProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      ),
    );
  }
}
