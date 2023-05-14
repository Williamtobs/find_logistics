import 'package:find_logistic/src/app/constant/app_string.dart';
import 'package:find_logistic/src/app/service/network/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverMapViewModel extends StateNotifier<DriverMapState> {
  DriverMapViewModel(this._network) : super(DriverMapState());
  final Network _network;

  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();

  getDirections(lat, lng, latTo, lngTo) async {
    List<LatLng> polylineCoordinates = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      mapApiKey,
      PointLatLng(lat, lng),
      PointLatLng(latTo, lngTo),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print(result.errorMessage);
    }
    PolylineId id = const PolylineId("logistic_path");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
  }
}

class DriverMapState {
  final bool isLoading;

  DriverMapState({
    this.isLoading = false,
  });

  DriverMapState copyWith({
    bool? isLoading,
  }) {
    return DriverMapState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
