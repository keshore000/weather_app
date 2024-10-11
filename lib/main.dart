import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'weatherscreen.dart';
import 'wprovider.dart';

void main() {
  runApp(
    MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_) => weatherprovider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
}

