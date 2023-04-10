class WalletTransHistory {
  WalletTransHistory({
    required this.id,
    required this.walletId,
    required this.status,
    required this.channel,
    required this.type,
    required this.amount,
    required this.oldBalance,
    required this.newBalance,
    required this.description,
    required this.reference,
    required this.gatewayReference,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int walletId;
  final String status;
  final String channel;
  final String type;
  final int amount;
  final int oldBalance;
  final int newBalance;
  final String description;
  final String reference;
  final dynamic gatewayReference;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory WalletTransHistory.fromJson(Map<String, dynamic> json) {
    return WalletTransHistory(
      id: json["id"] ?? 0,
      walletId: json["wallet_id"] ?? 0,
      status: json["status"] ?? "",
      channel: json["channel"] ?? "",
      type: json["type"] ?? "",
      amount: json["amount"] ?? 0,
      oldBalance: json["old_balance"] ?? 0,
      newBalance: json["new_balance"] ?? 0,
      description: json["description"] ?? "",
      reference: json["reference"] ?? "",
      gatewayReference: json["gateway_reference"],
      createdAt: DateTime.tryParse(json["created_at"]),
      updatedAt: DateTime.tryParse(json["updated_at"]),
    );
  }
}
