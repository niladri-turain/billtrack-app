class BusinessCategoryModel {
  final String id;
  final String name;
  final String image;
  final int status;
  final String statusLabel;
  final String createdAt;

  BusinessCategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.statusLabel,
    required this.createdAt,
  });

  factory BusinessCategoryModel.fromJson(Map<String, dynamic> json) {
    return BusinessCategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      status: json['status'] ?? 0,
      statusLabel: json['status_label'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'status': status,
      'status_label': statusLabel,
      'created_at': createdAt,
    };
  }
}

class BusinessCategoryResponse {
  final List<BusinessCategoryModel> data;

  BusinessCategoryResponse({required this.data});

  factory BusinessCategoryResponse.fromJson(Map<String, dynamic> json) {
    return BusinessCategoryResponse(
      data: (json['data'] as List?)
              ?.map((e) => BusinessCategoryModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
