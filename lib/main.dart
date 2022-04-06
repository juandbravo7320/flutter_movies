import 'package:flutter/material.dart';

import 'package:peliculas/screens/screens.dart';
import 'package:peliculas/themes/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:peliculas/providers/movies_provider.dart';

void main() => runApp(const AppState());

//? Este widget 'AppState' lo usamos para mantener el estado
//? de la aplicación, el estado de 'MoviesProvider'.
//? Lo hacemos en el 'main' porque necesitamos que el provider
//? sea visible para toda la aplicación
class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //? Debemos inicializar la intancia del provider 'MoviesProvider'
        ChangeNotifierProvider(
          create: (BuildContext context) => MoviesProvider(),
          //? 'lazy' se usa ya que por defecto, el provider se instancia de
          //? manera perezosa, sin embargo, nosotros necesitamos que cuando
          //? se cree la aplicación, también se instancie el provider, por
          //? ponemos 'lazy' en false
          lazy: false,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => const HomeScreen(),
        'details': (BuildContext context) => const DetailsScreen(),
      },
      theme: AppTheme.lightTheme,
    );
  }
}
