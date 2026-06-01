class BusinessCategoryModel {
  final String id;
  final String name;
  final String? description;
  final String? image;
  final int status;
  final String statusLabel;
  final dynamic commission;
  final String createdAt;

  BusinessCategoryModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.status,
    required this.statusLabel,
    this.commission,
    required this.createdAt,
  });

  factory BusinessCategoryModel.fromJson(Map<String, dynamic> json) {
    return BusinessCategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      image: json['image'],
      status: json['status'] ?? 0,
      statusLabel: json['status_label'] ?? '',
      commission: json['commission'],
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'status': status,
      'status_label': statusLabel,
      'commission': commission,
      'created_at': createdAt,
    };
  }
}

class BusinessCategoryResponse {
  final bool status;
  final String message;
  final List<BusinessCategoryModel> data;

  BusinessCategoryResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BusinessCategoryResponse.fromJson(Map<String, dynamic> json) {
    return BusinessCategoryResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)
              ?.map((e) => BusinessCategoryModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
