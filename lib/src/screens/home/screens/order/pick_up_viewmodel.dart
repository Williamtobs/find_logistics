import 'package:find_logistic/src/app/constant/app_string.dart';
import 'package:find_logistic/src/screens/home/screens/order/pick_up.dart';
import 'package:find_logistic/src/screens/map/map.dart';
import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:riverpod/riverpod.dart';

class PickUpViewModel extends StateNotifier<PickUpState> {
  PickUpViewModel() : super(PickUpState(polylines: {}));

  LocatitonGeocoder geocoder = LocatitonGeocoder(mapApiKey);
  PolylinePoints polylinePoints = PolylinePoints();

  Map<PolylineId, Polyline> polylines = {};

  getDirections() async {
    List<LatLng> polylineCoordinates = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      mapApiKey,
      PointLatLng(double.parse(state.lat), double.parse(state.long)),
      PointLatLng(double.parse(state.latTo), double.parse(state.longTo)),
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

  getDeliveryLatLong({
    required BuildContext context,
    required String address,
    required String phone,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final location = await geocoder.findAddressesFromQuery(address);
      var lat = location.first.coordinates.latitude;
      var long = location.first.coordinates.longitude;
      state = state.copyWith(
        isLoading: false,
        lat: lat.toString(),
        long: long.toString(),
      );
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PickUp(
                    deliveryAddress: address,
                    deliveryNumber: phone,
                  )));
    } catch (e) {
      state = state.copyWith(isLoading: false);
      BottomSnack.errorSnackBar(
          message: 'Something went wrong', context: context);
      rethrow;
    }
  }

  getLonglang({
    required BuildContext context,
    required String address,
    required String addressTo,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final location = await geocoder.findAddressesFromQuery(addressTo);
      var lat = location.first.coordinates.latitude;
      var long = location.first.coordinates.longitude;
      getDirections();
      state = state.copyWith(
        isLoading: false,
        latTo: lat.toString(),
        longTo: long.toString(),
      );
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MapScreen(
                    address: address,
                    addressTo: addressTo,
                  )));
    } catch (e) {
      state = state.copyWith(isLoading: false);
      BottomSnack.errorSnackBar(
          message: 'Something went wrong', context: context);
      rethrow;
    }
  }
}

class PickUpState {
  final bool isLoading;
  final String lat;
  final String long;
  final String latTo;
  final String longTo;
  final Map<PolylineId, Polyline> polylines;

  PickUpState({
    this.isLoading = false,
    this.lat = '',
    this.long = '',
    this.latTo = '',
    this.longTo = '',
    required this.polylines,
  });

  PickUpState copyWith({
    bool? isLoading,
    String? lat,
    String? long,
    String? latTo,
    String? longTo,
    Map<PolylineId, Polyline>? polylines,
  }) {
    return PickUpState(
      isLoading: isLoading ?? this.isLoading,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      latTo: latTo ?? this.latTo,
      longTo: longTo ?? this.longTo,
      polylines: polylines ?? this.polylines,
    );
  }
}
