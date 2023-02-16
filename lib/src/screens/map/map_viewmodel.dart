import 'package:find_logistic/src/app/model/negotiate_order_model.dart';
import 'package:find_logistic/src/app/service/network/network.dart';
import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapViewModel extends StateNotifier<MapState> {
  MapViewModel(this._network)
      : super(MapState(isLoading: false, negotiateOrders: []));

  final Network _network;

  acceptRider({required BuildContext context, required var formData}) async {
    final response =
        await _network.postWithToken(path: 'order/request', formData: formData);
    var body = response.data;
    if (response.statusCode == 200) {
      if (body['status'] == true) {
        BottomSnack.successSnackBar(message: body['message'], context: context);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        BottomSnack.errorSnackBar(message: body['message'], context: context);
        return false;
      }
    } else {
      state = state.copyWith(isLoading: false);
      BottomSnack.errorSnackBar(
          message: 'Something went wrong', context: context);
    }
  }

  negotiateOrder({required BuildContext context, required var formData}) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await _network.postWithToken(
          path: 'negotiate/order', formData: formData);
      var body = response.data;
      if (response.statusCode == 200) {
        if (body['status'] == true) {
          state = state.copyWith(
              isLoading: false,
              negotiateOrders: List<NegotiateOrderModel>.from(body['data']
                      ['drivers']
                  .map((x) => NegotiateOrderModel.fromJson(x))));
          return true;
        } else {
          state = state.copyWith(isLoading: false);
          BottomSnack.errorSnackBar(message: body['message'], context: context);
          return false;
        }
      } else {
        state = state.copyWith(isLoading: false);
        BottomSnack.errorSnackBar(
            message: 'Something went wrong', context: context);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      BottomSnack.errorSnackBar(
          message: 'Request could not be completed', context: context);
    }
  }

  riderStatus(String ref) async {
    state = state.copyWith(isLoading: true);
    try {
      final response =
          await _network.postWithToken(path: 'order/status', formData: {
        'order_reference': ref,
      });
      var body = response.data;
      if (response.statusCode == 200) {
        if (body['status'] == true) {
          state = state.copyWith(
              isLoading: false, riderStatus: body['data']['status']);
        } else {
          state = state.copyWith(isLoading: false);
        }
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}

class MapState {
  final bool isLoading;
  final List<NegotiateOrderModel> negotiateOrders;
  final bool riderStatus;

  MapState(
      {required this.isLoading,
      required this.negotiateOrders,
      this.riderStatus = false});

  MapState copyWith(
      {bool? isLoading,
      List<NegotiateOrderModel>? negotiateOrders,
      bool? riderStatus}) {
    return MapState(
      isLoading: isLoading ?? this.isLoading,
      negotiateOrders: negotiateOrders ?? this.negotiateOrders,
      riderStatus: riderStatus ?? this.riderStatus,
    );
  }
}
