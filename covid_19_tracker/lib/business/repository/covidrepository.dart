import 'package:covid_19_tracker/business/models/summary.dart';
import 'package:covid_19_tracker/services/restservice.dart';

class CovidRepository {
  RestService _provider = RestService();

  Future<Summary> fetchSummary() async {
    final response = await _provider.get("v2/latest");
    return Summary.fromJson(response);
  }
}