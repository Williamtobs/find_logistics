import 'package:find_logistic/src/app/model/activities_model.dart';
import 'package:find_logistic/src/app/service/network/network.dart';
import 'package:riverpod/riverpod.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel(this.network) : super(HomeState(activities: []));

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
}

class HomeState {
  final List<RecentActivitiesModel> activities;

  HomeState({required this.activities});

  HomeState copyWith({List<RecentActivitiesModel>? activities}) {
    return HomeState(activities: activities ?? this.activities);
  }
}
