import 'package:find_logistic/src/screens/wallet/wallet_screen_viewmodel.dart';
import 'package:riverpod/riverpod.dart';

final walletProvider =
    StateNotifierProvider<WalletViewModel, WalletState>((ref) {
  return WalletViewModel();
});
