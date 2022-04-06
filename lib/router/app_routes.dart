import 'package:flutter/material.dart';

import '../screens/screens.dart';

//? En este caso estamos creando una clase 'AppRoutes'
//? Para manejar las rutas de nuestra aplicación

//? Creamos una constante estática, para poder acceder a ella
//? sin necesidad de crear una instancia de la clase

class AppRoutes {
  static const initialRoute = 'home';

  static final menuOptions = [];

  //? Aqui queremos lograr, que basado en el array 'menuOptions' que hemos cerado arriba
  //? podamos generar las rutas que etán abajo de este comentario
  //? Esto con el objetivo, de que si la aplicación crece, y debemos agregar más rutas,
  //? Solo basta con agregar una nueva ruta al array 'menuOptions'

}
