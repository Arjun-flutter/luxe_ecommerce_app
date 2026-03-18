import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final double rating;
  final int reviewsCount;
  final List<String> availableSizes;
  final List<Color> availableColors;
  final bool isInStock;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.rating = 4.5,
    this.reviewsCount = 0,
    this.availableSizes = const ['S', 'M', 'L', 'XL'],
    this.availableColors = const [Colors.black, Colors.white, Colors.grey],
    this.isInStock = true,
  });
}
