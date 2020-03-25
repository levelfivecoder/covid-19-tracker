import 'package:covid_19_tracker/business/enums/status.dart';
import 'package:covid_19_tracker/business/models/summary.dart';
import 'package:covid_19_tracker/business/repository/covidrepository.dart';
import 'package:covid_19_tracker/views/customviews/tileview.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class Dashboard extends StatefulWidget {
  final Color color;
  Dashboard(this.color);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DashboardSummary _summary;
  @override
  void initState() {
    super.initState();
    listenForSummary();
  }

  void listenForSummary() async {
    DashboardSummary summaryFromApi = await CovidRepository().fetchSummary();
    setState(() {
      _summary = summaryFromApi;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _summary != null
        ? ListView(children: <Widget>[
            TileView(Status.confirmed, _summary.latest.confirmed),
            TileView(Status.deaths, _summary.latest.deaths),
            if (_summary.latest.recovered > 0)
              TileView(Status.recovered, _summary.latest.recovered),
          ])
        : Container(
            child: Center(
            child: Loading(
                indicator: BallPulseIndicator(),
                size: 40.0,
                color: Color(0xFFD15D1F)),
          ));
  }
}
