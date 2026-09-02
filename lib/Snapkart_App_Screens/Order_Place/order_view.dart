import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/Currency_Service/currency_service.dart';
import 'order_controller.dart';

class OrderView extends StatelessWidget {
  OrderView({super.key});

  final OrderController controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: SafeArea(
        child: Obx(
          () => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle_rounded,
                    size: 80,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 24),

                Text(
                  'order_placed'.tr,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary(context),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'order_placed_sub'.tr,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary(context),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 36),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground(context),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black.withOpacity(0.3)
                            : Colors.black.withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _detailRow(
                        context: context,
                        icon: Icons.receipt_long,
                        label: 'order_id'.tr,
                        value: controller.orderId.value.isNotEmpty
                            ? '#${controller.orderId.value.substring(0, 8).toUpperCase()}'
                            : '#N/A',
                      ),
                      Divider(
                        height: 24,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withOpacity(0.08)
                            : null,
                      ),
                      _detailRow(
                        context: context,
                        icon: Icons.calendar_today,
                        label: 'order_date'.tr,
                        value: controller.orderDate.value.isNotEmpty
                            ? controller.orderDate.value
                            : 'today'.tr,
                      ),
                      Divider(
                        height: 24,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withOpacity(0.08)
                            : null,
                      ),
                      _detailRow(
                        context: context,
                        icon: Icons.payment,
                        label: 'payment'.tr,
                        value: controller.paymentMethod.value.isNotEmpty
                            ? controller.paymentMethod.value
                            : 'N/A',
                      ),
                      Divider(
                        height: 24,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withOpacity(0.08)
                            : null,
                      ),
                      ValueListenableBuilder<String>(
                        valueListenable: CurrencyService.instance.symbol,
                        builder: (context, currency, _) {
                          return _detailRow(
                            context: context,
                            icon: Icons.attach_money,
                            label: 'total_amount'.tr,
                            value:
                                '$currency ${controller.totalAmount.value.toStringAsFixed(0)}',
                            isHighlighted: true,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton.icon(
                    onPressed: controller.goHome,
                    icon: const Icon(Icons.home_rounded),
                    label: Text(
                      'home'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    bool isHighlighted = false,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.secondary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: AppColors.secondary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary(context),
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: isHighlighted
                ? AppColors.secondary
                : AppColors.textPrimary(context),
          ),
        ),
      ],
    );
  }
}
