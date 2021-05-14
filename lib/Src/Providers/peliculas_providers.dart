import 'dart:async';
import 'dart:convert';
import 'package:flutter_peliculas_2021/Src/Models/actor_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_peliculas_2021/Src/Models/pelicula_model.dart';

class PeliculaProvider {
  final String _apiKey = "324f660cfd9d984ba74e315eca1e0c06";
  final String _url = "api.themoviedb.org";
  final String _language = "es-ES";
  final List<Pelicula> _popularMovis = [];
  bool _loading = false;
  int _pagePopular = 0;

  final _streamController = new StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularMovieSink => _streamController.sink.add;
  Stream<List<Pelicula>> get popularMovieStream => _streamController.stream;

  void disposible() {
    _streamController?.close();
  }

  Future<List<Pelicula>> getEnCine() async {
    final url = Uri.https(_url, "3/movie/now_playing", {
      'api_key': _apiKey,
      'language': _language,
    });
    return _getList(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_loading) return [];
    _loading = true;
    _pagePopular++;

    final url = Uri.https(_url, "3/movie/popular", {
      'api_key': _apiKey,
      'language': _language,
      'page': _pagePopular.toString(),
    });
    final peliResponse = await _getList(url);
    _popularMovis.addAll(peliResponse);
    popularMovieSink(_popularMovis);
    _loading = false;
    return peliResponse;
  }

  Future<List<Actor>> getActors(int movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });
    try {
      final resp = await http.get(url);
      final jsonResponse = json.decode(resp.body);
      final cast = new Cast.fronmJsonList(jsonResponse['cast']);
      return cast.actores;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Pelicula>> searchMovie(String query) async {
    final url = Uri.https(_url, "3/search/movie", {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });
    return _getList(url);
  }

  Future<List<Pelicula>> _getList(Uri url) async {
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);
      final listPeliculas = new Peliculas.fronmJsonList(decodedData['results']);
      return listPeliculas.childMovies;
    } else {
      return [];
    }
  }
}
