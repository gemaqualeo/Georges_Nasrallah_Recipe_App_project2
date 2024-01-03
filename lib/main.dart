import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
   Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Recipe APP',
        debugShowCheckedModeBanner: false,
       theme: ThemeData(
        primarySwatch: Colors.blue,
         primaryColor: Colors.white,
         textTheme: const TextTheme(
         bodyMedium: TextStyle(color: Colors.white),
         ),
          ),
         home: const HomePage(),
         );
  }
  }

