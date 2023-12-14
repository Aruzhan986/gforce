import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gforce/presentation/constants/constants.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GeolocationScreen extends StatefulWidget {
  @override
  _GeolocationScreenState createState() => _GeolocationScreenState();
}

class _GeolocationScreenState extends State<GeolocationScreen> {
  Location _location = Location();
  LatLng? _currentPosition;
  LatLng? _destination;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  double _distance = 0.0;
  bool _loading = false;

  _getCurrentLocation() async {
    var locationData = await _location.getLocation();
    setState(() {
      _currentPosition =
          LatLng(locationData.latitude!, locationData.longitude!);
      _markers.add(Marker(
        markerId: MarkerId('currentPosition'),
        position: _currentPosition!,
      ));
    });
  }

  _getPolyline(LatLng destination) async {
    setState(() {
      _loading = true;
    });
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyAL6WXNDg6KnE_eeh5jItqtrxq3uQtqtqY",
      PointLatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    List<PointLatLng> points = result.points;
    if (points.isNotEmpty) {
      setState(() {
        _polylines.add(
          Polyline(
            polylineId: PolylineId("route"),
            visible: true,
            points: points.map((e) => LatLng(e.latitude, e.longitude)).toList(),
            color: PrimaryColors.Colorseven,
          ),
        );

        _distance = calculateDistance(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          destination.latitude,
          destination.longitude,
        );
        _loading = false;
      });
    }
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371;
    var dLat = _degreesToRadians(lat2 - lat1);
    var dLon = _degreesToRadians(lon2 - lon1);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var distance = R * c;
    return distance;
  }

  double _degreesToRadians(degrees) {
    return degrees * pi / 180;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(0, 0),
              zoom: 10.0,
            ),
            markers: _markers,
            polylines: _polylines,
            onMapCreated: (GoogleMapController controller) {
              _getCurrentLocation();
            },
            onTap: (LatLng position) {
              setState(() {
                _destination = position;
                _markers.add(
                  Marker(
                    markerId: MarkerId('destination'),
                    position: _destination!,
                  ),
                );
                _getPolyline(_destination!);
              });
            },
          ),
          if (_loading) Center(child: CircularProgressIndicator()),
          if (_distance > 0)
            Positioned(
              bottom: 20,
              left: 20,
              child: Material(
                color: PrimaryColors.Colorfour,
                elevation: 4.0,
                borderRadius: BorderRadius.circular(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Distance: ${_distance.toStringAsFixed(2)} km'),
                ),
              ),
            )
        ],
      ),
    );
  }
}
