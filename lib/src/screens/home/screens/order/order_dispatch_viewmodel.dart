import 'package:find_logistic/src/app/model/type_model.dart';
import 'package:find_logistic/src/app/service/network/network.dart';
import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderViewModel extends StateNotifier<OrderState> {
  OrderViewModel(this.network)
      : super(OrderState(paymentsMethod: [], deliveryMethod: []));

  final Network network;

  getPaymentMethods() async {
    final response = await network.get(path: 'payment-method');
    var body = response.data;
    if (response.statusCode == 200) {
      if (body['status'] == true) {
        state = state.copyWith(
            paymentsMethod: List<TypeModel>.from(body['data']['payment_method']
                .map((x) => TypeModel.fromJson(x))));
      }
    }
  }

  getDeliveryMethods() async {
    final response = await network.get(path: 'delivery-type');
    var body = response.data;
    if (response.statusCode == 200) {
      if (body['status'] == true) {
        state = state.copyWith(
            deliveryMethod: List<TypeModel>.from(body['data']['delivery_type']
                .map((x) => TypeModel.fromJson(x))));
      }
    }
  }

  Future<bool> placeOrder(
      {required var form, required BuildContext context}) async {
    final response =
        await network.postWithToken(path: 'initiate/order', formData: form);
    var body = response.data;
    print(body);
    if (response.statusCode == 200) {
      if (body['status'] == true) {
        return true;
      } else {
        BottomSnack.errorSnackBar(message: body['message'], context: context);
        return false;
      }
    } else {
      BottomSnack.errorSnackBar(
          message: 'Something went wrong', context: context);
      return false;
    }
  }
}

class OrderState {
  final List<TypeModel> paymentsMethod;
  final List<TypeModel> deliveryMethod;

  OrderState({required this.paymentsMethod, required this.deliveryMethod});

  OrderState copyWith(
      {List<TypeModel>? paymentsMethod, List<TypeModel>? deliveryMethod}) {
    return OrderState(
      paymentsMethod: paymentsMethod ?? this.paymentsMethod,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
    );
  }
}
