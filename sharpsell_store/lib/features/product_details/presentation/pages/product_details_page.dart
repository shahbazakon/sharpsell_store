import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/product_card.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../bloc/product_details_bloc.dart';
import '../bloc/product_details_event.dart';
import '../bloc/product_details_state.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productId;

  const ProductDetailsPage({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    super.initState();
    _loadProductDetails();
  }

  void _loadProductDetails() {
    context.read<ProductDetailsBloc>()
      ..add(GetProductDetailsEvent(widget.productId))
      ..add(GetSimilarProductsEvent(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const LoadingWidget();
          } else if (state is ProductDetailsLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: Image.network(
                      state.product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Product Info
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.product.categoryName,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                const uuid = Uuid();
                                final cartItem = CartItem(
                                  id: uuid.v4(),
                                  productId: state.product.id,
                                  name: state.product.name,
                                  price: state.product.price,
                                  imageUrl: state.product.imageUrl,
                                  quantity: 1,
                                );
                                context
                                    .read<CartBloc>()
                                    .add(AddToCartEvent(cartItem));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${state.product.name} added to cart'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: const Text('Add to Cart'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.product.name,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '₹ ${state.product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.product.description,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Similar Products
                  if (state.similarProducts.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Similar Products',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 280,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: state.similarProducts.length,
                        itemBuilder: (context, index) {
                          final product = state.similarProducts[index];
                          return SizedBox(
                            width: 160,
                            child: ProductCard(
                              product: product,
                              onTap: () {
                                Navigator.pushReplacement(
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
                                    content:
                                        Text('${product.name} added to cart'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            );
          } else if (state is ProductDetailsError) {
            return ErrorMessageWidget(
              message: state.message,
              onRetry: _loadProductDetails,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
