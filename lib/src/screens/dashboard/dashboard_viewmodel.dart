import 'package:find_logistic/src/app/model/user.dart';
import 'package:find_logistic/src/app/service/network/network.dart';
import 'package:find_logistic/src/screens/onboarding/mode_selection.dart';
import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardViewModel extends StateNotifier<DashboardState> {
  DashboardViewModel(this.network) : super(DashboardState(user: AppUser()));

  final Network network;

  getProfile({required BuildContext context}) async {
    try {
      var res = await network.get(path: 'profile');
      var body = res.data;
      print(body);
      if (res.statusCode == 200) {
        state = state.copyWith(
          isLoading: false,
          user: AppUser.fromJson(body['data']['user']),
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      print(e);
      state = state.copyWith(isLoading: false);
      BottomSnack.errorSnackBar(
          message: 'Something went wrong, please try again later',
          context: context);
    }
  }

  logOut({required BuildContext context}) {
    network.logout(context: context);
    BottomSnack.successSnackBar(message: 'User logged out', context: context);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const UserSelectMode()),
        (route) => false);
  }
}

class DashboardState {
  final bool isLoading;
  final AppUser user;

  DashboardState({required this.user, this.isLoading = false});

  DashboardState copyWith({AppUser? user, bool? isLoading}) {
    return DashboardState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
