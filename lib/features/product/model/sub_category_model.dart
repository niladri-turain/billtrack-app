class SubCategoryModel {
  final String id;
  final String value;

  SubCategoryModel({
    required this.id,
    required this.value,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'] ?? '',
      value: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
    };
  }
}

class SubCategoryResponse {
  final bool status;
  final List<SubCategoryModel> data;

  SubCategoryResponse({
    required this.status,
    required this.data,
  });

  factory SubCategoryResponse.fromJson(Map<String, dynamic> json) {
    return SubCategoryResponse(
      status: json['status'] ?? false,
      data: (json['data'] as List?)
              ?.map((e) => SubCategoryModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
