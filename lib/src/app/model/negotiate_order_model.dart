class NegotiateOrderModel {
  NegotiateOrderModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.plateNumber,
    required this.distance,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String address;
  final dynamic plateNumber;
  final double distance;

  factory NegotiateOrderModel.fromJson(Map<String, dynamic> json) {
    return NegotiateOrderModel(
      id: json["id"] ?? 0,
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      address: json["address"] ?? "",
      plateNumber: json["plate_number"],
      distance: json["distance"] ?? 0.0,
    );
  }
}
