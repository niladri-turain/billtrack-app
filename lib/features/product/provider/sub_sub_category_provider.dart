import 'package:flutter/material.dart';
import '../../../service/api_service.dart';
import '../model/sub_sub_category_model.dart';
import '../../../core/constant/api_end_points.dart';
import '../../../core/constant/app_strings.dart';

class SubSubCategoryProvider extends ChangeNotifier {
  final ApiService apiService;

  SubSubCategoryProvider({required this.apiService});

  List<SubSubCategoryModel> _subSubCategories = [];
  List<SubSubCategoryModel> get subSubCategories => _subSubCategories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchSubSubCategories(String categoryId, String subCategoryId) async {
    _isLoading = true;
    _errorMessage = null;
    _subSubCategories = [];
    notifyListeners();

    try {
      final response = await apiService.get(
        "${ApiEndPoints.productSubSubCategory}/$categoryId/$subCategoryId",
        token: AppStrings.bearerToken,
      );
      final subSubCategoryResponse = SubSubCategoryResponse.fromJson(response);
      _subSubCategories = subSubCategoryResponse.data;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSubSubCategories() {
    _subSubCategories = [];
    notifyListeners();
  }
}
