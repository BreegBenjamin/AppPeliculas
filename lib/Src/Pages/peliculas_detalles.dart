import 'package:flutter/material.dart';
import 'package:flutter_peliculas_2021/Src/Models/actor_model.dart';
import 'package:flutter_peliculas_2021/Src/Models/pelicula_model.dart';
import 'package:flutter_peliculas_2021/Src/Providers/peliculas_providers.dart';

class PeliculaDetallePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(pelicula),
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
            SizedBox(height: 12.0),
            _posterTitle(context, pelicula),
            _description(pelicula),
            SizedBox(height: 20.0),
            _createaCast(pelicula),
          ]))
        ],
      ),
    );
  }

  Widget _createAppBar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImage()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _posterTitle(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                pelicula.getPosterImage(),
                height: 180.0,
              ),
            ),
          ),
          SizedBox(width: 15.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(
                      pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _description(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _createaCast(Pelicula pelicula) {
    final provider = new PeliculaProvider();
    return FutureBuilder(
      future: provider.getActors(pelicula.id),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _createActorsPageView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createActorsPageView(List<Actor> actors) {
    return Container(
      height: 200,
      child: PageView.builder(
        itemCount: actors.length,
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        itemBuilder: (context, int i) {
          return _actorCart(actors[i]);
        },
      ),
    );
  }

  Widget _actorCart(Actor actor) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FadeInImage(
              height: 150,
              image: NetworkImage(actor.getPicture()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          Text(
            actor.originalName,
            style: TextStyle(fontSize: 13.0),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
