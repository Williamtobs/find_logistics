
class AppUser {
  AppUser({
    this.id,
    this.slug,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.uniqueId,
    this.userType,
    this.email,
    this.emailVerifiedAt,
    this.otp,
    this.passwordResetToken,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? slug;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? uniqueId;
  String? userType;
  String? email;
  dynamic emailVerifiedAt;
  int? otp;
  dynamic passwordResetToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json["id"] ?? 0,
      slug: json["slug"] ?? "",
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      phoneNumber: json["phone_number"] ?? "",
      uniqueId: json["unique_id"] ?? "",
      userType: json["user_type"] ?? "",
      email: json["email"] ?? "",
      emailVerifiedAt: json["email_verified_at"],
      otp: json["otp"] ?? 0,
      passwordResetToken: json["password_reset_token"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "unique_id": uniqueId,
        "user_type": userType,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "otp": otp,
        "password_reset_token": passwordResetToken,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  @override
  String toString() {
    return '$id, $slug, $firstName, $lastName, $phoneNumber, $uniqueId, $userType, $email, $emailVerifiedAt, $otp, $passwordResetToken, $createdAt, $updatedAt';
  }
}

