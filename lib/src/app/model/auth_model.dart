class AuthModel {
  AuthModel({
    this.slug,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.uniqueId,
    this.email,
    this.otp,
    this.userType,
    this.updatedAt,
    this.createdAt,
    this.id,
  });
  String? slug;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? uniqueId;
  String? email;
  int? otp;
  String? userType;
  String? updatedAt;
  String? createdAt;
  int? id;

  AuthModel.fromJson(Map<String, dynamic> json) {
    slug = json['slug'] = '';
    firstName = json['first_name'] = '';
    lastName = json['last_name'] = '';
    phoneNumber = json['phone_number'] = '';
    uniqueId = json['unique_id'] = '';
    email = json['email'] = '';
    otp = json['otp'] = 0;
    userType = json['user_type'] = '';
    updatedAt = json['updated_at'] = '';
    createdAt = json['created_at'] = '';
    id = json['id'] = 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['slug'] = slug;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['phone_number'] = phoneNumber;
    _data['unique_id'] = uniqueId;
    _data['email'] = email;
    _data['otp'] = otp;
    _data['user_type'] = userType;
    _data['updated_at'] = updatedAt;
    _data['created_at'] = createdAt;
    _data['id'] = id;
    return _data;
  }
}
