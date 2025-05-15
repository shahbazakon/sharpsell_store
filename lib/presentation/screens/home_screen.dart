import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/category_provider.dart';
import '../providers/product_list_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/category_item.dart';
import '../widgets/product_item.dart';
import 'cart_screen.dart';
import 'product_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Add scroll listener for infinite scrolling
    _scrollController.addListener(_onScroll);

    // Fetch data after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialData();
    });
  }

  void _fetchInitialData() {
    Provider.of<CategoryProvider>(context, listen: false).getCategories();
    Provider.of<ProductListProvider>(context, listen: false).getProducts();
    Provider.of<CartProvider>(context, listen: false).getCartItems();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final productProvider =
          Provider.of<ProductListProvider>(context, listen: false);
      if (!productProvider.isLoading &&
          !productProvider.isLoadingMore &&
          productProvider.hasMoreData) {
        productProvider.getProducts();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sharpsell Store'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    return cartProvider.itemCount > 0
                        ? Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '${cartProvider.itemCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<ProductListProvider>(
        builder: (context, productListProvider, child) {
          return RefreshIndicator(
            onRefresh: () async {
              final categoryProvider =
                  Provider.of<CategoryProvider>(context, listen: false);
              final productProvider =
                  Provider.of<ProductListProvider>(context, listen: false);

              await categoryProvider.getCategories(refresh: true);
              await productProvider.getProducts(refresh: true);
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search bar
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  productListProvider.resetSearch();
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          productListProvider.searchProducts(value);
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Categories section
                    if (productListProvider.searchQuery.isEmpty) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Categories >',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Show all categories in a dialog
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: Consumer<CategoryProvider>(
                                    builder: (context, categoryProvider, _) {
                                      if (categoryProvider.isLoading) {
                                        return const SizedBox(
                                          height: 300,
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        );
                                      }

                                      if (categoryProvider.error.isNotEmpty) {
                                        return SizedBox(
                                          height: 300,
                                          child: Center(
                                              child: Text(
                                                  'Error: ${categoryProvider.error}')),
                                        );
                                      }

                                      return Container(
                                        padding: const EdgeInsets.all(16.0),
                                        constraints: const BoxConstraints(
                                            maxWidth: 500, maxHeight: 500),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              'All Categories',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Expanded(
                                              child: GridView.builder(
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 1.5,
                                                  crossAxisSpacing: 10,
                                                  mainAxisSpacing: 10,
                                                ),
                                                itemCount: categoryProvider
                                                    .categories.length,
                                                itemBuilder: (context, index) {
                                                  final category =
                                                      categoryProvider
                                                          .categories[index];
                                                  return InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductListScreen(
                                                            categoryId:
                                                                category.id,
                                                            categoryName:
                                                                category.name,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Card(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                                category.image),
                                                            fit: BoxFit.cover,
                                                            colorFilter:
                                                                ColorFilter
                                                                    .mode(
                                                              Colors.black
                                                                  .withOpacity(
                                                                      0.3),
                                                              BlendMode.darken,
                                                            ),
                                                          ),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          category.name,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                            child: const Text('View All'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Categories list
                      SizedBox(
                        height: 120,
                        child: Consumer<CategoryProvider>(
                          builder: (context, categoryProvider, child) {
                            if (categoryProvider.isLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            if (categoryProvider.error.isNotEmpty) {
                              return Center(
                                  child:
                                      Text('Error: ${categoryProvider.error}'));
                            }

                            if (categoryProvider.categories.isEmpty) {
                              return const Center(
                                  child: Text('No categories found'));
                            }

                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categoryProvider.categories.length,
                              itemBuilder: (context, index) {
                                final category =
                                    categoryProvider.categories[index];
                                return CategoryItem(
                                  category: category,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductListScreen(
                                          categoryId: category.id,
                                          categoryName: category.name,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Products section
                    Text(
                      productListProvider.searchQuery.isEmpty
                          ? 'Products'
                          : 'Search Results for "${productListProvider.searchQuery}"',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Products grid
                    if (productListProvider.isLoading) ...[
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ] else if (productListProvider.error.isNotEmpty) ...[
                      Center(
                        child: Text('Error: ${productListProvider.error}'),
                      ),
                    ] else if (productListProvider.products.isEmpty) ...[
                      const Center(
                        child: Text('No products found'),
                      ),
                    ] else ...[
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: productListProvider.products.length,
                        itemBuilder: (context, index) {
                          final product = productListProvider.products[index];
                          return ProductItem(
                            product: product,
                            onAddToCart: () {
                              Provider.of<CartProvider>(context, listen: false)
                                  .addToCart(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('${product.title} added to cart'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                          );
                        },
                      ),

                      // Loading indicator at the bottom for pagination
                      if (productListProvider.isLoadingMore) ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
