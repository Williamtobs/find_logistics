class OrderDetails {
  OrderDetails({
    required this.customerId,
    required this.paymentMethodId,
    required this.deliveryTypeId,
    required this.orderFromAddress,
    required this.orderToAddress,
    required this.orderFromLat,
    required this.orderFromLong,
    required this.orderToLat,
    required this.orderToLong,
    required this.estimatedAmount,
    required this.distance,
    required this.orderNote,
    required this.status,
    required this.sendersName,
    required this.receiversName,
    required this.receiversPhone,
    required this.receiversAddress,
    required this.houseNumber,
    required this.area,
    required this.closestLandmark,
    required this.orderReference,
    required this.pickupDetails,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  final String customerId;
  final String paymentMethodId;
  final String deliveryTypeId;
  final String orderFromAddress;
  final String orderToAddress;
  final String orderFromLat;
  final String orderFromLong;
  final String orderToLat;
  final String orderToLong;
  final num estimatedAmount;
  final String distance;
  final dynamic orderNote;
  final String status;
  final String sendersName;
  final String receiversName;
  final String receiversPhone;
  final dynamic receiversAddress;
  final dynamic houseNumber;
  final dynamic area;
  final dynamic closestLandmark;
  final String orderReference;
  final String pickupDetails;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int id;

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      customerId: json["customer_id"] ?? '0',
      paymentMethodId: json["payment_method_id"] ?? '0',
      deliveryTypeId: json["delivery_type_id"] ?? '0',
      orderFromAddress: json["order_from_address"] ?? "",
      orderToAddress: json["order_to_address"] ?? "",
      orderFromLat: json["order_from_lat"] ?? '0.0',
      orderFromLong: json["order_from_long"] ?? '0.0',
      orderToLat: json["order_to_lat"] ?? '0.0',
      orderToLong: json["order_to_long"] ?? '0.0',
      estimatedAmount: json["estimated_amount"] ?? 0,
      distance: json["distance"] ?? '0',
      orderNote: json["order_note"],
      status: json["status"] ?? "",
      sendersName: json["senders_name"] ?? "",
      receiversName: json["receivers_name"] ?? "",
      receiversPhone: json["receivers_phone"] ?? "",
      receiversAddress: json["receivers_address"],
      houseNumber: json["house_number"],
      area: json["area"],
      closestLandmark: json["closest_landmark"],
      orderReference: json["order_reference"] ?? "",
      pickupDetails: json["pickup_details"] ?? "",
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      id: json["id"] ?? 0,
    );
  }
}
