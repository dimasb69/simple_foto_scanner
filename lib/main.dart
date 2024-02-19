import 'package:flutter/material.dart';
import 'package:pdf_ocr/pages/scan.dart';
import 'func_const/permmisions.dart';

bool screns = true;

void main() => runApp(const Main());

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Easy Gif Finder",
      theme: ThemeData().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xBE95E3A4),
        ),
        scaffoldBackgroundColor: const Color(0xca5c8486),
      ),


      home: const MaingPage(),
    );
  }
}

class MaingPage extends StatefulWidget {
  const MaingPage({Key? key}) : super(key: key);

  @override
  _MaingPageState createState() => _MaingPageState();
}

class _MaingPageState extends State<MaingPage> {
  @override
  Widget build(BuildContext context) {
    checkPermission(context);
      return const Scan();
  }
}
