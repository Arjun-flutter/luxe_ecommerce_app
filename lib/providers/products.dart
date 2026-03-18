import 'package:flutter/material.dart';
import '../models/product.dart';

enum SortOption { none, priceLowToHigh, priceHighToLow, rating }

class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Midnight Stealth Watch',
      description:
          'A minimalist masterpiece with a matte black finish and sapphire crystal.',
      price: 299.99,
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=800',
      category: 'Accessories',
      rating: 4.8,
      reviewsCount: 124,
      availableColors: [Colors.black, Colors.blueGrey],
    ),
    Product(
      id: 'p2',
      title: 'Luxe Crimson Handbag',
      description: 'Handcrafted Italian leather with gold-plated accents.',
      price: 599.99,
      imageUrl:
          'https://images.unsplash.com/photo-1591561954557-26941169b49e?auto=format&fit=crop&q=80&w=800',
      category: 'Fashion',
      rating: 4.9,
      reviewsCount: 89,
      availableColors: [Colors.red, Colors.brown, Colors.black],
    ),
    Product(
      id: 'p3',
      title: 'Aura Wireless Headphones',
      description:
          'Studio-grade sound with active noise cancellation and 40-hour battery.',
      price: 349.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=800',
      category: 'Electronics',
      rating: 4.7,
      reviewsCount: 256,
      availableColors: [Colors.black, Colors.white, Colors.blue],
    ),
    Product(
      id: 'p4',
      title: 'Velvet Dusk Sneakers',
      description:
          'Premium suede sneakers designed for both comfort and high-end style.',
      price: 189.99,
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&q=80&w=800',
      category: 'Fashion',
      rating: 4.5,
      reviewsCount: 412,
      availableSizes: ['7', '8', '9', '10', '11'],
      availableColors: [Colors.red, Colors.black],
    ),
    Product(
      id: 'p5',
      title: 'Gold Horizon Sunglasses',
      description:
          'Aviator style with 24k gold-rimmed frames and polarized lenses.',
      price: 220.00,
      imageUrl:
          'https://images.unsplash.com/photo-1572635196237-14b3f281503f?auto=format&fit=crop&q=80&w=800',
      category: 'Accessories',
      rating: 4.6,
      reviewsCount: 67,
      availableColors: [Colors.orange, Colors.black],
    ),
    Product(
      id: 'p6',
      title: 'Vision Pro VR Headset',
      description:
          'Next-generation immersive experience with 8K resolution and spatial audio.',
      price: 499.99,
      imageUrl:
          'https://images.unsplash.com/photo-1622979135225-d2ba269cf1ac?auto=format&fit=crop&q=80&w=800',
      category: 'Electronics',
      rating: 4.9,
      reviewsCount: 342,
    ),
    Product(
      id: 'p7',
      title: 'Silk Noir Scarf',
      description: '100% mulberry silk with an elegant hand-painted pattern.',
      price: 85.00,
      imageUrl:
          'https://images.unsplash.com/photo-1520903920243-00d872a2d1c9?auto=format&fit=crop&q=80&w=800',
      category: 'Fashion',
      rating: 4.8,
      reviewsCount: 34,
    ),
    Product(
      id: 'p8',
      title: 'Titanium Edge Laptop',
      description:
          'Ultra-thin, ultra-powerful with a stunning 5K Retina-ready display.',
      price: 1999.99,
      imageUrl:
          'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?auto=format&fit=crop&q=80&w=800',
      category: 'Electronics',
      rating: 4.9,
      reviewsCount: 92,
      availableColors: [Colors.grey, Colors.black],
    ),
    Product(
      id: 'p9',
      title: 'Classic Brew Coffee Press',
      description:
          'Copper-finished French press for the perfect morning ritual.',
      price: 65.00,
      imageUrl:
          'https://images.unsplash.com/photo-1544233726-9f1d2b27be8b?auto=format&fit=crop&q=80&w=800',
      category: 'Home & Kitchen',
      rating: 4.7,
      reviewsCount: 118,
    ),
    Product(
      id: 'p10',
      title: 'Marble & Gold Lamp',
      description:
          'A statement lighting piece featuring Carrara marble and brushed gold.',
      price: 210.00,
      imageUrl:
          'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&q=80&w=800',
      category: 'Home & Kitchen',
      rating: 4.5,
      reviewsCount: 45,
    ),
    Product(
      id: 'p11',
      title: 'Aromatic Sandalwood Candle',
      description: 'Hand-poured soy wax in a custom ceramic jar.',
      price: 45.00,
      imageUrl:
          'https://images.unsplash.com/photo-1602874801007-bd458bb1b8b6?auto=format&fit=crop&q=80&w=800',
      category: 'Home & Kitchen',
      rating: 4.3,
      reviewsCount: 78,
    ),
    Product(
      id: 'p12',
      title: 'Slate Grey Weekend Bag',
      description:
          'Durable canvas with premium leather straps, perfect for short escapes.',
      price: 145.00,
      imageUrl:
          'https://images.unsplash.com/photo-1547949003-9792a18a2601?auto=format&fit=crop&q=80&w=800',
      category: 'Fashion',
      rating: 4.6,
      reviewsCount: 56,
    ),
    Product(
      id: 'p13',
      title: 'Ethereal Skin Serum',
      description:
          'Infused with botanical extracts for a natural, glowing complexion.',
      price: 75.00,
      imageUrl:
          'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?auto=format&fit=crop&q=80&w=800',
      category: 'Beauty',
      rating: 4.8,
      reviewsCount: 189,
    ),
    Product(
      id: 'p14',
      title: 'Urban Explorer Backpack',
      description:
          'Weather-resistant materials with a sleek, aerodynamic design.',
      price: 120.00,
      imageUrl:
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&q=80&w=800',
      category: 'Fashion',
      rating: 4.5,
      reviewsCount: 134,
    ),
    Product(
      id: 'p15',
      title: 'Zen Desk Plant',
      description: 'Low-maintenance succulent in a geometric concrete pot.',
      price: 35.00,
      imageUrl:
          'https://images.unsplash.com/photo-1485955900006-10f4d324d411?auto=format&fit=crop&q=80&w=800',
      category: 'Home & Kitchen',
      rating: 4.2,
      reviewsCount: 210,
    ),
    Product(
      id: 'p16',
      title: 'Infinity Smart Watch',
      description: 'Advanced health tracking with a vibrant AMOLED display.',
      price: 249.99,
      imageUrl:
          'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?auto=format&fit=crop&q=80&w=800',
      category: 'Electronics',
      rating: 4.6,
      reviewsCount: 342,
    ),
    Product(
      id: 'p17',
      title: 'Pure Cashmere Sweater',
      description: 'Unbelievably soft and warm, ethically sourced cashmere.',
      price: 320.00,
      imageUrl:
          'https://images.unsplash.com/photo-1576566588028-4147f3842f27?auto=format&fit=crop&q=80&w=800',
      category: 'Fashion',
      rating: 4.9,
      reviewsCount: 65,
      availableSizes: ['S', 'M', 'L'],
      availableColors: [Colors.grey, Colors.white, Colors.black],
    ),
    Product(
      id: 'p18',
      title: 'Bronze Mechanical Keyboard',
      description:
          'Custom-built with tactile switches and a solid bronze frame.',
      price: 450.00,
      imageUrl:
          'https://images.unsplash.com/photo-1511467687858-23d96c32e4ae?auto=format&fit=crop&q=80&w=800',
      category: 'Electronics',
      rating: 4.7,
      reviewsCount: 28,
    ),
    Product(
      id: 'p19',
      title: 'Sculptural Fruit Bowl',
      description: 'A modern centerpiece made from recycled brushed aluminum.',
      price: 95.00,
      imageUrl:
          'https://images.unsplash.com/photo-1523901839036-a3030662f220?auto=format&fit=crop&q=80&w=800',
      category: 'Home & Kitchen',
      rating: 4.4,
      reviewsCount: 31,
    ),
    Product(
      id: 'p20',
      title: 'Desert Mirage Cologne',
      description: 'A bold, spicy scent with notes of oud and cedarwood.',
      price: 115.00,
      imageUrl:
          'https://images.unsplash.com/photo-1541643600914-78b084683601?auto=format&fit=crop&q=80&w=800',
      category: 'Beauty',
      rating: 4.8,
      reviewsCount: 145,
    ),
  ];

  SortOption _activeSort = SortOption.none;

  SortOption get activeSort => _activeSort;

  List<Product> _applySorting(List<Product> list) {
    final sortedList = [...list];
    if (_activeSort == SortOption.priceLowToHigh) {
      sortedList.sort((a, b) => a.price.compareTo(b.price));
    } else if (_activeSort == SortOption.priceHighToLow) {
      sortedList.sort((a, b) => b.price.compareTo(a.price));
    } else if (_activeSort == SortOption.rating) {
      sortedList.sort((a, b) => b.rating.compareTo(a.rating));
    }
    return sortedList;
  }

  List<Product> get items => _applySorting(_items);

  List<Product> getFavoriteItems(Set<String> favoriteIds) {
    return _applySorting(
      _items.where((p) => favoriteIds.contains(p.id)).toList(),
    );
  }

  void setSortOption(SortOption option) {
    _activeSort = option;
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere(
          (p) => p.id == id,
      orElse: () => throw Exception('Product not found'),

    );
  }

  List<Product> findByCategory(String cat) {
    final filtered = cat == 'All'
        ? [..._items]
        : _items
              .where((p) => p.category.toLowerCase() == cat.toLowerCase())
              .toList();
    return _applySorting(filtered);
  }

  List<Product> searchProducts(String query) {
    if (query.isEmpty) return [];
    final results = _items
        .where(
          (p) =>
              p.title.toLowerCase().contains(query.toLowerCase()) ||
              p.description.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    return _applySorting(results);
  }

  List<String> get categories => _items.map((p) => p.category).toSet().toList();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fetchAndSetProducts() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    _isLoading = false;
    notifyListeners();
  }
}
