import 'package:covid_19_tracker/business/models/geolocationsummary.dart';
import 'package:covid_19_tracker/business/models/summary.dart';
import 'package:covid_19_tracker/services/restservice.dart';
import 'dart:math';

class CovidRepository {
  RestService _provider = RestService();

  Future<Summary> fetchSummary() async {
     var rng = new Random();
    final response = await _provider.get("v2/latest?token="+ rng.nextInt(1000000).toString());
    return Summary.fromJson(response);
  }
  Future<GeoLocationSummary> fetchLocationSummary() async {
     var rng = new Random();
    final response = await _provider.get("v2/locations?token="+ rng.nextInt(1000000).toString());
    return GeoLocationSummary.fromJson(response);
  }
}