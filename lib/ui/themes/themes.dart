import 'package:flutter/material.dart';
class CustomThemes{
  static TextStyle errorTextStyle=const TextStyle(
    fontSize: 22,color: Colors.red
  );
  static List<ThemeData> themes=[
    ThemeData(
        primarySwatch: Colors.teal,
      iconTheme: const IconThemeData(
        color: Colors.teal
      )
    ),
    ThemeData(
        primarySwatch: Colors.deepOrange,iconTheme: const IconThemeData(
        color: Colors.deepOrange
    )
    ),
    ThemeData(
        primarySwatch: Colors.blue,
        iconTheme: const IconThemeData(
            color: Colors.blue
        )
     ),
    ThemeData(
        primarySwatch: Colors.cyan,
        iconTheme: const IconThemeData(
            color: Colors.cyan
        )
    ),
  ];
}