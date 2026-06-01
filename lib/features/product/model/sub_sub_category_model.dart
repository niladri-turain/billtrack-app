class SubSubCategoryModel {
  final String id;
  final String name;

  SubSubCategoryModel({
    required this.id,
    required this.name,
  });

  factory SubSubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubSubCategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class SubSubCategoryResponse {
  final bool status;
  final List<SubSubCategoryModel> data;

  SubSubCategoryResponse({
    required this.status,
    required this.data,
  });

  factory SubSubCategoryResponse.fromJson(Map<String, dynamic> json) {
    return SubSubCategoryResponse(
      status: json['status'] ?? false,
      data: (json['data'] as List?)
              ?.map((e) => SubSubCategoryModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
