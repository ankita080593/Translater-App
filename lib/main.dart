import 'package:flutter/material.dart';
import 'package:translateapp/HomeScreen.dart';
import 'package:translator/translator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: Colors.blue, // A standard blue color
      primaryVariant: Colors.blue[800], // A darker shade of blue
      secondary: Colors.deepPurple.shade200, // A standard deep purple color
      secondaryVariant: Colors.deepPurple[700], // A darker shade of deep purple
      surface: Colors.white, // Surface color
      background: Colors.deepPurple.shade50, // Background color
      error: Colors.red, // Error color
      onPrimary: Colors.white, // Text on primary color
      onSecondary: Colors.white, // Text on secondary color
      onSurface: Colors.black, // Text on surface color
      onBackground: Colors.black, // Text on background color
      onError: Colors.white, // Text on error color
      brightness: Brightness.light, // Brightness
    );

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: colorScheme.primary,
        primaryColorDark: colorScheme.primaryVariant,
        primaryColorLight: colorScheme.primary,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.background,
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          labelStyle: TextStyle(fontSize: 18, color: colorScheme.onSurface),
        ),
        textTheme: TextTheme(
          headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          subtitle1: TextStyle(fontSize: 18),
          bodyText1: TextStyle(fontSize: 18),
          bodyText2: TextStyle(fontSize: 18),
        ),
      ),
      home: MyHomePage(),
    );
  }
}