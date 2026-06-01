import 'package:flutter/material.dart';
import '../../../service/api_service.dart';
import '../../product/model/business_category_model.dart';
import '../../../core/constant/api_end_points.dart';
import '../../../core/constant/app_strings.dart';

class BusinessCategoryProvider extends ChangeNotifier {
  final ApiService apiService;

  BusinessCategoryProvider({required this.apiService});

  List<BusinessCategoryModel> _categories = [];
  List<BusinessCategoryModel> get categories => _categories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchBusinessCategories() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await apiService.get(
        ApiEndPoints.productCategory,
        token: AppStrings.bearerToken,
      );
      final categoryResponse = BusinessCategoryResponse.fromJson(response);
      _categories = categoryResponse.data;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
