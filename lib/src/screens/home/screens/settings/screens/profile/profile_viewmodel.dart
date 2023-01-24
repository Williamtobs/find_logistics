import 'package:find_logistic/src/app/model/user.dart';
import 'package:find_logistic/src/app/service/network/network.dart';
import 'package:find_logistic/src/screens/home/home.dart';
import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

class ProfileViewModel extends StateNotifier<ProfileState> {
  ProfileViewModel(this.network, this.ref)
      : super(ProfileState(user: AppUser()));

  final Network network;
  final Ref ref;

  updateProfile({required BuildContext context, required var formData}) async {
    try {
      state = state.copyWith(isLoading: true);
      final response = await network.postWithToken(
          formData: formData, path: 'update/profile');
      var body = response.data;
      if (response.statusCode == 200) {
        BottomSnack.successSnackBar(message: body['message'], context: context);
        ref.read(dashboardProvider.notifier).getProfile(context: context);
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
            (route) => false);
      } else {
        state = state.copyWith(isLoading: false);
        BottomSnack.errorSnackBar(message: body['message'], context: context);
      }
    } catch (e) {
      print(e);
      state = state.copyWith(isLoading: false);
      BottomSnack.errorSnackBar(
          message: 'Something went wrong, please try again later',
          context: context);
    }
  }
}

class ProfileState {
  final bool isLoading;
  final AppUser user;

  ProfileState({
    this.isLoading = false,
    required this.user,
  });

  ProfileState copyWith({
    bool? isLoading,
    AppUser? user,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
    );
  }
}
