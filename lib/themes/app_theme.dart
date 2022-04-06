import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.indigo;

  //? Tema claro de la aplicación
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    // Color primario
    primaryColor: primary,

    //AppBar Theme
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0.0,
    ),

    //TextButton Theme

    // FLoatingActionButtons

    //ElevatedButtons

    //TextFormField
  );

  //? Tema oscuro de la aplicación
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    // Color primario
    primaryColor: primary,

    //AppBar Theme
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0.0,
    ),

    scaffoldBackgroundColor: Colors.black,
  );
}
