import 'package:flutter/material.dart';
import 'package:flutter_peliculas_2021/Src/Models/pelicula_model.dart';
import 'package:flutter_peliculas_2021/Src/Providers/peliculas_providers.dart';

class DataSearch extends SearchDelegate {
  final peliculaProvider = new PeliculaProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones del AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Iconos a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
        future: peliculaProvider.searchMovie(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {
            return _createList(context, snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }
  }

  Widget _createList(BuildContext context, List<Pelicula> peliculas) {
    final List<Widget> listTileMovi = [];
    peliculas.forEach((peli) {
      final widgetTemp = ListTile(
        leading: FadeInImage(
          width: 50.0,
          image: NetworkImage(peli.getPosterImage()),
          placeholder: NetworkImage('assets/img/no-image.jpg'),
          fit: BoxFit.fill,
        ),
        title: Text(peli.title),
        subtitle: Text(peli.originalTitle),
        onTap: () {
          peli.uniqueId = '${peli.id}-search';
          Navigator.pushNamed(context, 'details', arguments: peli);
        },
      );
      listTileMovi.add(widgetTemp);
    });
    return ListView(
      children: listTileMovi,
    );
  }
}
