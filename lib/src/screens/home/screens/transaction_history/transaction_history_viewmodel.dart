import 'package:find_logistic/src/app/model/transaction_history.dart';
import 'package:find_logistic/src/app/service/network/network.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionHistoryViewModel
    extends StateNotifier<TransactionHistoryState> {
  TransactionHistoryViewModel(this._network)
      : super(TransactionHistoryState.initial());

  final Network _network;

  fetchWalletTransaction() async {
    state = state.copyWith(isLoading: true);
    final response = await _network.get(path: 'wallet/history');
    final data = response.data;
    if (response.statusCode == 200) {
      if (data['status'] == true) {
        state = state.copyWith(
          isLoading: false,
          transactions: List<WalletTransHistory>.from(data['data']
                  ['wallet_transaction']
              .map((x) => WalletTransHistory.fromJson(x))),
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } else {
      state = state.copyWith(isLoading: false);
    }
  }
}

class TransactionHistoryState {
  final bool isLoading;
  final List<WalletTransHistory> transactions;

  TransactionHistoryState({
    required this.isLoading,
    required this.transactions,
  });

  factory TransactionHistoryState.initial() {
    return TransactionHistoryState(
      isLoading: false,
      transactions: [],
    );
  }

  TransactionHistoryState copyWith({
    bool? isLoading,
    List<WalletTransHistory>? transactions,
  }) {
    return TransactionHistoryState(
      isLoading: isLoading ?? this.isLoading,
      transactions: transactions ?? this.transactions,
    );
  }
}
