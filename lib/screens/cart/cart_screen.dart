import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart.dart' show Cart;
import '../../widgets/cart/cart_item_widget.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _promoController = TextEditingController();

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  void _applyPromo(Cart cart) {
    if (_promoController.text.isEmpty) return;
    final success = cart.applyPromoCode(_promoController.text);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Promo code applied successfully!')),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid promo code.')));
    }
    _promoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bool isEmpty = cart.items.isEmpty;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Shopping Bag'),
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Scrollable area
          Expanded(
            child: isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 80,
                          color: isDark ? Colors.white10 : Colors.grey.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Your bag is empty',
                          style: TextStyle(
                            fontSize: 18,
                            color: isDark ? Colors.white38 : Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: cart.items.length,
                    itemBuilder: (ctx, i) {
                      final item = cart.items.values.toList()[i];
                      return CartItemWidget(
                        item.id,
                        cart.items.keys.toList()[i],
                        item.price,
                        item.quantity,
                        item.title,
                        item.imageUrl,
                      );
                    },
                  ),
          ),
          
          // Bottom Summary Section (Always Visible)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0F172A) : Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Promo Code Row (Only functional if not empty)
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _promoController,
                          enabled: !isEmpty,
                          style: TextStyle(color: isDark ? Colors.white : Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Enter promo code',
                            hintStyle: TextStyle(
                              color: isDark ? Colors.white38 : Colors.grey,
                              fontSize: 14,
                            ),
                            filled: true,
                            fillColor: isDark ? Colors.black26 : Colors.grey.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: isDark ? const BorderSide(color: Colors.white10) : BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: isEmpty ? null : () => _applyPromo(cart),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isEmpty 
                              ? (isDark ? Colors.white10 : Colors.grey.shade300)
                              : (isDark ? Colors.white : Colors.black),
                          foregroundColor: isEmpty ? Colors.grey : (isDark ? Colors.black : Colors.white),
                          disabledBackgroundColor: isDark ? Colors.white10 : Colors.grey.shade200,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Apply'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Price Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Amount',
                        style: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: isEmpty 
                              ? Colors.grey 
                              : (isDark ? Colors.white : Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Checkout Button (Changes color based on cart state)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isEmpty
                          ? null
                          : () => Navigator.of(context).pushNamed(CheckoutScreen.routeName),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isEmpty 
                            ? (isDark ? Colors.white10 : Colors.grey.shade300) // Uncolored
                            : (isDark ? Colors.white : const Color(0xFF3B82F6)), // Colored
                        foregroundColor: isEmpty 
                            ? Colors.grey.shade500 
                            : (isDark ? Colors.black : Colors.white),
                        disabledBackgroundColor: isDark ? Colors.white10 : Colors.grey.shade300,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: isEmpty ? 0 : 4,
                      ),
                      child: Text(
                        'CHECKOUT',
                        style: TextStyle(
                          fontSize: 16, 
                          fontWeight: FontWeight.bold, 
                          letterSpacing: 1,
                          color: isEmpty ? Colors.grey : null,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
