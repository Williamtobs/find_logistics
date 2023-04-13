class DriverOrders {
  DriverOrders({
    required this.id,
    required this.riderId,
    required this.customerId,
    required this.orderId,
    required this.orderReference,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.quantity,
    required this.orderDetails,
    required this.customerDetails,
  });

  final int id;
  final int riderId;
  final int customerId;
  final int orderId;
  final String orderReference;
  final dynamic description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic quantity;
  final OrderDetails? orderDetails;
  final CustomerDetails? customerDetails;

  factory DriverOrders.fromJson(Map<String, dynamic> json) {
    return DriverOrders(
      id: json["id"] ?? 0,
      riderId: json["rider_id"] ?? 0,
      customerId: json["customer_id"] ?? 0,
      orderId: json["order_id"] ?? 0,
      orderReference: json["order_reference"] ?? "",
      description: json["description"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      quantity: json["quantity"],
      orderDetails: json["order_details"] == null
          ? null
          : OrderDetails.fromJson(json["order_details"]),
      customerDetails: json["customer_details"] == null
          ? null
          : CustomerDetails.fromJson(json["customer_details"]),
    );
  }
}

class CustomerDetails {
  CustomerDetails({
    required this.id,
    required this.slug,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.bio,
    required this.phoneNumber,
    required this.image,
    required this.uniqueId,
    required this.userType,
    required this.email,
    required this.plateNumber,
    required this.emailVerifiedAt,
    required this.otp,
    required this.passwordResetToken,
    required this.createdAt,
    required this.updatedAt,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.percentageNegotiation,
    required this.availability,
  });

  final int id;
  final String slug;
  final String firstName;
  final String lastName;
  final String userName;
  final dynamic bio;
  final String phoneNumber;
  final String image;
  final String uniqueId;
  final String userType;
  final String email;
  final String plateNumber;
  final DateTime? emailVerifiedAt;
  final dynamic otp;
  final dynamic passwordResetToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String address;
  final String longitude;
  final String latitude;
  final int percentageNegotiation;
  final String availability;

  factory CustomerDetails.fromJson(Map<String, dynamic> json) {
    return CustomerDetails(
      id: json["id"] ?? 0,
      slug: json["slug"] ?? "",
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      userName: json["user_name"] ?? "",
      bio: json["bio"],
      phoneNumber: json["phone_number"] ?? "",
      image: json["image"] ?? "",
      uniqueId: json["unique_id"] ?? "",
      userType: json["user_type"] ?? "",
      email: json["email"] ?? "",
      plateNumber: json["plate_number"] ?? "",
      emailVerifiedAt: DateTime.tryParse(json["email_verified_at"] ?? ""),
      otp: json["otp"],
      passwordResetToken: json["password_reset_token"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      address: json["address"] ?? "",
      longitude: json["longitude"] ?? "",
      latitude: json["latitude"] ?? "",
      percentageNegotiation: json["percentage_negotiation"] ?? 0,
      availability: json["availability"] ?? "",
    );
  }
}

class OrderDetails {
  OrderDetails({
    required this.id,
    required this.riderId,
    required this.customerId,
    required this.orderFromAddress,
    required this.orderToAddress,
    required this.orderFromLat,
    required this.orderFromLong,
    required this.orderToLat,
    required this.orderToLong,
    required this.amount,
    required this.distance,
    required this.orderNote,
    required this.rating,
    required this.status,
    required this.sendersName,
    required this.receiversPhone,
    required this.receiversAddress,
    required this.houseNumber,
    required this.area,
    required this.closestLandmark,
    required this.deliveryTime,
    required this.orderReference,
    required this.createdAt,
    required this.updatedAt,
    required this.estimatedAmount,
    required this.paymentMethodId,
    required this.deliveryTypeId,
    required this.receiversName,
    required this.pickupDetails,
    required this.startedAt,
    required this.endedAt,
  });

  final int id;
  final dynamic riderId;
  final int customerId;
  final String orderFromAddress;
  final String orderToAddress;
  final String orderFromLat;
  final String orderFromLong;
  final String orderToLat;
  final String orderToLong;
  final dynamic amount;
  final String distance;
  final dynamic orderNote;
  final dynamic rating;
  final String status;
  final String sendersName;
  final String receiversPhone;
  final dynamic receiversAddress;
  final dynamic houseNumber;
  final dynamic area;
  final dynamic closestLandmark;
  final dynamic deliveryTime;
  final String orderReference;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String estimatedAmount;
  final int paymentMethodId;
  final int deliveryTypeId;
  final dynamic receiversName;
  final dynamic pickupDetails;
  final dynamic startedAt;
  final dynamic endedAt;

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      id: json["id"] ?? 0,
      riderId: json["rider_id"],
      customerId: json["customer_id"] ?? 0,
      orderFromAddress: json["order_from_address"] ?? "",
      orderToAddress: json["order_to_address"] ?? "",
      orderFromLat: json["order_from_lat"] ?? "",
      orderFromLong: json["order_from_long"] ?? "",
      orderToLat: json["order_to_lat"] ?? "",
      orderToLong: json["order_to_long"] ?? "",
      amount: json["amount"],
      distance: json["distance"] ?? "",
      orderNote: json["order_note"],
      rating: json["rating"],
      status: json["status"] ?? "",
      sendersName: json["senders_name"] ?? "",
      receiversPhone: json["receivers_phone"] ?? "",
      receiversAddress: json["receivers_address"],
      houseNumber: json["house_number"],
      area: json["area"],
      closestLandmark: json["closest_landmark"],
      deliveryTime: json["delivery_time"],
      orderReference: json["order_reference"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      estimatedAmount: json["estimated_amount"] ?? "",
      paymentMethodId: json["payment_method_id"] ?? 0,
      deliveryTypeId: json["delivery_type_id"] ?? 0,
      receiversName: json["receivers_name"],
      pickupDetails: json["pickup_details"],
      startedAt: json["started_at"],
      endedAt: json["ended_at"],
    );
  }
}
