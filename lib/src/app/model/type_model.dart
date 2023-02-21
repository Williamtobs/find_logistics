class TypeModel {
  TypeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final dynamic description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      description: json["description"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
    );
  }
}
