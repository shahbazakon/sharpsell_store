import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

import 'core/theme/app_theme.dart';
import 'core/utils/constants.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/cart/presentation/bloc/cart_event.dart';
import 'features/cart/presentation/pages/cart_page.dart';
import 'features/home/presentation/bloc/category/category_bloc.dart';
import 'features/home/presentation/bloc/category/category_event.dart';
import 'features/home/presentation/bloc/product/product_bloc.dart';
import 'features/home/presentation/bloc/product/product_event.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/product_details/presentation/bloc/product_details_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize dependency injection
    await di.init();

    // Log successful initialization
    developer.log('Dependencies initialized successfully');

    runApp(const MyApp());
  } catch (e) {
    // Log any initialization errors
    developer.log('Error initializing app: $e');
    runApp(const ErrorApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryBloc>(
          create: (_) => di.sl<CategoryBloc>()..add(GetCategoriesEvent()),
        ),
        BlocProvider<ProductBloc>(
          create: (_) => di.sl<ProductBloc>()..add(GetProductsEvent()),
        ),
        BlocProvider<ProductDetailsBloc>(
          create: (_) => di.sl<ProductDetailsBloc>(),
        ),
        BlocProvider<CartBloc>(
          create: (_) => di.sl<CartBloc>()..add(GetCartEvent()),
        ),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/cart': (context) => const CartPage(),
        },
      ),
    );
  }
}

// Fallback error app in case initialization fails
class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Error',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: Text(
            'Failed to initialize the app. Please restart.',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
