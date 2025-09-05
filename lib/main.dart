import 'package:flutter/material.dart';
import 'package:flutter_distributor_retailer_app/core/routes/app_router.dart';
import 'package:flutter_distributor_retailer_app/core/theme/app_theme.dart';
import 'package:flutter_distributor_retailer_app/viewmodels/distributor_from_viewmodel.dart';
import 'package:flutter_distributor_retailer_app/viewmodels/distributor_list_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DistributorListViewmodel()),
        ChangeNotifierProvider(create: (_) => DistributorFormViewmodel()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Distributor Retailer App',
        theme: AppTheme.appTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
