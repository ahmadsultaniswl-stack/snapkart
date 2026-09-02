import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../App_Routes/routes_view.dart';
import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/Currency_Service/currency_service.dart';
import 'cart_controller.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = CartController.instance;

    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        title: Text(
          'cart_title'.tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary(context),
          ),
        ),
        backgroundColor: AppColors.cardBackground(context),
        foregroundColor: AppColors.textPrimary(context),
        elevation: 0.5,
        actions: [
          Obx(() {
            if (controller.cartItems.isEmpty) return const SizedBox();
            return TextButton.icon(
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: Text('cart_clear_question'.tr),
                    content: Text('all_items_removed'.tr),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          'cancel'.tr,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.clearCart();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('clear'.tr),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: 18,
              ),
              label: Text(
                'clear'.tr,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }),
        ],
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return _emptyState(context);
        }

        return Column(
          children: [
            // ── Items List ──
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  final item = controller.cartItems[index];
                  return _cartItemCard(controller, item, index, context);
                },
              ),
            ),

            _bottomSummary(controller, context),
          ],
        );
      }),
    );
  }

  // ── Cart Item Card ──
  Widget _cartItemCard(
    CartController controller,
    Map<String, dynamic> item,
    int index,
    BuildContext context,
  ) {
    final basePrice = (item['price'] as num? ?? 0).toDouble();
    final qty = (item['quantity'] as int? ?? 1);
    final name = item['title'] ?? item['name'] ?? 'Product';
    final image = item['image'] ?? '';

    // Tier-aware pricing
    final unitPrice = controller.getUnitPrice(item);
    final itemSavings = controller.getItemSavings(
      item,
    ); // total savings for this line (qty included)
    final hasDiscount = itemSavings > 0;
    final itemTotal = unitPrice * qty;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              image,
              width: 72,
              height: 72,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Container(
                width: 72,
                height: 72,
                color: Colors.grey.shade100,
                child: const Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppColors.textPrimary(context),
                  ),
                ),
                const SizedBox(height: 6),

                // Price row: discounted unit price + strikethrough base price
                ValueListenableBuilder<String>(
                  valueListenable: CurrencyService.instance.symbol,
                  builder: (context, currency, _) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '$currency ${unitPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Color(0xFF6C63FF),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        if (hasDiscount) ...[
                          const SizedBox(width: 6),
                          Text(
                            '$currency ${basePrice.toStringAsFixed(0)}',
                            style: TextStyle(
                              color: AppColors.textSecondary(context),
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),

                // Savings badge
                if (hasDiscount) ...[
                  const SizedBox(height: 4),
                  ValueListenableBuilder<String>(
                    valueListenable: CurrencyService.instance.symbol,
                    builder: (context, currency, _) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${'you_save'.tr} $currency ${itemSavings.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    },
                  ),
                ],

                const SizedBox(height: 8),

                // Quantity Controls + line total
                Row(
                  children: [
                    _qtyButton(
                      icon: Icons.remove,
                      onTap: () => controller.updateQuantity(index, qty - 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '$qty',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.textPrimary(context),
                        ),
                      ),
                    ),
                    _qtyButton(
                      icon: Icons.add,
                      onTap: () => controller.updateQuantity(index, qty + 1),
                      isPrimary: true,
                    ),
                    const Spacer(),
                    ValueListenableBuilder<String>(
                      valueListenable: CurrencyService.instance.symbol,
                      builder: (context, currency, _) {
                        return Text(
                          '$currency ${itemTotal.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: AppColors.textPrimary(context),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Delete Button
          IconButton(
            onPressed: () => controller.removeFromCart(index),
            icon: const Icon(Icons.delete_outline, color: Colors.red, size: 22),
          ),
        ],
      ),
    );
  }

  // ── Quantity Button ──
  Widget _qtyButton({
    required IconData icon,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: isPrimary
              ? const Color(0xFF6C63FF)
              : const Color(0xFF6C63FF).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 16,
          color: isPrimary ? Colors.white : const Color(0xFF6C63FF),
        ),
      ),
    );
  }

  // ── Bottom Summary ──
  Widget _bottomSummary(CartController controller, BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(
                  'items_count'.trParams({
                    'count': controller.cartItemCount.toString(),
                  }),
                  style: TextStyle(
                    color: AppColors.textSecondary(context),
                    fontSize: 14,
                  ),
                ),
              ),
              ValueListenableBuilder<String>(
                valueListenable: CurrencyService.instance.symbol,
                builder: (context, currency, _) {
                  return Obx(
                    () => Text(
                      '$currency ${controller.totalPrice.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF6C63FF),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'delivery'.tr,
                style: TextStyle(
                  color: AppColors.textSecondary(context),
                  fontSize: 13,
                ),
              ),
              Text(
                '${'free'.tr}',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Checkout Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.toNamed(AppRoutes.checkout),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: Text(
                'order_checkout'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Empty State ──
  Widget _emptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'cart_empty_title'.tr,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary(context),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'no_item_in_cart'.tr,
            style: TextStyle(color: AppColors.textSecondary(context)),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Get.offAllNamed('/home'),
            icon: const Icon(Icons.shopping_bag_outlined),
            label: Text('do_shopping'.tr),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C63FF),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
