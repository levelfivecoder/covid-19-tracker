class DashboardSummary {
  Latest latest;

  DashboardSummary({this.latest});

  DashboardSummary.fromJson(Map<String, dynamic> json) {
    latest =
        json['latest'] != null ? new Latest.fromJson(json['latest']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.latest != null) {
      data['latest'] = this.latest.toJson();
    }
    return data;
  }
}

class Latest {
  int confirmed;
  int deaths;
  int recovered;

  Latest({this.confirmed, this.deaths, this.recovered});

  Latest.fromJson(Map<String, dynamic> json) {
    confirmed = json['confirmed'];
    deaths = json['deaths'];
    recovered = json['recovered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirmed'] = this.confirmed;
    data['deaths'] = this.deaths;
    data['recovered'] = this.recovered;
    return data;
  }
}
