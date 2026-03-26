import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/products.dart';
import '../../providers/cart.dart';
import '../../models/product.dart';
import '../../widgets/products/product_item.dart';
import '../../widgets/products/size_selector.dart';
import '../../widgets/products/color_selector.dart';
import '../../widgets/products/review_item.dart';
import '../../widgets/products/product_details_actions.dart';
import '../../core/utils/responsive.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';

  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String _selectedSize = 'M';
  Color _selectedColor = Colors.black;
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    final Object? productIdObj = ModalRoute.of(context)?.settings.arguments;
    if (productIdObj == null) {
      return const Scaffold(body: Center(child: Text('Error')));
    }

    final String productId = productIdObj as String;
    final productsProvider = Provider.of<Products>(context);
    final Product loadedProduct = productsProvider.findById(productId);

    final similarProducts = productsProvider
        .findByCategory(loadedProduct.category)
        .where((p) => p.id != loadedProduct.id)
        .toList();

    final cart = Provider.of<Cart>(context, listen: false);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: Responsive.blockSizeVertical * 45,
            pinned: true,
            backgroundColor: isDark ? Colors.black : Colors.white,
            foregroundColor: isDark ? Colors.white : Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  PageView.builder(
                    onPageChanged: (index) =>
                        setState(() => _currentImageIndex = index),
                    itemCount: 3,
                    itemBuilder: (ctx, i) => Hero(
                      tag: loadedProduct.id,
                      child: Image.network(
                        loadedProduct.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentImageIndex == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.all(Responsive.blockSizeHorizontal * 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.whatshot_rounded, color: Colors.orange, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                'TRENDING',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Responsive.setSp(10),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.amber, size: 22),
                            const SizedBox(width: 4),
                            Text(
                              '${loadedProduct.rating}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Responsive.setSp(16),
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.setHeight(15)),
                    Text(
                      loadedProduct.title,
                      style: TextStyle(
                        fontSize: Responsive.setSp(28),
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: Responsive.setHeight(8)),
                    Text(
                      'In Stock',
                      style: TextStyle(
                        color: Colors.green.shade400,
                        fontWeight: FontWeight.bold,
                        fontSize: Responsive.setSp(14),
                      ),
                    ),
                    SizedBox(height: Responsive.setHeight(12)),
                    Text(
                      '\$${loadedProduct.price}',
                      style: TextStyle(
                        fontSize: Responsive.setSp(26),
                        color: const Color(0xFF3B82F6),
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    SizedBox(height: Responsive.setHeight(30)),
                    Text(
                      'Select Size',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Responsive.setSp(18),
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: Responsive.setHeight(12)),
                    SizeSelector(
                      product: loadedProduct,
                      selectedSize: _selectedSize,
                      onSelect: (size) => setState(() => _selectedSize = size),
                    ),

                    SizedBox(height: Responsive.setHeight(30)),
                    Text(
                      'Select Color',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Responsive.setSp(18),
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: Responsive.setHeight(16)),
                    ColorSelector(
                      product: loadedProduct,
                      selectedColor: _selectedColor,
                      onSelect: (color) => setState(() => _selectedColor = color),
                    ),

                    SizedBox(height: Responsive.setHeight(40)),
                    const Divider(),
                    SizedBox(height: Responsive.setHeight(20)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Customer Reviews',
                          style: TextStyle(
                            fontSize: Responsive.setSp(20),
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          'See All',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: Responsive.setSp(14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.setHeight(20)),
                    const ReviewItem(
                      name: 'Sarah Jenkins',
                      comment: 'Absolutely love the quality! Premium feel.',
                      rating: 5.0,
                    ),

                    SizedBox(height: Responsive.setHeight(40)),
                    const Divider(),
                    SizedBox(height: Responsive.setHeight(20)),

                    if (similarProducts.isNotEmpty) ...[
                      Text(
                        'You Might Also Like',
                        style: TextStyle(
                          fontSize: Responsive.setSp(20),
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(height: Responsive.setHeight(20)),
                      // Using Responsive for Height and Width to fit any screen
                      SizedBox(
                        height: Responsive.blockSizeVertical * 35, // Responsive height
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: similarProducts.length,
                          itemBuilder: (ctx, i) => Container(
                            width: Responsive.blockSizeHorizontal * 45, // Responsive width
                            margin: const EdgeInsets.only(right: 16),
                            child: Provider.value(
                              value: similarProducts[i],
                              child: const ProductItem(),
                            ),
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 140),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomSheet: ProductDetailsActions(
        product: loadedProduct,
        cart: cart,
        isDark: isDark,
      ),
    );
  }
}
