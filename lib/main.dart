import 'package:flutter/material.dart';
import 'package:flutter_peliculas_2021/Src/Pages/home_page.dart';
import 'package:flutter_peliculas_2021/Src/Pages/peliculas_detalles.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (_) => HomePage(),
        'details': (_) => PeliculaDetallePage(),
      },
    );
  }
}
