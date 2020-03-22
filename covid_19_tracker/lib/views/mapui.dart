import 'dart:async';
import 'dart:ui';
import 'package:covid_19_tracker/business/models/geolocationsummary.dart';
import 'package:covid_19_tracker/business/repository/covidrepository.dart';
import 'package:covid_19_tracker/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:location/location.dart';

class MapUi extends StatefulWidget {
  @override
  _MapUiState createState() => _MapUiState();
}

class _MapUiState extends State<MapUi> {
  GoogleMapController mapController;
  bool _isLoading = false;

  LatLng pinPosition = LatLng(45.521563, -122.677433);
  static Future<BitmapDescriptor> _getClusterMarker(
    int clusterSize,
    Color clusterColor,
    Color textColor,
    int width,
  ) async {
    assert(clusterSize != null);
    assert(clusterColor != null);
    assert(width != null);

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = clusterColor;
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    final double radius = width / 2;

    canvas.drawCircle(
      Offset(radius, radius),
      radius,
      paint,
    );

    textPainter.text = TextSpan(
      text: clusterSize.toString(),
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(radius - textPainter.width / 2, radius - textPainter.height / 2),
    );

    final image = await pictureRecorder.endRecording().toImage(
          radius.toInt() * 2,
          radius.toInt() * 2,
        );
    final data = await image.toByteData(format: ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

  final LatLng _center = const LatLng(45.521563, -122.677433);
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    getLocation();
    loadData();
    
  }

  void getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return null;
      }
    }

     var locationData= await location.getLocation();
     setState(() {
       pinPosition = LatLng(locationData.latitude, locationData.longitude);
     });
     

  }

  void loadData() async {
    setState(() {
      _isLoading = true;
    });

   GeoLocationSummary locationSummary =
        await CovidRepository().fetchLocationSummary();
    setState(() {
      _isLoading = false;
    });
    Set<Marker> _markersTemp = {};
    if (locationSummary != null && locationSummary.locations != null) {
      for (var i = 0; i < locationSummary.locations.length; i++) {
        if (locationSummary.locations[i].latest.confirmed != 0) {
          double lat =
              double.parse(locationSummary.locations[i].coordinates.latitude);
          double long =
              double.parse(locationSummary.locations[i].coordinates.longitude);
          var icon = await _getClusterMarker(
              locationSummary.locations[i].latest.confirmed,
              Color(0x44f5427e),
              Colors.black,
              locationSummary.locations[i].latest.confirmed < 10000 ? 60 : 100);
              _markersTemp.add(Marker(
              markerId: MarkerId(locationSummary.locations[i].id.toString()),
              position: LatLng(lat, long),
              icon: icon,
              infoWindow: InfoWindow(
              title:
                  "${locationSummary.locations[i].province != null ? locationSummary.locations[i].province : ''}-${locationSummary.locations[i].country}",
              snippet:
                  "Confirmed: ${locationSummary.locations[i].latest.confirmed} Death: ${locationSummary.locations[i].latest.deaths} Recovered: ${locationSummary.locations[i].latest.recovered}",
              ),
              visible: true));
        }
      }
    }
    setState(() {
      _markers = _markersTemp;
    });
    
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    // mapController.setMapStyle(Utils.mapStyles);
  }

  @override
  Widget build(BuildContext context){
    // these are the minimum required values to set
    // the camera position
    CameraPosition initialLocation =
        CameraPosition(zoom: 5, bearing: 0, target: pinPosition);
     
    return !_isLoading
        ? GoogleMap(
            myLocationEnabled: true,
            compassEnabled: true,
            markers: _markers,
            initialCameraPosition: initialLocation,
            onMapCreated: _onMapCreated)
        : Container(
            child: Center(
            child: Loading(
                indicator: BallPulseIndicator(),
                size: 40.0,
                color: Color(0xFFD15D1F)),
          ));
  }
}
