import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/Currency_Service/currency_service.dart';
import '../../Utilities_Screens/Wave_Skelton_Box/wave_skelton_box.dart';
import 'History_Controller.dart';

class HistoryView extends StatelessWidget {
  HistoryView({super.key});

  final HistoryController controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        title: Text(
          'order_history'.tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary(context),
          ),
        ),
        backgroundColor: AppColors.cardBackground(context),
        foregroundColor: AppColors.textPrimary(context),
        elevation: 0.5,
        actions: [
          IconButton(
            onPressed: () => _showClearAllDialog(context),
            icon: const Icon(Icons.delete_sweep_outlined),
            tooltip: 'clear_all'.tr,
          ),
        ],
      ),
      body: Obx(() {
        // if (controller.isLoading.value) {
        //   return const Center(
        //     child: CircularProgressIndicator(color: Color(0xFF6C63FF)),
        //   );
        // }

        if (controller.isLoading.value) {
          return _buildSkeletonList();
        }

        if (controller.orders.isEmpty) {
          return _emptyState(context);
        }

        return RefreshIndicator(
          onRefresh: controller.fetchOrders,
          color: const Color(0xFF6C63FF),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.orders.length,
            itemBuilder: (context, index) {
              final order = controller.orders[index];
              return _orderCard(order, context);
            },
          ),
        );
      }),
    );
  }

  void _showClearAllDialog(BuildContext context) {
    Get.defaultDialog(
      title: 'clear_all_history_title'.tr,
      middleText: 'clear_all_history_msg'.tr,
      textConfirm: 'clear'.tr,
      textCancel: 'cancel'.tr,
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back();
        controller.clearAllHistory();
      },
    );
  }

  void _showDeleteDialog(BuildContext context, String orderId) {
    Get.defaultDialog(
      title: 'delete_order_title'.tr,
      middleText: 'delete_order_msg'.tr,
      textConfirm: 'delete'.tr,
      textCancel: 'cancel'.tr,
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back();
        controller.deleteOrder(orderId);
      },
    );
  }

  // ── Empty State ──
  Widget _emptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'no_order'.tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary(context),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'no_order_yet'.tr,
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Order Card ──
  Widget _orderCard(Map<String, dynamic> order, BuildContext context) {
    final orderId = order['orderId'] ?? '';
    final status = order['status'] ?? 'Pending';
    final totalAmount = (order['totalAmount'] ?? 0).toDouble();
    final paymentMethod = order['paymentMethod'] ?? 'N/A';
    final items = order['items'] as List<dynamic>? ?? [];

    String formattedDate = 'N/A';
    if (order['createdAt'] != null) {
      try {
        final ts = order['createdAt'] as dynamic;
        final date = ts.toDate();
        formattedDate = '${date.day}/${date.month}/${date.year}';
      } catch (_) {}
    }

    return GestureDetector(
      onTap: () => controller.goToOrderDetail(order),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: AppColors.cardBackground(context),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // ── Card Header ──
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFF6C63FF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '#${orderId.substring(0, 8).toUpperCase()}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    formattedDate,
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),

            // ── Card Body ──
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ...items.take(2).map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item['image'] ?? '',
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 48,
                                height: 48,
                                color: Colors.grey.shade100,
                                child: const Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              item['name'] ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: AppColors.textPrimary(context),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            'x${item['quantity'] ?? 1}',
                            style: TextStyle(
                              color: AppColors.textSecondary(context),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  if (items.length > 2)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'more_items'.trParams({
                          'count': (items.length - 2).toString(),
                        }),
                        style: const TextStyle(
                          color: Color(0xFF6C63FF),
                          fontSize: 12,
                        ),
                      ),
                    ),

                  const Divider(height: 20),

                  // ── Footer Row ──
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _statusColor(status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${controller.getStatusEmoji(status)}  $status',
                          style: TextStyle(
                            color: _statusColor(status),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'total'.tr,
                            style: TextStyle(
                              color: AppColors.textSecondary(context),
                              fontSize: 11,
                            ),
                          ),
                          ValueListenableBuilder<String>(
                            valueListenable: CurrencyService.instance.symbol,
                            builder: (context, currency, _) {
                              return Text(
                                '$currency ${totalAmount.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color(0xFF6C63FF),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Payment method
                  Row(
                    children: [
                      const Icon(Icons.payment, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        paymentMethod,
                        style: TextStyle(
                          color: AppColors.textSecondary(context),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Delete button
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () => _showDeleteDialog(context, orderId),
                      icon: const Icon(
                        Icons.delete_outline,
                        size: 16,
                        color: Colors.red,
                      ),
                      label: Text(
                        'delete'.tr,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // skelton loader wave

  Widget _buildSkeletonList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 4, // fake placeholder count
      itemBuilder: (context, index) => _skeletonOrderCard(),
    );
  }

  Widget _skeletonOrderCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // header bar
          const WaveSkeletonBox(
            height: 44,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // item row 1
                Row(
                  children: [
                    const WaveSkeletonBox(
                      width: 48,
                      height: 48,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: WaveSkeletonBox(
                        height: 14,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // item row 2
                Row(
                  children: [
                    const WaveSkeletonBox(
                      width: 48,
                      height: 48,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: WaveSkeletonBox(
                        height: 14,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WaveSkeletonBox(
                      width: 80,
                      height: 22,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    WaveSkeletonBox(
                      width: 60,
                      height: 18,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Status Color ──
Color _statusColor(String status) {
  switch (status.toLowerCase()) {
    case 'pending':
      return Colors.orange;
    case 'confirmed':
      return Colors.blue;
    case 'shipped':
      return Colors.indigo;
    case 'delivered':
      return Colors.green;
    case 'cancelled':
      return Colors.red;
    default:
      return Colors.orange;
  }
}
