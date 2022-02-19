import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool _dark = false;

  void _getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _dark = prefs.getBool('theme')!;
    });
  }

  void _setTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('theme', _dark);
  }

  @override
  void initState() {
    super.initState();
    _getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Switch theme',
      theme: _dark ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title: const Text('Switch theme')),
        body: Center(
          child: SwitchListTile(
            title: const Text("Dark Mode"),
            onChanged: (bool value) {
              setState(() {
                _dark = value;
                _setTheme();
              });
            },
            value: _dark,
          ),
        ),
      ),
    );
  }
}
