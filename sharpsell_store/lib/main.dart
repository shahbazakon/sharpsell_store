import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/cart/presentation/bloc/cart_event.dart';
import 'features/home/presentation/bloc/category/category_bloc.dart';
import 'features/home/presentation/bloc/category/category_event.dart';
import 'features/home/presentation/bloc/product/product_bloc.dart';
import 'features/home/presentation/bloc/product/product_event.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/product_details/presentation/bloc/product_details_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryBloc>(
          create: (_) => di.sl<CategoryBloc>(),
        ),
        BlocProvider<ProductBloc>(
          create: (_) => di.sl<ProductBloc>(),
        ),
        BlocProvider<ProductDetailsBloc>(
          create: (_) => di.sl<ProductDetailsBloc>(),
        ),
        BlocProvider<CartBloc>(
          create: (_) => di.sl<CartBloc>()..add(GetCartEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Sharpsell Store',
        theme: AppTheme.lightTheme,
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
