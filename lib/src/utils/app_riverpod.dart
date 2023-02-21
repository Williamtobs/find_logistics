import 'package:dio/dio.dart';
import 'package:find_logistic/src/app/service/network/network.dart';
import 'package:find_logistic/src/app/service/network/network_impl.dart';
import 'package:find_logistic/src/screens/auth/login/login_viewmodel.dart';
import 'package:find_logistic/src/screens/auth/customer/register/signup_viewmodel.dart';
import 'package:find_logistic/src/screens/auth/forgot_password/forgot_password_viewmodel.dart';
import 'package:find_logistic/src/screens/home/dashboard_viewmodel.dart';
import 'package:find_logistic/src/screens/home/home_viewmodel.dart';
import 'package:find_logistic/src/screens/home/screens/order/order_dispatch_viewmodel.dart';
import 'package:find_logistic/src/screens/home/screens/order/pick_up_viewmodel.dart';
import 'package:find_logistic/src/screens/home/screens/settings/screens/profile/profile_viewmodel.dart';
import 'package:find_logistic/src/screens/map/map_viewmodel.dart';
import 'package:find_logistic/src/screens/wallet/wallet_screen_viewmodel.dart';
import 'package:riverpod/riverpod.dart';

//Services provider
final networkProvider = Provider<Network>((ref) {
  return NetworkImpl(dio: Dio(), ref: ref);
});

//App Provider
final walletProvider =
    StateNotifierProvider<WalletViewModel, WalletState>((ref) {
  return WalletViewModel(
    ref.read(networkProvider),
  );
});

final loginProvider = StateNotifierProvider<LoginViewModel, LoginState>((ref) {
  return LoginViewModel(ref.read(networkProvider));
});

final registerProvider =
    StateNotifierProvider<SignupViewModel, SignupState>((ref) {
  return SignupViewModel(ref.read(networkProvider));
});

final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordViewModel, ForgotPasswordState>((ref) {
  return ForgotPasswordViewModel(ref.read(networkProvider));
});

final dashboardProvider =
    StateNotifierProvider<DashboardViewModel, DashboardState>((ref) {
  return DashboardViewModel(ref.read(networkProvider));
});

final homeProvider = StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  return HomeViewModel(ref.read(networkProvider));
});

final profileProvider =
    StateNotifierProvider<ProfileViewModel, ProfileState>((ref) {
  return ProfileViewModel(ref.read(networkProvider), ref);
});

final pickUpProvider =
    StateNotifierProvider<PickUpViewModel, PickUpState>((ref) {
  return PickUpViewModel();
});

final orderProvider = StateNotifierProvider<OrderViewModel, OrderState>((ref) {
  return OrderViewModel(ref.read(networkProvider));
});

final mapProvider = StateNotifierProvider<MapViewModel, MapState>((ref) {
  return MapViewModel(ref.read(networkProvider));
});
