class AppUser {
  AppUser({
    this.id,
    this.slug,
    this.firstName,
    this.lastName,
    this.userName,
    this.bio,
    this.phoneNumber,
    this.image,
    this.uniqueId,
    this.userType,
    this.email,
    this.plateNumber,
    this.emailVerifiedAt,
    this.otp,
    this.passwordResetToken,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.longitude,
    this.latitude,
    this.wallet,
  });

  final int? id;
  final String? slug;
  final String? firstName;
  final String? lastName;
  final dynamic userName;
  final dynamic bio;
  final String? phoneNumber;
  final dynamic image;
  final String? uniqueId;
  final String? userType;
  final String? email;
  final dynamic plateNumber;
  final DateTime? emailVerifiedAt;
  final dynamic otp;
  final dynamic passwordResetToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic address;
  final dynamic longitude;
  final dynamic latitude;
  final Wallet? wallet;

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json["id"] ?? 0,
      slug: json["slug"] ?? "",
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      userName: json["user_name"],
      bio: json["bio"],
      phoneNumber: json["phone_number"] ?? "",
      image: json["image"],
      uniqueId: json["unique_id"] ?? "",
      userType: json["user_type"] ?? "",
      email: json["email"] ?? "",
      plateNumber: json["plate_number"],
      emailVerifiedAt: json["email_verified_at"] == null
          ? null
          : DateTime.parse(json["email_verified_at"]),
      otp: json["otp"],
      passwordResetToken: json["password_reset_token"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      address: json["address"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      wallet: json["wallet"] == null ? null : Wallet.fromJson(json["wallet"]),
    );
  }
}

class Wallet {
  Wallet({
    this.id,
    this.userId,
    this.availableBalance,
    this.oldBalance,
    this.ledgerBalance,
    this.currency,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? userId;
  final int? availableBalance;
  final int? oldBalance;
  final int? ledgerBalance;
  final String? currency;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json["id"] ?? 0,
      userId: json["user_id"] ?? 0,
      availableBalance: json["available_balance"] ?? 0,
      oldBalance: json["old_balance"] ?? 0,
      ledgerBalance: json["ledger_balance"] ?? 0,
      currency: json["currency"] ?? "",
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
    );
  }
}
