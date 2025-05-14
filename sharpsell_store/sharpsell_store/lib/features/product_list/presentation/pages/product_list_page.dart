import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/product_card.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../../home/domain/entities/category.dart';
import '../../../home/presentation/bloc/product/product_bloc.dart';
import '../../../home/presentation/bloc/product/product_event.dart';
import '../../../home/presentation/bloc/product/product_state.dart';
import '../../../product_details/presentation/pages/product_details_page.dart';

class ProductListPage extends StatefulWidget {
  final Category category;

  const ProductListPage({
    super.key,
    required this.category,
  });

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    context
        .read<ProductBloc>()
        .add(GetProductsByCategoryEvent(widget.category.id));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onSubmitted: (value) {
                // TODO: Implement search functionality
              },
            ),
          ),

          // Products Grid
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const LoadingWidget();
                } else if (state is ProductLoaded) {
                  if (state.products.isEmpty) {
                    return const Center(
                      child: Text('No products found'),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return ProductCard(
                        product: product,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsPage(
                                productId: product.id,
                              ),
                            ),
                          );
                        },
                        onAddToCart: () {
                          const uuid = Uuid();
                          final cartItem = CartItem(
                            id: uuid.v4(),
                            productId: product.id,
                            name: product.name,
                            price: product.price,
                            imageUrl: product.imageUrl,
                            quantity: 1,
                          );
                          context
                              .read<CartBloc>()
                              .add(AddToCartEvent(cartItem));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.name} added to cart'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (state is ProductError) {
                  return ErrorMessageWidget(
                    message: state.message,
                    onRetry: _loadProducts,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
