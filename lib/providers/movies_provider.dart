//? Esta clase será mi proveedor de información para la aplicación

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/search_response.dart';
/* import 'dart:convert'; */

import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '5e2e123f34d161da5a1cc70412d8b3f6';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');

    //? Hasta este punto 'response.body' es un String, debemos
    //? convertirlo en un Map para poder acceder a su información
    //? más facilmente
    /* final Map<String, dynamic> decodedData = json.decode(response.body); */

    //? Sin embargo, no podemos acceder a sus propiedades de manera sencilla,
    //? Para solucionar esto, mapeamos la respuesta de la petición http,
    //? Usamos el servicio de la pagina 'quickType.io'
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    /* print(nowPlayingResponse.results[0].title); */
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();

    //? Cuando en una clase extendida de 'ChangeNotifier' se realiza
    //? algún cambio, como por ejemplo, la propiedad 'onDisplayMovies' cambió
    //? de una Lista vacia, a tener los elementos obtenidos por la petición http
    //? debido a esto es necesario redibujar los Widgets que hagan uso de esta info
    //? para eso llamamos al método 'notifyListeners()'
  }

  getPopularMovies() async {
    _popularPage++;

    final jsonData = await _getJsonData('3/movie/popular', _popularPage);

    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    //? Se analiza si el cast de la pelicula ya se encuentra almacenado en la variable
    if (moviesCast.containsKey(movieId)) {
      return moviesCast[movieId]!;
    }

    print('Pidiendo info al servidor - Cast');

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }
}
