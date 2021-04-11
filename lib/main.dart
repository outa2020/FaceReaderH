import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'face_page.dart';
import 'model/mesures_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MesuresData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xff0a0e21),
          scaffoldBackgroundColor: Color(0xff0a0e21),
        ),
        home: FacePage(),
      ),
    );
  }
}
