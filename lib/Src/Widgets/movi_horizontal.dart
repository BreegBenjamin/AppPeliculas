import 'package:flutter/material.dart';
import 'package:flutter_peliculas_2021/Src/Models/pelicula_model.dart';

class MoviHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function nextPage;

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  MoviHorizontal({@required this.peliculas, @required this.nextPage});
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      width: double.infinity,
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, int index) {
          return _cards(context, peliculas[index]);
        },
      ),
    );
  }

  Widget _cards(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = "${pelicula.id}-poster";
    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImage()),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption)
        ],
      ),
    );
    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: pelicula);
      },
    );
  }
}
