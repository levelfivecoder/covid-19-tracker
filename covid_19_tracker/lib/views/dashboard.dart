import 'package:covid_19_tracker/views/business/enums/status.dart';
import 'package:covid_19_tracker/views/customviews/tileview.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  final Color color;

  Dashboard(this.color);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      TileView(Status.confirmed, 20000),
      TileView(Status.deaths, 20000),
      TileView(Status.recovered, 20000),
    ]);
  }
}
