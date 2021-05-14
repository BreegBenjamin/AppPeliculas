import 'package:flutter/material.dart';
import 'package:flutter_peliculas_2021/Src/Search/search_delegate.dart';
import 'package:flutter_peliculas_2021/Src/Widgets/movi_horizontal.dart';
import 'package:flutter_peliculas_2021/Src/Providers/peliculas_providers.dart';
import 'package:flutter_peliculas_2021/Src/Widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final pelisProv = new PeliculaProvider();

  @override
  Widget build(BuildContext context) {
    pelisProv.getPopulares();
    return Scaffold(
      appBar: AppBar(
        title: Text('App Peliculas'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
              //query del showSearch para hacer busquedas de inicio
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _swiperCards(),
            _cardFooter(),
          ],
        ),
      ),
    );
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: pelisProv.getEnCine(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _cardFooter() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Populares',
                style: TextStyle(fontSize: 20.0),
              )),
          StreamBuilder(
            stream: pelisProv.popularMovieStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MoviHorizontal(
                  peliculas: snapshot.data,
                  nextPage: pelisProv.getPopulares,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
