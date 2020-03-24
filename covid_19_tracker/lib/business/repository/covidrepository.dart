import 'package:covid_19_tracker/business/models/geolocationsummary.dart';
import 'package:covid_19_tracker/business/models/indiasummary.dart';
import 'package:covid_19_tracker/business/models/summary.dart';
import 'package:covid_19_tracker/services/restservice.dart';
import 'dart:math';

class CovidRepository {
  RestService _provider = RestService();

  Future<DashboardSummary> fetchSummary() async {
     var rng = new Random();
    final response = await _provider.get("v2/latest?token="+ rng.nextInt(1000000).toString(),false);
    return DashboardSummary.fromJson(response);
  }
  Future<GeoLocationSummary> fetchLocationSummary() async {
     var rng = new Random();
    final response = await _provider.get("v2/locations?token="+ rng.nextInt(1000000).toString(),false);
    return GeoLocationSummary.fromJson(response);
  }
  Future<IndiaSummary> fetchIndiaSummary() async {
     var rng = new Random();
    final response = await _provider.get("https://api.rootnet.in/covid19-in/stats/latest?token="+ rng.nextInt(1000000).toString(),true);
    return IndiaSummary.fromJson(response);
  }
}