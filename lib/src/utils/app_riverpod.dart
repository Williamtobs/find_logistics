import 'package:dio/dio.dart';
import 'package:find_logistic/src/app/service/network/network.dart';
import 'package:find_logistic/src/app/service/network/network_impl.dart';
import 'package:find_logistic/src/screens/auth/login/login_viewmodel.dart';
import 'package:find_logistic/src/screens/auth/customer/register/signup_viewmodel.dart';
import 'package:find_logistic/src/screens/auth/forgot_password/forgot_password_viewmodel.dart';
import 'package:find_logistic/src/screens/dashboard/dashboard_viewmodel.dart';
import 'package:find_logistic/src/screens/profile/profile_viewmodel.dart';
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

final profileProvider =
    StateNotifierProvider<ProfileViewModel, ProfileState>((ref) {
  return ProfileViewModel(ref.read(networkProvider), ref);
});
