import 'package:flutter/material.dart';
import '../../models/product.dart';

class SizeSelector extends StatelessWidget {
  final Product product;
  final String selectedSize;
  final Function(String) onSelect;

  const SizeSelector({
    super.key,
    required this.product,
    required this.selectedSize,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: product.availableSizes.length,
        itemBuilder: (ctx, i) => Padding(
          padding: const EdgeInsets.only(right: 12),
          child: ChoiceChip(
            label: Text(product.availableSizes[i]),
            selected: selectedSize == product.availableSizes[i],
            onSelected: (selected) => onSelect(product.availableSizes[i]),
          ),
        ),
      ),
    );
  }
}
