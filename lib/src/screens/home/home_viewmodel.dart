import 'package:find_logistic/src/app/model/activities_model.dart';
import 'package:find_logistic/src/app/model/driver_orders_model.dart';
import 'package:find_logistic/src/app/service/network/network.dart';
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
    print('here');
    print(body);
    if (response.statusCode == 200) {
      if (body['status'] == true) {
        state = state.copyWith(
            orders: List<DriverOrders>.from(body['data']['my_orders']
                .map((x) => DriverOrders.fromJson(x))));
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
