import 'package:flutter/material.dart';
import '../../models/product.dart';

class ColorSelector extends StatelessWidget {
  final Product product;
  final Color selectedColor;
  final Function(Color) onSelect;

  const ColorSelector({
    super.key,
    required this.product,
    required this.selectedColor,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: product.availableColors.length,
        itemBuilder: (ctx, i) => GestureDetector(
          onTap: () => onSelect(product.availableColors[i]),
          child: Container(
            margin: const EdgeInsets.only(right: 20),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: product.availableColors[i],
              shape: BoxShape.circle,
              border: Border.all(
                color: selectedColor == product.availableColors[i]
                    ? Colors.blue
                    : Colors.transparent,
                width: 3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
