import 'package:find_logistic/src/app/model/driver_orders_model.dart';
import 'package:find_logistic/src/app/service/network/network.dart';
import 'package:find_logistic/src/screens/driver_order/driver_map.dart';
import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderRequestViewModel extends StateNotifier<OrderRequestState> {
  OrderRequestViewModel(this._network) : super(OrderRequestState.initial());

  final Network _network;

  acceptRide({required BuildContext context, required String orderRef}) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await _network.postWithToken(
          path: 'order/accept', formData: {'order_reference': orderRef});
      var body = response.data;
      if (response.statusCode == 200) {
        if (body['status'] == true) {
          // ignore: use_build_context_synchronously
          orderDetails(context: context, orderRef: orderRef);
        } else {
          // ignore: use_build_context_synchronously
          BottomSnack.errorSnackBar(message: body['message'], context: context);
          state = state.copyWith(isLoading: false);
        }
      } else {
        // ignore: use_build_context_synchronously
        BottomSnack.errorSnackBar(
            message: 'Something went wrong', context: context);
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      BottomSnack.errorSnackBar(
          message: 'Something went wrong', context: context);
      state = state.copyWith(isLoading: false);
    }
  }

  Future<bool> cancelOrder(
      {required BuildContext context, required String orderRef}) async {
    try {
      final response = await _network.postWithToken(
          path: 'order/end', formData: {'order_reference': orderRef});
      var body = response.data;
      print(body);
      if (response.statusCode == 200) {
        if (body['status'] == true) {
          BottomSnack.successSnackBar(
              message: body['message'], context: context);
          return true;
        } else {
          BottomSnack.errorSnackBar(message: body['message'], context: context);
          return false;
        }
      } else {
        BottomSnack.errorSnackBar(message: body['message'], context: context);
        return false;
      }
    } catch (e) {
      BottomSnack.errorSnackBar(
          message: 'Something went wrong', context: context);
    }
    return false;
  }

  orderDetails(
      {required BuildContext context, required String orderRef}) async {
    state = state.copyWith(isLoading: true);
    try {
      final response =
          await _network.get(path: 'order/check/details/$orderRef');
      var body = response.data;
      if (response.statusCode == 200) {
        if (body['status'] == true) {
          state =
              state.copyWith(driverOrders: DriverOrders.fromJson(body['data']));
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DriverMap(
                        driverOrders: state.driverOrders,
                      )));
          state = state.copyWith(isLoading: false);
        } else {
          // ignore: use_build_context_synchronously
          BottomSnack.errorSnackBar(message: body['message'], context: context);
          state = state.copyWith(isLoading: false);
        }
      } else {
        // ignore: use_build_context_synchronously
        BottomSnack.errorSnackBar(
            message: 'Something went wrong', context: context);
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      BottomSnack.errorSnackBar(
          message: 'Something went wrong', context: context);
      state = state.copyWith(isLoading: false);
    }
  }
}

class OrderRequestState {
  final bool isLoading;
  final DriverOrders driverOrders;

  OrderRequestState({required this.isLoading, required this.driverOrders});

  factory OrderRequestState.initial() {
    return OrderRequestState(
        isLoading: false, driverOrders: DriverOrders.fromJson({}));
  }

  OrderRequestState copyWith({bool? isLoading, DriverOrders? driverOrders}) {
    return OrderRequestState(
      isLoading: isLoading ?? this.isLoading,
      driverOrders: driverOrders ?? this.driverOrders,
    );
  }
}
