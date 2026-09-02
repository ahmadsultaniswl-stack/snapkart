import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/Currency_Service/currency_service.dart';
import 'orderdetail_controller.dart';

class OrderdetailView extends StatelessWidget {
  OrderdetailView({super.key});

  final OrderdetailController controller = Get.put(OrderdetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        title: Text(
          'order_detail'.tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary(context),
          ),
        ),
        backgroundColor: AppColors.cardBackground(context),
        foregroundColor: AppColors.textPrimary(context),
        elevation: 0.5,
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _orderHeaderCard(),
              const SizedBox(height: 16),

              _sectionTitle('🛒 ${'ordered_items'.tr}', context),
              _itemsCard(context),
              const SizedBox(height: 16),

              _sectionTitle('📍 ${'delivery_address'.tr}', context),
              _addressCard(context),
              const SizedBox(height: 16),

              _sectionTitle('💳 ${'payment_info'.tr}', context),
              _paymentCard(context),
              const SizedBox(height: 16),

              _sectionTitle('💰 ${'price_breakdown'.tr}', context),
              _priceCard(context),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary(context),
        ),
      ),
    );
  }

  Widget _orderHeaderCard() {
    final statusColor = controller.getStatusColor(controller.status.value);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#${controller.orderId.value.isNotEmpty ? controller.orderId.value.substring(0, 8).toUpperCase() : 'N/A'}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${controller.getStatusEmoji(controller.status.value)}  ${controller.status.value}',
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${'order_date'.tr}: ${controller.orderDate.value}',
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _itemsCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: _cardDecoration(context),
      child: ValueListenableBuilder<String>(
        valueListenable: CurrencyService.instance.symbol,
        builder: (context, currency, _) {
          return Column(
            children: [
              ...controller.items.map((item) {
                final price = (item['price'] ?? 0).toDouble();
                final qty = (item['quantity'] ?? 1) as int;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              item['image'] ?? '',
                              width: 64,
                              height: 64,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 64,
                                height: 64,
                                color: isDark
                                    ? Colors.white.withOpacity(0.06)
                                    : Colors.grey.shade100,
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: AppColors.textSecondary(context),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'] ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppColors.textPrimary(context),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$currency ${price.toStringAsFixed(0)} x $qty',
                                  style: TextStyle(
                                    color: AppColors.textSecondary(context),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '$currency ${(price * qty).toStringAsFixed(0)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (item != controller.items.last)
                      Divider(
                        height: 1,
                        indent: 12,
                        endIndent: 12,
                        color: isDark ? Colors.white.withOpacity(0.08) : null,
                      ),
                  ],
                );
              }),
            ],
          );
        },
      ),
    );
  }

  Widget _addressCard(BuildContext context) {
    final addr = controller.address.value;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            addr['name'] ?? 'N/A',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: AppColors.textPrimary(context),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            addr['street'] ?? '',
            style: TextStyle(color: AppColors.textSecondary(context)),
          ),
          Text(
            '${addr['city'] ?? ''}, ${addr['province'] ?? ''}',
            style: TextStyle(color: AppColors.textSecondary(context)),
          ),
          if (addr['phone'] != null) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  Icons.phone,
                  size: 14,
                  color: AppColors.textSecondary(context),
                ),
                const SizedBox(width: 4),
                Text(
                  addr['phone'],
                  style: TextStyle(color: AppColors.textSecondary(context)),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _paymentCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(context),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.payment_rounded, color: AppColors.secondary),
          ),
          const SizedBox(width: 12),
          Text(
            controller.paymentMethod.value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: AppColors.textPrimary(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceCard(BuildContext context) {
    final subtotal = controller.totalAmount.value;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(context),
      child: ValueListenableBuilder<String>(
        valueListenable: CurrencyService.instance.symbol,
        builder: (context, currency, _) {
          return Column(
            children: [
              _priceRow(
                context,
                'subtotal'.tr,
                '$currency ${subtotal.toStringAsFixed(0)}',
              ),
              const SizedBox(height: 10),
              _priceRow(context, 'delivery_fee'.tr, 'free'.tr, isGreen: true),
              Divider(
                height: 20,
                color: isDark ? Colors.white.withOpacity(0.08) : null,
              ),
              _priceRow(
                context,
                'total'.tr,
                '$currency ${subtotal.toStringAsFixed(0)}',
                isBold: true,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _priceRow(
    BuildContext context,
    String label,
    String value, {
    bool isBold = false,
    bool isGreen = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: AppColors.textPrimary(context),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isGreen
                ? Colors.green
                : isBold
                ? AppColors.secondary
                : AppColors.textPrimary(context),
          ),
        ),
      ],
    );
  }

  BoxDecoration _cardDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: AppColors.cardBackground(context),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: isDark
              ? Colors.black.withOpacity(0.3)
              : Colors.black.withOpacity(0.06),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}
