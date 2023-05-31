import 'package:find_logistic/src/app/model/activities_model.dart';
import 'package:find_logistic/src/app/model/driver_orders_model.dart';
import 'package:find_logistic/src/app/service/network/network.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_geocoder/geocoder.dart';
import 'package:riverpod/riverpod.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel(this.network) : super(HomeState(activities: [], orders: []));

  final Network network;

  fetchRecentActivities() async {
    final response = await network.get(path: 'activities');
    var body = response.data;
    if (response.statusCode == 200) {
      if (body['status'] == true) {
        state = state.copyWith(
            activities: List<RecentActivitiesModel>.from(body['data']
                    ['recent_activity']
                .map((x) => RecentActivitiesModel.fromJson(x))));
      }
    }
  }

  getOrders() async {
    final response = await network.get(path: 'order/check');
    var body = response.data;
    if (response.statusCode == 200) {
      if (body['status'] == true) {
        state = state.copyWith(
            orders: List<DriverOrders>.from(body['data']['my_orders']
                .map((x) => DriverOrders.fromJson(x))));
      }
    }
  }

  updateDriverLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    Position? currentPosition;
    if (permission != LocationPermission.denied ||
        permission != LocationPermission.deniedForever) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentPosition = position;
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark place = placemarks[0];
      final response = await network.postWithToken(path: 'location', formData: {
        'latitude': currentPosition.latitude,
        'longitude': currentPosition.longitude,
        'address': '${place.street}, ${place.locality}, ${place.country}'
      });
      var body = response.data;
      if (response.statusCode == 200) {
        if (body['status'] == true) {
          if (kDebugMode) {
            print('$body Location Updated');
          }
        }
      }
    }
  }
}

class HomeState {
  final List<RecentActivitiesModel> activities;
  final List<DriverOrders> orders;

  HomeState({required this.activities, required this.orders});

  HomeState copyWith(
      {List<RecentActivitiesModel>? activities, List<DriverOrders>? orders}) {
    return HomeState(
      activities: activities ?? this.activities,
      orders: orders ?? this.orders,
    );
  }
}
