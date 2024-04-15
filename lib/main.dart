import 'package:flutter/material.dart';
import 'package:qrgenerator/QRGenerator.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     theme: ThemeData.dark(), 
      debugShowCheckedModeBanner: false, 
      home: const QRCodeGenerator(),
    );
  }
}
