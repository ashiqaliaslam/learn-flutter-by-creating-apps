import 'package:flutter/material.dart';

import 'home_page.dart';

class NameGeneratorApp extends StatelessWidget {
  const NameGeneratorApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the const from here
      title: 'Startup Name Generator',
      theme: ThemeData(
        // Add the 5 lines from here...
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.black,
        ),
      ), // ... to here.
      home: const RandomWords(), // And add the const back here.
    );
  }
}
