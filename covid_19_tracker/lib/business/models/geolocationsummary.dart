class GeoLocationSummary {
  List<Locations> locations;

  GeoLocationSummary({this.locations});

  GeoLocationSummary.fromJson(Map<String, dynamic> json) {
    if (json['locations'] != null) {
      locations = new List<Locations>();
      json['locations'].forEach((v) {
        locations.add(new Locations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.locations != null) {
      data['locations'] = this.locations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Locations {
  Coordinates coordinates;
  String country;
  String countryCode;
  int id;
  String lastUpdated;
  Latest latest;
  String province;

  Locations(
      {this.coordinates,
      this.country,
      this.countryCode,
      this.id,
      this.lastUpdated,
      this.latest,
      this.province});

  Locations.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'] != null
        ? new Coordinates.fromJson(json['coordinates'])
        : null;
    country = json['country'];
    countryCode = json['country_code'];
    id = json['id'];
    lastUpdated = json['last_updated'];
    latest =
        json['latest'] != null ? new Latest.fromJson(json['latest']) : null;
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates.toJson();
    }
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['id'] = this.id;
    data['last_updated'] = this.lastUpdated;
    if (this.latest != null) {
      data['latest'] = this.latest.toJson();
    }
    data['province'] = this.province;
    return data;
  }
}

class Coordinates {
  String latitude;
  String longitude;

  Coordinates({this.latitude, this.longitude});

  Coordinates.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
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
