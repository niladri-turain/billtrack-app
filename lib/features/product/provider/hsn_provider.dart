import 'package:flutter/material.dart';
import 'package:billtrack/service/api_service.dart';
import 'package:billtrack/features/product/model/hsn_model.dart';
import 'package:billtrack/core/constant/api_end_points.dart';
import 'package:billtrack/core/constant/app_strings.dart';

class HSNProvider extends ChangeNotifier {
  final ApiService apiService;

  HSNProvider({required this.apiService});

  List<HSNModel> _hsnList = [];
  List<HSNModel> get hsnList => _hsnList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchHSNCodes() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await apiService.get(
        ApiEndPoints.hsn,
        token: AppStrings.bearerToken,
      );
      debugPrint('HSN API Response: $response');
      
      if (response is List) {
        _hsnList = response.map((e) => HSNModel.fromJson(e)).toList();
      } else if (response is Map<String, dynamic>) {
        final hsnResponse = HSNResponse.fromJson(response);
        _hsnList = hsnResponse.data;
      }
      debugPrint('Parsed HSN List: ${_hsnList.length} items');
    } catch (e) {
      debugPrint('Error fetching HSN: $e');
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


}
