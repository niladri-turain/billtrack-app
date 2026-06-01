import 'package:get_it/get_it.dart';
import '../../service/api_service.dart';
import '../constant/api_end_points.dart';
import '../../features/product/provider/business_category_provider.dart';
import '../../features/product/provider/sub_category_provider.dart';
import '../../features/product/provider/sub_sub_category_provider.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Services
  getIt.registerLazySingleton<ApiService>(() => ApiService(baseUrl: ApiEndPoints.baseUrl));

  // Providers
  getIt.registerFactory<BusinessCategoryProvider>(() => BusinessCategoryProvider(apiService: getIt<ApiService>()));
  getIt.registerFactory<SubCategoryProvider>(() => SubCategoryProvider(apiService: getIt<ApiService>()));
  getIt.registerFactory<SubSubCategoryProvider>(() => SubSubCategoryProvider(apiService: getIt<ApiService>()));
}
