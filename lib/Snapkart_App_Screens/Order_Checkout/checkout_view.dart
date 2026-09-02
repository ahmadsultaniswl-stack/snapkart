import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/Currency_Service/currency_service.dart';
import '../Cart_Screen/cart_controller.dart';
import 'checkout_controller.dart';

class CheckoutView extends StatelessWidget {
  CheckoutView({super.key});

  final CheckoutController controller = Get.put(CheckoutController());
  final CartController cartController = CartController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        title: Text(
          'checkout'.tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary(context),
          ),
        ),
        backgroundColor: AppColors.cardBackground(context),
        foregroundColor: AppColors.textPrimary(context),
        elevation: 0.5,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle('🛒 ${'order_summary'.tr}', context),
              _orderSummaryCard(context),
              const SizedBox(height: 20),

              _sectionTitle(' ${'delivery_address'.tr}', context),
              controller.isLoadingAddresses.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.savedAddresses.isEmpty
                  ? _noAddressCard(context)
                  : _addressList(context),
              const SizedBox(height: 20),
              _sectionTitle('💳 ${'payment_method'.tr}', context),
              _paymentMethodList(context),
              const SizedBox(height: 30),
              _placeOrderButton(),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  Widget _sectionTitle(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary(context),
        ),
      ),
    );
  }

  Widget _orderSummaryCard(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: _cardDecoration(context),
        child: ValueListenableBuilder<String>(
          valueListenable: CurrencyService.instance.symbol,
          builder: (context, currency, _) {
            return Column(
              children: [
                ...cartController.cartItems.map((item) {
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item['image'] ?? '',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.image_not_supported),
                      ),
                    ),
                    title: Text(
                      item['name'] ?? '',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text('Qty: ${item['quantity']}'),
                    trailing: Text(
                      '$currency ${((item['price'] ?? 0) * (item['quantity'] ?? 1)).toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6C63FF),
                      ),
                    ),
                  );
                }),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'total'.tr,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$currency ${cartController.totalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6C63FF),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _noAddressCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(context),
      child: Column(
        children: [
          const Icon(Icons.location_off, size: 40, color: Colors.grey),
          const SizedBox(height: 8),
          Text('no_address_saved'.tr),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () async {
              await Get.toNamed('/address');
              controller.fetchAddresses();
            },
            icon: const Icon(Icons.add),
            label: Text('address_add'.tr),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C63FF),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _addressList(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: _cardDecoration(context),
        child: Column(
          children: List.generate(controller.savedAddresses.length, (index) {
            final addr = controller.savedAddresses[index];
            return Obx(
              () => RadioListTile<int>(
                value: index,
                groupValue: controller.selectedAddressIndex.value,
                onChanged: (val) => controller.selectAddress(val!),
                activeColor: const Color(0xFF6C63FF),
                title: Text(
                  addr['name'] ?? 'Address ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  '${addr['street'] ?? ''}, ${addr['city'] ?? ''}, ${addr['province'] ?? ''}',
                  style: TextStyle(color: AppColors.textSecondary(context)),
                ),
                secondary: IconButton(
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xFF6C63FF),
                  ),
                  onPressed: () async {
                    await Get.toNamed('/address', arguments: addr);
                    controller.fetchAddresses();
                  },
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _paymentMethodList(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: _cardDecoration(context),
        child: Column(
          children: controller.paymentMethods.map((method) {
            return Obx(
              () => RadioListTile<String>(
                value: method['name']!,
                groupValue: controller.selectedPayment.value,
                onChanged: (val) => controller.selectPayment(val!),
                activeColor: const Color(0xFF6C63FF),
                title: Text(
                  '${method['icon']}  ${method['name']}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _placeOrderButton() {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: controller.isPlacingOrder.value
              ? null
              : () => controller.placeOrder(
                  cartController.cartItems
                      .map((e) => Map<String, dynamic>.from(e))
                      .toList(),
                  cartController.totalPrice,
                ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C63FF),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: controller.isPlacingOrder.value
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  'order_place'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration(BuildContext context) {
    return BoxDecoration(
      color: AppColors.cardBackground(context),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}
