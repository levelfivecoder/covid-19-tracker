import 'package:covid_19_tracker/business/models/indiasummary.dart';
import 'package:covid_19_tracker/business/repository/covidrepository.dart';
import 'package:covid_19_tracker/views/customviews/indiatileview.dart';
import 'package:covid_19_tracker/views/customviews/statetileview.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class IndiaPage extends StatefulWidget {
  @override
  _IndiaPageState createState() => _IndiaPageState();
}

class _IndiaPageState extends State<IndiaPage> {
  IndiaSummary _summary;
  @override
  void initState() {
    super.initState();
    listenForSummary();
  }

  void listenForSummary() async {
    IndiaSummary summaryFromApi = await CovidRepository().fetchIndiaSummary();
    setState(() {
      _summary = summaryFromApi;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _summary != null
        ? Container(
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Last updated: ' + _summary.lastRefreshed,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                IndiaTileView(_summary.data.summary),
                Text(
                  'State level stats',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Flexible(
                  child: _getListView(),
                ),
              ],
            ),
          )
        : Container(
            child: Center(
            child: Loading(
                indicator: BallPulseIndicator(),
                size: 40.0,
                color: Color(0xFFD15D1F)),
          ));
  }

  Widget _getListView() {
    if (_summary != null &&
        _summary.data != null &&
        _summary.data.regional != null) {
      return new ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          itemCount: _summary.data.regional.length,
          itemBuilder: (context, index) {
            return new StateTileView(_summary.data.regional.elementAt(index));
          });
    } else {
      return Text(
        'No information found',
        style: TextStyle(color: Colors.white, fontSize: 20),
      );
    }
  }
}
