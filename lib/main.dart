import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:billtrack/features/splashScreen/splash_screen.dart';
import 'package:billtrack/core/di/service_locator.dart';
import 'package:billtrack/features/product/provider/business_category_provider.dart';
import 'package:billtrack/features/product/provider/sub_category_provider.dart';
import 'package:billtrack/features/product/provider/sub_sub_category_provider.dart';
import 'package:billtrack/features/product/provider/hsn_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<BusinessCategoryProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<SubCategoryProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<SubSubCategoryProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<HSNProvider>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Billtrack',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
