import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/products.dart';
import '../../widgets/home/promo_banner.dart';
import '../../widgets/products/product_item.dart';
import '../../providers/cart.dart';
import '../../providers/favorites_provider.dart';
import '../cart/cart_screen.dart';
import '../products/search_screen.dart';
import '../profile/notifications_screen.dart';
import '../../core/utils/responsive.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen>
    with SingleTickerProviderStateMixin {
  var _showOnlyFavorites = false;
  late AnimationController _controller;
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive().init(context);

    final productsData = Provider.of<Products>(context);
    final favoritesData = Provider.of<FavoritesProvider>(context);
    final categories = ['All', ...productsData.categories];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    var products = _showOnlyFavorites
        ? productsData.getFavoriteItems(favoritesData.favoriteProductIds)
        : productsData.findByCategory(_selectedCategory);

    final double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 1200
        ? 5
        : (screenWidth > 900 ? 4 : (screenWidth > 600 ? 3 : 2));

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF020617)
          : const Color(0xFFF8F9FA),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: Responsive.blockSizeVertical * 12,
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
            title: Text(
              'LUXE',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
                fontSize: Responsive.blockSizeHorizontal * 5 > 24
                    ? 24
                    : Responsive.blockSizeHorizontal * 5,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.notifications_outlined,
                color: isDark ? Colors.white : Colors.black,
              ),
              onPressed: () => Navigator.of(
                context,
              ).pushNamed(NotificationsScreen.routeName),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search_rounded,
                  color: isDark ? Colors.white : Colors.black,
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamed(SearchScreen.routeName),
              ),
              Consumer<Cart>(
                builder: (_, cart, ch) => Badge(
                  label: Text(cart.itemCount.toString()),
                  backgroundColor: isDark
                      ? const Color(0xFF3B82F6)
                      : Colors.black,
                  child: ch!,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_bag_outlined,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(CartScreen.routeName),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),

          const SliverToBoxAdapter(
            child: PromoBanner(),
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.blockSizeHorizontal * 5,
                  ),
                  child: const Text(
                    'Official Brands',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 60,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.blockSizeHorizontal * 4,
                    ),
                    children: [
                      _brandLogo('APPLE', isDark),
                      _brandLogo('NIKE', isDark),
                      _brandLogo('ZARA', isDark),
                      _brandLogo('GUCCI', isDark),
                      _brandLogo('SONY', isDark),
                      _brandLogo('PRADA', isDark),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: SizedBox(
                height: 45,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.blockSizeHorizontal * 4,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (ctx, i) {
                    final isSelected = _selectedCategory == categories[i] && !_showOnlyFavorites;
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () => setState(() {
                          _selectedCategory = categories[i];
                          _showOnlyFavorites = false;
                        }),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (isDark
                                    ? const Color(0xFF3B82F6).withOpacity(0.2)
                                    : const Color(0xFF3B82F6).withOpacity(0.1))
                                : (isDark
                                    ? Colors.white.withOpacity(0.05)
                                    : Colors.grey.shade100),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF3B82F6)
                                  : Colors.transparent,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            categories[i],
                            style: TextStyle(
                              color: isSelected
                                  ? const Color(0xFF3B82F6)
                                  : (isDark ? Colors.white70 : Colors.black54),
                              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                              fontSize: Responsive.blockSizeHorizontal * 3.5 > 14
                                  ? 14
                                  : Responsive.blockSizeHorizontal * 3.5,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              Responsive.blockSizeHorizontal * 4,
              24,
              Responsive.blockSizeHorizontal * 4,
              12,
            ),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _showOnlyFavorites ? 'Your Wishlist' : 'Trending Now',
                    style: TextStyle(
                      fontSize: Responsive.blockSizeHorizontal * 5.5 > 22
                          ? 22
                          : Responsive.blockSizeHorizontal * 5.5,
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                  Row(
                    children: [
                      PopupMenuButton<SortOption>(
                        onSelected: (SortOption val) => productsData.setSortOption(val),
                        icon: Icon(Icons.sort_rounded, color: isDark ? Colors.white : Colors.black),
                        itemBuilder: (_) => [
                          const PopupMenuItem(value: SortOption.none, child: Text('Default')),
                          const PopupMenuItem(value: SortOption.priceLowToHigh, child: Text('Price: Low to High')),
                          const PopupMenuItem(value: SortOption.priceHighToLow, child: Text('Price: High to Low')),
                          const PopupMenuItem(value: SortOption.rating, child: Text('Top Rated')),
                        ],
                      ),
                      PopupMenuButton(
                        onSelected: (FilterOptions val) => setState(
                          () => _showOnlyFavorites = val == FilterOptions.favorites,
                        ),
                        icon: Icon(
                          Icons.tune_rounded,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        itemBuilder: (_) => [
                          const PopupMenuItem(
                            value: FilterOptions.favorites,
                            child: Text('Favorites'),
                          ),
                          const PopupMenuItem(
                            value: FilterOptions.all,
                            child: Text('Show All'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.blockSizeHorizontal * 4,
            ),
            sliver: products.isEmpty
                ? const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: Text('No items found.')),
                  )
                : SliverGrid(
                    key: ValueKey('${productsData.activeSort}_${_selectedCategory}_$_showOnlyFavorites'),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: screenWidth > 600 ? 0.7 : 0.52,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 20,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (ctx, i) => Provider.value(
                        value: products[i],
                        child: const ProductItem(),
                      ),
                      childCount: products.length,
                    ),
                  ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _brandLogo(String name, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            color: isDark ? Colors.white : Colors.black,
            fontSize: Responsive.blockSizeHorizontal * 3.5 > 14
                ? 14
                : Responsive.blockSizeHorizontal * 3.5,
          ),
        ),
      ),
    );
  }
}
