import 'package:covid_19_tracker/views/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(BaseApplication());

class BaseApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test',
      
      home: Home(),
    );
  }
}
