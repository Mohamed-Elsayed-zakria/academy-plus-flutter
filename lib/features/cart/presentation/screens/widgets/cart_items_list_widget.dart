import 'package:flutter/material.dart';
import '../../../data/models/cart_item_model.dart';
import 'cart_item_widget.dart';

class CartItemsListWidget extends StatelessWidget {
  final List<CartItemModel> cartItems;
  final Future<void> Function() onRefresh;
  final Function(String) onRemoveItem;

  const CartItemsListWidget({
    super.key,
    required this.cartItems,
    required this.onRefresh,
    required this.onRemoveItem,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return CartItemWidget(
            item: item,
            onRemove: () => onRemoveItem(item.id),
          );
        },
      ),
    );
  }
}
