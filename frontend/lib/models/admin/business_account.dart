// lib/models/admin/business_account.dart

class BusinessAccount {
  final String id;
  final String name;
  final String industryId;
  final String? ownerId;
  final Map<String, dynamic>? featuresEnabled;

  BusinessAccount({
    required this.id,
    required this.name,
    required this.industryId,
    this.ownerId,
    this.featuresEnabled,
  });

  factory BusinessAccount.fromJson(Map<String, dynamic> json) {
    return BusinessAccount(
      id: json['id'],
      name: json['name'],
      industryId: json['industry_id'],
      ownerId: json['owner_id'],
      featuresEnabled: json['features_enabled'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'industry_id': industryId,
      'owner_id': ownerId,
      'features_enabled': featuresEnabled,
    };
  }
}
