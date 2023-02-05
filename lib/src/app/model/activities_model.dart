class RecentActivitiesModel {
  RecentActivitiesModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  final int id;
  final String name;
  final dynamic description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int userId;

  factory RecentActivitiesModel.fromJson(Map<String, dynamic> json) {
    return RecentActivitiesModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      description: json["description"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      userId: json["user_id"] ?? 0,
    );
  }
}
