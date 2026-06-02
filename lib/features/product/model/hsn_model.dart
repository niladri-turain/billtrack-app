class HSNModel {
  final String id;
  final String hsnCode;
  final String description;
  final String gst;
  final String cgst;
  final String sgst;

  HSNModel({
    required this.id,
    required this.hsnCode,
    required this.description,
    required this.gst,
    required this.cgst,
    required this.sgst,
  });

  factory HSNModel.fromJson(Map<String, dynamic> json) {
    return HSNModel(
      id: json['id']?.toString() ?? '',
      hsnCode: json['hsn_code']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      // Using igst as the total gst rate
      gst: json['igst']?.toString() ?? (json['gst']?.toString() ?? '0'),
      cgst: json['cgst']?.toString() ?? '0',
      sgst: json['sgst']?.toString() ?? '0',
    );
  }
}

class HSNResponse {
  final bool status;
  final String message;
  final List<HSNModel> data;

  HSNResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HSNResponse.fromJson(Map<String, dynamic> json) {
    return HSNResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)?.map((e) => HSNModel.fromJson(e)).toList() ?? [],
    );
  }
}
