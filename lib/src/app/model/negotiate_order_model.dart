class NegotiateOrderModel {
  NegotiateOrderModel({
    required this.id,
    required this.image,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.plateNumber,
    required this.distance,
    required this.driversPrice,
  });

  final int id;
  final dynamic image;
  final String firstName;
  final String lastName;
  final String address;
  final String plateNumber;
  final double distance;
  final String driversPrice;

  factory NegotiateOrderModel.fromJson(Map<String, dynamic> json) {
    return NegotiateOrderModel(
      id: json["id"] ?? 0,
      image: json["image"],
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      address: json["address"] ?? "",
      plateNumber: json["plate_number"] ?? "",
      distance: json["distance"] ?? 0.0,
      driversPrice: json["drivers_price"] ?? "",
    );
  }
}
