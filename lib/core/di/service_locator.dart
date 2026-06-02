import 'package:get_it/get_it.dart';
import 'package:billtrack/service/api_service.dart';
import 'package:billtrack/core/constant/api_end_points.dart';
import 'package:billtrack/features/product/provider/business_category_provider.dart';
import 'package:billtrack/features/product/provider/sub_category_provider.dart';
import 'package:billtrack/features/product/provider/sub_sub_category_provider.dart';
import 'package:billtrack/features/product/provider/hsn_provider.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Services
  getIt.registerLazySingleton<ApiService>(() => ApiService(baseUrl: ApiEndPoints.baseUrl));

  // Providers
  getIt.registerFactory<BusinessCategoryProvider>(() => BusinessCategoryProvider(apiService: getIt<ApiService>()));
  getIt.registerFactory<SubCategoryProvider>(() => SubCategoryProvider(apiService: getIt<ApiService>()));
  getIt.registerFactory<SubSubCategoryProvider>(() => SubSubCategoryProvider(apiService: getIt<ApiService>()));
  getIt.registerFactory<HSNProvider>(() => HSNProvider(apiService: getIt<ApiService>()));
}
