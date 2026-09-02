// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// //
// // import '../../Utilities_Screens/App_Colors/app_colors.dart';
// // import '../../Utilities_Screens/App_Model/app_model.dart';
// // import '../../Utilities_Screens/Currency_Service/currency_service.dart';
// // import '../Wishlist_Screen/wishlist_controller.dart';
// // import 'detail_controller.dart';
// //
// // class ProductDetailView extends StatelessWidget {
// //   const ProductDetailView({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final product = Get.arguments as ModelClass?;
// //     final controller = Get.put(ProductDetailController());
// //
// //     if (product != null) {
// //       controller.product.value = product;
// //     }
// //
// //     if (product == null) {
// //       return Scaffold(
// //         backgroundColor: AppColors.background(context),
// //         appBar: AppBar(
// //           backgroundColor: AppColors.cardBackground(context),
// //           elevation: 0,
// //           leading: IconButton(
// //             onPressed: () => Get.back(),
// //             icon: Icon(Icons.arrow_back, color: AppColors.textPrimary(context)),
// //           ),
// //           title: Text(
// //             'product_not_found'.tr,
// //             style: TextStyle(color: AppColors.textPrimary(context)),
// //           ),
// //         ),
// //         body: Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Icon(
// //                 Icons.error_outline,
// //                 size: 64,
// //                 color: AppColors.textSecondary(context),
// //               ),
// //               const SizedBox(height: 16),
// //               Text(
// //                 'product_not_found'.tr,
// //                 style: TextStyle(color: AppColors.textSecondary(context)),
// //               ),
// //             ],
// //           ),
// //         ),
// //       );
// //     }
// //
// //     return Scaffold(
// //       backgroundColor: AppColors.background(context),
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             _buildAppBar(controller, context),
// //             Expanded(
// //               child: SingleChildScrollView(
// //                 physics: const BouncingScrollPhysics(),
// //                 padding: const EdgeInsets.only(bottom: 80),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     _buildProductImage(product, context),
// //                     _buildProductDetails(controller, product, context),
// //                     _buildQuantitySelector(controller, context),
// //                     _buildActionButtons(controller, context),
// //                     _buildAdditionalInfo(context),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             _buildBottomBar(controller, context),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildAppBar(
// //     ProductDetailController controller,
// //     BuildContext context,
// //   ) {
// //     final isDark = Theme.of(context).brightness == Brightness.dark;
// //     final chipColor = isDark
// //         ? Colors.white.withOpacity(0.08)
// //         : Colors.grey.shade100;
// //
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //       color: AppColors.cardBackground(context),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           GestureDetector(
// //             onTap: () => Get.back(),
// //             child: Container(
// //               padding: const EdgeInsets.all(8),
// //               decoration: BoxDecoration(
// //                 color: chipColor,
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //               child: Icon(
// //                 Icons.arrow_back,
// //                 size: 22,
// //                 color: AppColors.textPrimary(context),
// //               ),
// //             ),
// //           ),
// //           Text(
// //             'product_details'.tr,
// //             style: TextStyle(
// //               fontSize: 18,
// //               fontWeight: FontWeight.w600,
// //               color: AppColors.textPrimary(context),
// //             ),
// //           ),
// //           Obx(() {
// //             final wishlisted = WishlistController.instance.isWishlisted(
// //               controller.product.value?.id,
// //             );
// //             return GestureDetector(
// //               onTap: controller.toggleWishlist,
// //               child: Container(
// //                 padding: const EdgeInsets.all(8),
// //                 decoration: BoxDecoration(
// //                   color: wishlisted
// //                       ? AppColors.secondary.withOpacity(0.1)
// //                       : chipColor,
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //                 child: Icon(
// //                   wishlisted
// //                       ? Icons.favorite_rounded
// //                       : Icons.favorite_border_rounded,
// //                   color: wishlisted
// //                       ? AppColors.secondary
// //                       : AppColors.textSecondary(context),
// //                   size: 22,
// //                 ),
// //               ),
// //             );
// //           }),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildProductImage(ModelClass product, BuildContext context) {
// //     final isDark = Theme.of(context).brightness == Brightness.dark;
// //
// //     return Container(
// //       margin: const EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: AppColors.cardBackground(context),
// //         borderRadius: BorderRadius.circular(20),
// //         boxShadow: [
// //           BoxShadow(
// //             color: isDark
// //                 ? Colors.black.withOpacity(0.35)
// //                 : Colors.grey.shade200,
// //             blurRadius: 20,
// //             offset: const Offset(0, 8),
// //           ),
// //         ],
// //       ),
// //       child: Stack(
// //         children: [
// //           ClipRRect(
// //             borderRadius: BorderRadius.circular(20),
// //             child: Container(
// //               height: 300,
// //               width: double.infinity,
// //               color: isDark
// //                   ? Colors.white.withOpacity(0.04)
// //                   : Colors.grey.shade50,
// //               child: Image.network(
// //                 product.image ?? '',
// //                 fit: BoxFit.contain,
// //                 errorBuilder: (context, error, stackTrace) {
// //                   return Center(
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Icon(
// //                           Icons.broken_image,
// //                           size: 80,
// //                           color: isDark
// //                               ? Colors.grey.shade700
// //                               : Colors.grey.shade300,
// //                         ),
// //                         Text(
// //                           'no_description'.tr,
// //                           style: TextStyle(
// //                             color: AppColors.textSecondary(context),
// //                             fontSize: 14,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   );
// //                 },
// //                 loadingBuilder: (context, child, loadingProgress) {
// //                   if (loadingProgress == null) return child;
// //                   return Center(
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         SizedBox(
// //                           width: 40,
// //                           height: 40,
// //                           child: CircularProgressIndicator(
// //                             valueColor: AlwaysStoppedAnimation<Color>(
// //                               AppColors.secondary,
// //                             ),
// //                             strokeWidth: 3,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 8),
// //                       ],
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),
// //           ),
// //           Positioned(
// //             top: 16,
// //             left: 16,
// //             child: Container(
// //               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
// //               decoration: BoxDecoration(
// //                 gradient: LinearGradient(
// //                   colors: [
// //                     AppColors.secondary,
// //                     AppColors.secondary.withOpacity(0.7),
// //                   ],
// //                 ),
// //                 borderRadius: BorderRadius.circular(20),
// //               ),
// //               child: Text(
// //                 product.category ?? 'Category',
// //                 style: const TextStyle(
// //                   color: Colors.white,
// //                   fontSize: 12,
// //                   fontWeight: FontWeight.w600,
// //                   letterSpacing: 0.5,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildProductDetails(
// //     ProductDetailController controller,
// //     ModelClass product,
// //     BuildContext context,
// //   ) {
// //     final isDark = Theme.of(context).brightness == Brightness.dark;
// //
// //     final hasDiscount =
// //         product.discountPrice != null && product.discountPrice! > 0;
// //     final percentOff = hasDiscount && (product.price ?? 0) > 0
// //         ? (((product.price! - product.discountPrice!) / product.price!) * 100)
// //               .round()
// //         : 0;
// //
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 20),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const SizedBox(height: 8),
// //           Text(
// //             product.title ?? 'Product',
// //             style: TextStyle(
// //               fontSize: 22,
// //               fontWeight: FontWeight.bold,
// //               height: 1.3,
// //               color: AppColors.textPrimary(context),
// //             ),
// //           ),
// //           const SizedBox(height: 12),
// //           Row(
// //             children: [
// //               Row(
// //                 children: List.generate(5, (index) {
// //                   final rating = product.rating?.rate ?? 0;
// //                   if (index < rating.floor()) {
// //                     return const Icon(
// //                       Icons.star_rounded,
// //                       color: Colors.amber,
// //                       size: 20,
// //                     );
// //                   } else if (index < rating.ceil() && rating % 1 != 0) {
// //                     return const Icon(
// //                       Icons.star_half_rounded,
// //                       color: Colors.amber,
// //                       size: 20,
// //                     );
// //                   } else {
// //                     return Icon(
// //                       Icons.star_border_rounded,
// //                       color: isDark
// //                           ? Colors.grey.shade700
// //                           : Colors.grey.shade300,
// //                       size: 20,
// //                     );
// //                   }
// //                 }),
// //               ),
// //               const SizedBox(width: 8),
// //               Text(
// //                 product.rating?.rate?.toStringAsFixed(1) ?? '0.0',
// //                 style: TextStyle(
// //                   fontWeight: FontWeight.bold,
// //                   fontSize: 14,
// //                   color: AppColors.textPrimary(context),
// //                 ),
// //               ),
// //               const SizedBox(width: 4),
// //               Text(
// //                 'reviews_count'.trParams({
// //                   'count': (product.rating?.count ?? 0).toString(),
// //                 }),
// //                 style: TextStyle(
// //                   color: AppColors.textSecondary(context),
// //                   fontSize: 14,
// //                 ),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: 16),
// //           Container(
// //             padding: const EdgeInsets.all(16),
// //             decoration: BoxDecoration(
// //               gradient: LinearGradient(
// //                 colors: [
// //                   AppColors.secondary.withOpacity(0.05),
// //                   AppColors.secondary.withOpacity(0.02),
// //                 ],
// //               ),
// //               borderRadius: BorderRadius.circular(16),
// //               border: Border.all(color: AppColors.secondary.withOpacity(0.1)),
// //             ),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Row(
// //                       children: [
// //                         Text(
// //                           'price'.tr,
// //                           style: TextStyle(
// //                             fontSize: 14,
// //                             color: AppColors.textSecondary(context),
// //                           ),
// //                         ),
// //                         if (hasDiscount) ...[
// //                           const SizedBox(width: 8),
// //                           Container(
// //                             padding: const EdgeInsets.symmetric(
// //                               horizontal: 8,
// //                               vertical: 2,
// //                             ),
// //                             decoration: BoxDecoration(
// //                               color: Colors.red.shade50,
// //                               borderRadius: BorderRadius.circular(8),
// //                             ),
// //                             child: Text(
// //                               '$percentOff% off',
// //                               style: TextStyle(
// //                                 fontSize: 11,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: Colors.red.shade700,
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ],
// //                     ),
// //                     const SizedBox(height: 4),
// //                     ValueListenableBuilder<String>(
// //                       valueListenable: CurrencyService.instance.symbol,
// //                       builder: (context, currency, _) {
// //                         if (!hasDiscount) {
// //                           return Text(
// //                             '$currency ${product.price?.toStringAsFixed(0) ?? '0'}',
// //                             style: const TextStyle(
// //                               fontSize: 28,
// //                               fontWeight: FontWeight.bold,
// //                               color: AppColors.secondary,
// //                             ),
// //                           );
// //                         }
// //                         return Row(
// //                           crossAxisAlignment: CrossAxisAlignment.baseline,
// //                           textBaseline: TextBaseline.alphabetic,
// //                           children: [
// //                             Text(
// //                               '$currency ${product.price?.toStringAsFixed(0) ?? '0'}',
// //                               style: TextStyle(
// //                                 fontSize: 15,
// //                                 color: AppColors.textSecondary(context),
// //                                 decoration: TextDecoration.lineThrough,
// //                               ),
// //                             ),
// //                             const SizedBox(width: 8),
// //                             Text(
// //                               '$currency ${product.discountPrice?.toStringAsFixed(0) ?? '0'}',
// //                               style: const TextStyle(
// //                                 fontSize: 28,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: AppColors.secondary,
// //                               ),
// //                             ),
// //                           ],
// //                         );
// //                       },
// //                     ),
// //                   ],
// //                 ),
// //                 Container(
// //                   padding: const EdgeInsets.symmetric(
// //                     horizontal: 12,
// //                     vertical: 6,
// //                   ),
// //                   decoration: BoxDecoration(
// //                     color: isDark
// //                         ? Colors.green.withOpacity(0.12)
// //                         : Colors.green.shade50,
// //                     borderRadius: BorderRadius.circular(20),
// //                     border: Border.all(
// //                       color: isDark
// //                           ? Colors.green.withOpacity(0.4)
// //                           : Colors.green.shade200,
// //                       width: 1,
// //                     ),
// //                   ),
// //                   child: Row(
// //                     children: [
// //                       const Icon(
// //                         Icons.check_circle,
// //                         color: Colors.green,
// //                         size: 16,
// //                       ),
// //                       const SizedBox(width: 4),
// //                       Text(
// //                         'in_stock'.tr,
// //                         style: const TextStyle(
// //                           color: Colors.green,
// //                           fontWeight: FontWeight.w600,
// //                           fontSize: 12,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           const SizedBox(height: 20),
// //
// //           // NAYA - bundle discount hint (agar product par tiers hain)
// //           if (product.priceTiers.isNotEmpty) ...[
// //             Container(
// //               width: double.infinity,
// //               padding: const EdgeInsets.all(12),
// //               decoration: BoxDecoration(
// //                 color: Colors.green.withOpacity(0.08),
// //                 borderRadius: BorderRadius.circular(12),
// //                 border: Border.all(color: Colors.green.withOpacity(0.3)),
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Row(
// //                     children: [
// //                       const Icon(
// //                         Icons.local_offer,
// //                         color: Colors.green,
// //                         size: 16,
// //                       ),
// //                       const SizedBox(width: 6),
// //                       Text(
// //                         'bundle_offer'.tr,
// //                         style: const TextStyle(
// //                           color: Colors.green,
// //                           fontWeight: FontWeight.w600,
// //                           fontSize: 13,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 6),
// //                   ValueListenableBuilder<String>(
// //                     valueListenable: CurrencyService.instance.symbol,
// //                     builder: (context, currency, _) {
// //                       return Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: product.priceTiers.map((t) {
// //                           return Padding(
// //                             padding: const EdgeInsets.only(top: 2),
// //                             child: Text(
// //                               'Buy ${t.minQty}+ → $currency ${t.price.toStringAsFixed(0)} each',
// //                               style: TextStyle(
// //                                 fontSize: 12,
// //                                 color: AppColors.textSecondary(context),
// //                               ),
// //                             ),
// //                           );
// //                         }).toList(),
// //                       );
// //                     },
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //           ],
// //
// //           Text(
// //             'description'.tr,
// //             style: TextStyle(
// //               fontSize: 18,
// //               fontWeight: FontWeight.w600,
// //               color: AppColors.textPrimary(context),
// //             ),
// //           ),
// //           const SizedBox(height: 8),
// //           Container(
// //             padding: const EdgeInsets.all(16),
// //             decoration: BoxDecoration(
// //               color: AppColors.cardBackground(context),
// //               borderRadius: BorderRadius.circular(16),
// //             ),
// //             child: Text(
// //               product.description ?? 'no_description'.tr,
// //               style: TextStyle(
// //                 fontSize: 15,
// //                 color: AppColors.textSecondary(context),
// //                 height: 1.6,
// //               ),
// //             ),
// //           ),
// //           const SizedBox(height: 20),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildQuantitySelector(
// //     ProductDetailController controller,
// //     BuildContext context,
// //   ) {
// //     final isDark = Theme.of(context).brightness == Brightness.dark;
// //     final chipColor = isDark
// //         ? Colors.white.withOpacity(0.08)
// //         : Colors.grey.shade100;
// //     final borderColor = isDark
// //         ? Colors.white.withOpacity(0.08)
// //         : Colors.grey.shade200;
// //
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 20),
// //       child: Container(
// //         padding: const EdgeInsets.all(16),
// //         decoration: BoxDecoration(
// //           color: AppColors.cardBackground(context),
// //           borderRadius: BorderRadius.circular(16),
// //           border: Border.all(color: borderColor, width: 1),
// //         ),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Row(
// //               children: [
// //                 Icon(
// //                   Icons.production_quantity_limits,
// //                   color: AppColors.textPrimary(context),
// //                 ),
// //                 const SizedBox(width: 8),
// //                 Text(
// //                   'quantity'.tr,
// //                   style: TextStyle(
// //                     fontSize: 16,
// //                     fontWeight: FontWeight.w600,
// //                     color: AppColors.textPrimary(context),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             Row(
// //               children: [
// //                 GestureDetector(
// //                   onTap: controller.decreaseQuantity,
// //                   child: Container(
// //                     padding: const EdgeInsets.all(8),
// //                     decoration: BoxDecoration(
// //                       color: chipColor,
// //                       borderRadius: BorderRadius.circular(12),
// //                     ),
// //                     child: Icon(
// //                       Icons.remove,
// //                       size: 20,
// //                       color: AppColors.textPrimary(context),
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 16),
// //                 Obx(
// //                   () => Text(
// //                     controller.quantity.value.toString(),
// //                     style: TextStyle(
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                       color: AppColors.textPrimary(context),
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 16),
// //                 GestureDetector(
// //                   onTap: controller.increaseQuantity,
// //                   child: Container(
// //                     padding: const EdgeInsets.all(8),
// //                     decoration: BoxDecoration(
// //                       gradient: LinearGradient(
// //                         colors: [
// //                           AppColors.secondary,
// //                           AppColors.secondary.withOpacity(0.7),
// //                         ],
// //                       ),
// //                       borderRadius: BorderRadius.circular(12),
// //                     ),
// //                     child: const Icon(Icons.add, size: 20, color: Colors.white),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildActionButtons(
// //     ProductDetailController controller,
// //     BuildContext context,
// //   ) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
// //       child: Row(
// //         children: [
// //           Expanded(
// //             child: Obx(
// //               () => ElevatedButton.icon(
// //                 onPressed: controller.isAddedToCart.value
// //                     ? null
// //                     : controller.addToCart,
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: controller.isAddedToCart.value
// //                       ? Colors.green
// //                       : AppColors.secondary,
// //                   foregroundColor: Colors.white,
// //                   padding: const EdgeInsets.symmetric(vertical: 14),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(16),
// //                   ),
// //                   elevation: 0,
// //                   disabledBackgroundColor: Colors.green.withOpacity(0.7),
// //                 ),
// //                 icon: Icon(
// //                   controller.isAddedToCart.value
// //                       ? Icons.check_circle_rounded
// //                       : Icons.add_shopping_cart_rounded,
// //                   size: 20,
// //                 ),
// //                 label: Text(
// //                   controller.isAddedToCart.value
// //                       ? 'added'.tr
// //                       : 'add_to_cart'.tr,
// //                   style: const TextStyle(
// //                     fontSize: 15,
// //                     fontWeight: FontWeight.w600,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //           const SizedBox(width: 12),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildAdditionalInfo(BuildContext context) {
// //     final isDark = Theme.of(context).brightness == Brightness.dark;
// //     final borderColor = isDark
// //         ? Colors.white.withOpacity(0.08)
// //         : Colors.grey.shade200;
// //
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 20),
// //       child: Column(
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.all(16),
// //             decoration: BoxDecoration(
// //               color: AppColors.cardBackground(context),
// //               borderRadius: BorderRadius.circular(16),
// //               border: Border.all(color: borderColor, width: 1),
// //             ),
// //             child: Column(
// //               children: [
// //                 _buildInfoRow(
// //                   Icons.local_shipping,
// //                   'free_delivery'.tr,
// //                   'free_delivery_sub'.tr,
// //                   context,
// //                 ),
// //                 Divider(height: 20, color: borderColor),
// //                 _buildInfoRow(
// //                   Icons.verified,
// //                   'secure_payment'.tr,
// //                   'secure_payment_sub'.tr,
// //                   context,
// //                 ),
// //                 Divider(height: 20, color: borderColor),
// //                 _buildInfoRow(
// //                   Icons.thumb_up,
// //                   'easy_returns'.tr,
// //                   'easy_returns_sub'.tr,
// //                   context,
// //                 ),
// //               ],
// //             ),
// //           ),
// //           const SizedBox(height: 20),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildInfoRow(
// //     IconData icon,
// //     String title,
// //     String subtitle,
// //     BuildContext context,
// //   ) {
// //     return Row(
// //       children: [
// //         Container(
// //           padding: const EdgeInsets.all(8),
// //           decoration: BoxDecoration(
// //             color: AppColors.secondary.withOpacity(0.05),
// //             borderRadius: BorderRadius.circular(10),
// //           ),
// //           child: Icon(icon, color: AppColors.secondary, size: 20),
// //         ),
// //         const SizedBox(width: 12),
// //         Expanded(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 title,
// //                 style: TextStyle(
// //                   fontWeight: FontWeight.w600,
// //                   fontSize: 14,
// //                   color: AppColors.textPrimary(context),
// //                 ),
// //               ),
// //               Text(
// //                 subtitle,
// //                 style: TextStyle(
// //                   color: AppColors.textSecondary(context),
// //                   fontSize: 12,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildBottomBar(
// //     ProductDetailController controller,
// //     BuildContext context,
// //   ) {
// //     final isDark = Theme.of(context).brightness == Brightness.dark;
// //     final chipColor = isDark
// //         ? Colors.white.withOpacity(0.08)
// //         : Colors.grey.shade100;
// //
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// //       decoration: BoxDecoration(
// //         color: AppColors.cardBackground(context),
// //         boxShadow: [
// //           BoxShadow(
// //             color: isDark
// //                 ? Colors.black.withOpacity(0.35)
// //                 : Colors.grey.shade200,
// //             blurRadius: 20,
// //             offset: const Offset(0, -4),
// //           ),
// //         ],
// //       ),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Text(
// //                 'total_price'.tr,
// //                 style: TextStyle(
// //                   fontSize: 12,
// //                   color: AppColors.textSecondary(context),
// //                 ),
// //               ),
// //               ValueListenableBuilder<String>(
// //                 valueListenable: CurrencyService.instance.symbol,
// //                 builder: (context, currency, _) {
// //                   return Obx(() {
// //                     // CHANGE - ab discountPrice ki jagah tier price use hoga
// //                     final effectivePrice = controller.getUnitPrice();
// //                     return Text(
// //                       '$currency ${(effectivePrice * controller.quantity.value).toStringAsFixed(0)}',
// //                       style: const TextStyle(
// //                         fontSize: 20,
// //                         fontWeight: FontWeight.bold,
// //                         color: AppColors.secondary,
// //                       ),
// //                     );
// //                   });
// //                 },
// //               ),
// //             ],
// //           ),
// //           Row(
// //             children: [
// //               Stack(
// //                 children: [
// //                   Container(
// //                     padding: const EdgeInsets.all(10),
// //                     decoration: BoxDecoration(
// //                       color: chipColor,
// //                       borderRadius: BorderRadius.circular(12),
// //                     ),
// //                     child: Icon(
// //                       Icons.shopping_cart_outlined,
// //                       color: AppColors.textPrimary(context),
// //                     ),
// //                   ),
// //                   Positioned(
// //                     right: -2,
// //                     top: -2,
// //                     child: Obx(
// //                       () => Container(
// //                         padding: const EdgeInsets.all(4),
// //                         decoration: BoxDecoration(
// //                           color: AppColors.secondary,
// //                           shape: BoxShape.circle,
// //                         ),
// //                         child: Text(
// //                           controller.quantity.value.toString(),
// //                           style: const TextStyle(
// //                             color: Colors.white,
// //                             fontSize: 10,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import '../../Utilities_Screens/App_Model/app_model.dart';
// import '../../Utilities_Screens/Currency_Service/currency_service.dart';
// import '../Wishlist_Screen/wishlist_controller.dart';
// import 'detail_controller.dart';
//
// class ProductDetailView extends StatelessWidget {
//   const ProductDetailView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final product = Get.arguments as ModelClass?;
//     final controller = Get.put(ProductDetailController());
//
//     if (product != null) {
//       controller.product.value = product;
//     }
//
//     if (product == null) {
//       return Scaffold(
//         backgroundColor: AppColors.background(context),
//         appBar: AppBar(
//           backgroundColor: AppColors.cardBackground(context),
//           elevation: 0,
//           leading: IconButton(
//             onPressed: () => Get.back(),
//             icon: Icon(Icons.arrow_back, color: AppColors.textPrimary(context)),
//           ),
//           title: Text(
//             'product_not_found'.tr,
//             style: TextStyle(color: AppColors.textPrimary(context)),
//           ),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.error_outline,
//                 size: 64,
//                 color: AppColors.textSecondary(context),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'product_not_found'.tr,
//                 style: TextStyle(color: AppColors.textSecondary(context)),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
//     return Scaffold(
//       backgroundColor: AppColors.background(context),
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildAppBar(controller, context),
//             Expanded(
//               // CHANGE - Obx yahan wrap kiya gaya taake "You May Also Like"
//               // se product select karne par pura content reactively update ho,
//               // bina naye route push kiye (Daraz jaisa in-place switch)
//               child: Obx(() {
//                 final currentProduct = controller.product.value;
//
//                 if (currentProduct == null) {
//                   return const SizedBox.shrink();
//                 }
//
//                 return SingleChildScrollView(
//                   key: ValueKey(currentProduct.id),
//                   physics: const BouncingScrollPhysics(),
//                   padding: const EdgeInsets.only(bottom: 80),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildProductImage(currentProduct, context),
//                       _buildProductDetails(controller, currentProduct, context),
//                       _buildQuantitySelector(controller, context),
//                       _buildActionButtons(controller, context),
//                       _buildAdditionalInfo(context),
//                       _buildRelatedProducts(controller, context), // NAYA
//                     ],
//                   ),
//                 );
//               }),
//             ),
//             _buildBottomBar(controller, context),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAppBar(
//     ProductDetailController controller,
//     BuildContext context,
//   ) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final chipColor = isDark
//         ? Colors.white.withOpacity(0.08)
//         : Colors.grey.shade100;
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       color: AppColors.cardBackground(context),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           GestureDetector(
//             onTap: () => Get.back(),
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: chipColor,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(
//                 Icons.arrow_back,
//                 size: 22,
//                 color: AppColors.textPrimary(context),
//               ),
//             ),
//           ),
//           Text(
//             'product_details'.tr,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: AppColors.textPrimary(context),
//             ),
//           ),
//           Obx(() {
//             final wishlisted = WishlistController.instance.isWishlisted(
//               controller.product.value?.id,
//             );
//             return GestureDetector(
//               onTap: controller.toggleWishlist,
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: wishlisted
//                       ? AppColors.secondary.withOpacity(0.1)
//                       : chipColor,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(
//                   wishlisted
//                       ? Icons.favorite_rounded
//                       : Icons.favorite_border_rounded,
//                   color: wishlisted
//                       ? AppColors.secondary
//                       : AppColors.textSecondary(context),
//                   size: 22,
//                 ),
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProductImage(ModelClass product, BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Container(
//       margin: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.cardBackground(context),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: isDark
//                 ? Colors.black.withOpacity(0.35)
//                 : Colors.grey.shade200,
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Container(
//               height: 300,
//               width: double.infinity,
//               color: isDark
//                   ? Colors.white.withOpacity(0.04)
//                   : Colors.grey.shade50,
//               child: Image.network(
//                 product.image ?? '',
//                 fit: BoxFit.contain,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.broken_image,
//                           size: 80,
//                           color: isDark
//                               ? Colors.grey.shade700
//                               : Colors.grey.shade300,
//                         ),
//                         Text(
//                           'no_description'.tr,
//                           style: TextStyle(
//                             color: AppColors.textSecondary(context),
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 loadingBuilder: (context, child, loadingProgress) {
//                   if (loadingProgress == null) return child;
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           width: 40,
//                           height: 40,
//                           child: CircularProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation<Color>(
//                               AppColors.secondary,
//                             ),
//                             strokeWidth: 3,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           Positioned(
//             top: 16,
//             left: 16,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.secondary,
//                     AppColors.secondary.withOpacity(0.7),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 product.category ?? 'Category',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 0.5,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProductDetails(
//     ProductDetailController controller,
//     ModelClass product,
//     BuildContext context,
//   ) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     final hasDiscount =
//         product.discountPrice != null && product.discountPrice! > 0;
//     final percentOff = hasDiscount && (product.price ?? 0) > 0
//         ? (((product.price! - product.discountPrice!) / product.price!) * 100)
//               .round()
//         : 0;
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 8),
//           Text(
//             product.title ?? 'Product',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               height: 1.3,
//               color: AppColors.textPrimary(context),
//             ),
//           ),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               Row(
//                 children: List.generate(5, (index) {
//                   final rating = product.rating?.rate ?? 0;
//                   if (index < rating.floor()) {
//                     return const Icon(
//                       Icons.star_rounded,
//                       color: Colors.amber,
//                       size: 20,
//                     );
//                   } else if (index < rating.ceil() && rating % 1 != 0) {
//                     return const Icon(
//                       Icons.star_half_rounded,
//                       color: Colors.amber,
//                       size: 20,
//                     );
//                   } else {
//                     return Icon(
//                       Icons.star_border_rounded,
//                       color: isDark
//                           ? Colors.grey.shade700
//                           : Colors.grey.shade300,
//                       size: 20,
//                     );
//                   }
//                 }),
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 product.rating?.rate?.toStringAsFixed(1) ?? '0.0',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 14,
//                   color: AppColors.textPrimary(context),
//                 ),
//               ),
//               const SizedBox(width: 4),
//               Text(
//                 'reviews_count'.trParams({
//                   'count': (product.rating?.count ?? 0).toString(),
//                 }),
//                 style: TextStyle(
//                   color: AppColors.textSecondary(context),
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   AppColors.secondary.withOpacity(0.05),
//                   AppColors.secondary.withOpacity(0.02),
//                 ],
//               ),
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: AppColors.secondary.withOpacity(0.1)),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           'price'.tr,
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: AppColors.textSecondary(context),
//                           ),
//                         ),
//                         if (hasDiscount) ...[
//                           const SizedBox(width: 8),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 2,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.red.shade50,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               '$percentOff% off',
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.red.shade700,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                     const SizedBox(height: 4),
//                     ValueListenableBuilder<String>(
//                       valueListenable: CurrencyService.instance.symbol,
//                       builder: (context, currency, _) {
//                         if (!hasDiscount) {
//                           return Text(
//                             '$currency ${product.price?.toStringAsFixed(0) ?? '0'}',
//                             style: const TextStyle(
//                               fontSize: 28,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.secondary,
//                             ),
//                           );
//                         }
//                         return Row(
//                           crossAxisAlignment: CrossAxisAlignment.baseline,
//                           textBaseline: TextBaseline.alphabetic,
//                           children: [
//                             Text(
//                               '$currency ${product.price?.toStringAsFixed(0) ?? '0'}',
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 color: AppColors.textSecondary(context),
//                                 decoration: TextDecoration.lineThrough,
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             Text(
//                               '$currency ${product.discountPrice?.toStringAsFixed(0) ?? '0'}',
//                               style: const TextStyle(
//                                 fontSize: 28,
//                                 fontWeight: FontWeight.bold,
//                                 color: AppColors.secondary,
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 6,
//                   ),
//                   decoration: BoxDecoration(
//                     color: isDark
//                         ? Colors.green.withOpacity(0.12)
//                         : Colors.green.shade50,
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(
//                       color: isDark
//                           ? Colors.green.withOpacity(0.4)
//                           : Colors.green.shade200,
//                       width: 1,
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.check_circle,
//                         color: Colors.green,
//                         size: 16,
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         'in_stock'.tr,
//                         style: const TextStyle(
//                           color: Colors.green,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),
//
//           if (product.priceTiers.isNotEmpty) ...[
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.green.withOpacity(0.08),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.green.withOpacity(0.3)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.local_offer,
//                         color: Colors.green,
//                         size: 16,
//                       ),
//                       const SizedBox(width: 6),
//                       Text(
//                         'bundle_offer'.tr,
//                         style: const TextStyle(
//                           color: Colors.green,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 13,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   ValueListenableBuilder<String>(
//                     valueListenable: CurrencyService.instance.symbol,
//                     builder: (context, currency, _) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: product.priceTiers.map((t) {
//                           return Padding(
//                             padding: const EdgeInsets.only(top: 2),
//                             child: Text(
//                               'Buy ${t.minQty}+ → $currency ${t.price.toStringAsFixed(0)} each',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: AppColors.textSecondary(context),
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//
//           Text(
//             'description'.tr,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: AppColors.textPrimary(context),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: AppColors.cardBackground(context),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Text(
//               product.description ?? 'no_description'.tr,
//               style: TextStyle(
//                 fontSize: 15,
//                 color: AppColors.textSecondary(context),
//                 height: 1.6,
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildQuantitySelector(
//     ProductDetailController controller,
//     BuildContext context,
//   ) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final chipColor = isDark
//         ? Colors.white.withOpacity(0.08)
//         : Colors.grey.shade100;
//     final borderColor = isDark
//         ? Colors.white.withOpacity(0.08)
//         : Colors.grey.shade200;
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: AppColors.cardBackground(context),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: borderColor, width: 1),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Icon(
//                   Icons.production_quantity_limits,
//                   color: AppColors.textPrimary(context),
//                 ),
//                 const SizedBox(width: 8),
//                 Text(
//                   'quantity'.tr,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimary(context),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 GestureDetector(
//                   onTap: controller.decreaseQuantity,
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: chipColor,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Icon(
//                       Icons.remove,
//                       size: 20,
//                       color: AppColors.textPrimary(context),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Obx(
//                   () => Text(
//                     controller.quantity.value.toString(),
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.textPrimary(context),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 GestureDetector(
//                   onTap: controller.increaseQuantity,
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           AppColors.secondary,
//                           AppColors.secondary.withOpacity(0.7),
//                         ],
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(Icons.add, size: 20, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildActionButtons(
//     ProductDetailController controller,
//     BuildContext context,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       child: Row(
//         children: [
//           Expanded(
//             child: Obx(
//               () => ElevatedButton.icon(
//                 onPressed: controller.isAddedToCart.value
//                     ? null
//                     : controller.addToCart,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: controller.isAddedToCart.value
//                       ? Colors.green
//                       : AppColors.secondary,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   elevation: 0,
//                   disabledBackgroundColor: Colors.green.withOpacity(0.7),
//                 ),
//                 icon: Icon(
//                   controller.isAddedToCart.value
//                       ? Icons.check_circle_rounded
//                       : Icons.add_shopping_cart_rounded,
//                   size: 20,
//                 ),
//                 label: Text(
//                   controller.isAddedToCart.value
//                       ? 'added'.tr
//                       : 'add_to_cart'.tr,
//                   style: const TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAdditionalInfo(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final borderColor = isDark
//         ? Colors.white.withOpacity(0.08)
//         : Colors.grey.shade200;
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: AppColors.cardBackground(context),
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: borderColor, width: 1),
//             ),
//             child: Column(
//               children: [
//                 _buildInfoRow(
//                   Icons.local_shipping,
//                   'free_delivery'.tr,
//                   'free_delivery_sub'.tr,
//                   context,
//                 ),
//                 Divider(height: 20, color: borderColor),
//                 _buildInfoRow(
//                   Icons.verified,
//                   'secure_payment'.tr,
//                   'secure_payment_sub'.tr,
//                   context,
//                 ),
//                 Divider(height: 20, color: borderColor),
//                 _buildInfoRow(
//                   Icons.thumb_up,
//                   'easy_returns'.tr,
//                   'easy_returns_sub'.tr,
//                   context,
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(
//     IconData icon,
//     String title,
//     String subtitle,
//     BuildContext context,
//   ) {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: AppColors.secondary.withOpacity(0.05),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(icon, color: AppColors.secondary, size: 20),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14,
//                   color: AppColors.textPrimary(context),
//                 ),
//               ),
//               Text(
//                 subtitle,
//                 style: TextStyle(
//                   color: AppColors.textSecondary(context),
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ============================================================
//   // YOU MAY ALSO LIKE (Daraz style) — NAYA SECTION
//   // ============================================================
//   Widget _buildRelatedProducts(
//     ProductDetailController controller,
//     BuildContext context,
//   ) {
//     return Obx(() {
//       if (controller.isRelatedLoading.value) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//           child: SizedBox(
//             height: 210,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: 4,
//               itemBuilder: (context, index) => Container(
//                 width: 140,
//                 margin: const EdgeInsets.only(right: 12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade200,
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }
//
//       if (controller.relatedProducts.isEmpty) {
//         return const SizedBox.shrink();
//       }
//
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.grid_view_rounded,
//                   size: 18,
//                   color: AppColors.secondary,
//                 ),
//                 const SizedBox(width: 6),
//                 Text(
//                   'you may also like'.tr,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                     color: AppColors.textPrimary(context),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 220,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               itemCount: controller.relatedProducts.length,
//               itemBuilder: (context, index) {
//                 final item = controller.relatedProducts[index];
//                 return _buildRelatedCard(item, controller, context);
//               },
//             ),
//           ),
//           const SizedBox(height: 12),
//         ],
//       );
//     });
//   }
//
//   Widget _buildRelatedCard(
//     ModelClass item,
//     ProductDetailController controller,
//     BuildContext context,
//   ) {
//     final hasDiscount = item.discountPrice != null && item.discountPrice! > 0;
//
//     final percentOff = hasDiscount && (item.price ?? 0) > 0
//         ? (((item.price! - item.discountPrice!) / item.price!) * 100).round()
//         : 0;
//
//     return GestureDetector(
//       onTap: () {
//         // Daraz jaisa behavior — same page pe naya product load ho jata hai,
//         // bina navigation stack barhaye. Page top pe scroll wapas nahi hota
//         // isliye upar scroll karna user khud kar sakta hai ya hum ScrollController
//         // add kar ke automatic bhi kar sakte hain, filhal simple rakha hai.
//         controller.switchToRelatedProduct(item);
//       },
//       child: Container(
//         width: 140,
//         margin: const EdgeInsets.only(right: 12),
//         decoration: BoxDecoration(
//           color: AppColors.cardBackground(context),
//           borderRadius: BorderRadius.circular(14),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 8,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(14),
//                 ),
//                 child: Stack(
//                   fit: StackFit.expand,
//                   children: [
//                     Container(
//                       color: Colors.white,
//                       child: Image.network(
//                         item.image ?? '',
//                         fit: BoxFit.contain,
//                         errorBuilder: (_, __, ___) => Icon(
//                           Icons.image_not_supported_outlined,
//                           color: Colors.grey.shade300,
//                         ),
//                       ),
//                     ),
//                     if (hasDiscount)
//                       Positioned(
//                         left: 0,
//                         top: 8,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 7,
//                             vertical: 4,
//                           ),
//                           decoration: const BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [Color(0xFFFF3B30), Color(0xFFFF1744)],
//                             ),
//                             borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(6),
//                               bottomRight: Radius.circular(6),
//                             ),
//                           ),
//                           child: Text(
//                             '-$percentOff%',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 10,
//                               fontWeight: FontWeight.w900,
//                             ),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     item.title ?? '',
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimary(context),
//                       height: 1.2,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   ValueListenableBuilder<String>(
//                     valueListenable: CurrencyService.instance.symbol,
//                     builder: (context, currency, _) {
//                       final price = hasDiscount
//                           ? item.discountPrice
//                           : item.price;
//                       return Text(
//                         '$currency ${price?.toStringAsFixed(0) ?? '0'}',
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w800,
//                           color: AppColors.secondary,
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBottomBar(
//     ProductDetailController controller,
//     BuildContext context,
//   ) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final chipColor = isDark
//         ? Colors.white.withOpacity(0.08)
//         : Colors.grey.shade100;
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//       decoration: BoxDecoration(
//         color: AppColors.cardBackground(context),
//         boxShadow: [
//           BoxShadow(
//             color: isDark
//                 ? Colors.black.withOpacity(0.35)
//                 : Colors.grey.shade200,
//             blurRadius: 20,
//             offset: const Offset(0, -4),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'total_price'.tr,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: AppColors.textSecondary(context),
//                 ),
//               ),
//               ValueListenableBuilder<String>(
//                 valueListenable: CurrencyService.instance.symbol,
//                 builder: (context, currency, _) {
//                   return Obx(() {
//                     final effectivePrice = controller.getUnitPrice();
//                     return Text(
//                       '$currency ${(effectivePrice * controller.quantity.value).toStringAsFixed(0)}',
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.secondary,
//                       ),
//                     );
//                   });
//                 },
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: chipColor,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Icon(
//                       Icons.shopping_cart_outlined,
//                       color: AppColors.textPrimary(context),
//                     ),
//                   ),
//                   Positioned(
//                     right: -2,
//                     top: -2,
//                     child: Obx(
//                       () => Container(
//                         padding: const EdgeInsets.all(4),
//                         decoration: BoxDecoration(
//                           color: AppColors.secondary,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Text(
//                           controller.quantity.value.toString(),
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 10,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utilities_Screens/App_Model/app_model.dart';
import 'detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // Agar controller route binding se registered nahi hai
    // to ye line automatically controller provide karegi.

    Get.put(ProductDetailController());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.white,

        foregroundColor: Colors.black,

        elevation: 0,

        title: const Text(
          'Product Details',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),

        actions: [
          Obx(
            () => IconButton(
              onPressed: controller.toggleWishlist,

              icon: Icon(
                controller.isWishlisted
                    ? Icons.favorite
                    : Icons.favorite_border,

                color: controller.isWishlisted ? Colors.red : Colors.black,
              ),
            ),
          ),
        ],
      ),

      body: Obx(() {
        final product = controller.product.value;

        if (product == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _imageSection(product),

                  _productInfo(product),

                  _sizeSection(product),

                  _quantitySection(product),

                  _descriptionSection(product),

                  _relatedSection(),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        );
      }),

      bottomNavigationBar: _bottomButtons(),
    );
  }

  // =====================================================
  // IMAGE SECTION
  // =====================================================

  Widget _imageSection(ModelClass product) {
    return Container(
      color: Colors.white,

      child: Column(
        children: [
          SizedBox(
            height: 330,

            child: PageView.builder(
              itemCount: controller.dummyImages.isEmpty
                  ? 1
                  : controller.dummyImages.length,

              onPageChanged: controller.changeImage,

              itemBuilder: (context, index) {
                final image = controller.dummyImages.isEmpty
                    ? product.image
                    : controller.dummyImages[index];

                if (image == null || image.isEmpty) {
                  return const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 80,
                      color: Colors.grey,
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(20),

                  child: Image.network(
                    image,

                    fit: BoxFit.contain,

                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 70,
                          color: Colors.grey,
                        ),
                      );
                    },

                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }

                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                );
              },
            ),
          ),

          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: List.generate(controller.dummyImages.length, (index) {
                final selected = controller.currentImageIndex.value == index;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),

                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 10,
                  ),

                  height: 7,

                  width: selected ? 22 : 7,

                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFFE94560)
                        : Colors.grey.shade400,

                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // PRODUCT INFO
  // =====================================================

  Widget _productInfo(ModelClass product) {
    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(top: 8),

      padding: const EdgeInsets.all(16),

      color: Colors.white,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            product.title ?? 'No Title',

            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 10),

          // Rating
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),

                decoration: BoxDecoration(
                  color: Colors.green.shade600,

                  borderRadius: BorderRadius.circular(5),
                ),

                child: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Text(
                      '${product.rating?.rate?.toStringAsFixed(1) ?? '0.0'}',

                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(width: 3),

                    const Icon(Icons.star, size: 13, color: Colors.white),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Text(
                '${product.rating?.count ?? 0} Ratings',

                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // PRICE
          Obx(() {
            final currentPrice = controller.getUnitPrice();

            final oldPrice = controller.oldPrice;

            final discount = controller.discountPercentage;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,

              children: [
                Text(
                  'Rs. ${currentPrice.toStringAsFixed(0)}',

                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFE94560),
                  ),
                ),

                const SizedBox(width: 8),

                if (oldPrice > currentPrice)
                  Text(
                    'Rs. ${oldPrice.toStringAsFixed(0)}',

                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade500,

                      decoration: TextDecoration.lineThrough,
                    ),
                  ),

                const SizedBox(width: 7),

                if (discount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.red.shade50,

                      borderRadius: BorderRadius.circular(3),
                    ),

                    child: Text(
                      '$discount% OFF',

                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ),
              ],
            );
          }),

          const SizedBox(height: 6),

          Text(
            'Inclusive of all taxes',

            style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // SIZE SECTION
  // =====================================================

  Widget _sizeSection(ModelClass product) {
    if (product.sizes.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(top: 8),

      padding: const EdgeInsets.all(16),

      color: Colors.white,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              const Text(
                'Select Size',

                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),

              Obx(() {
                final size = controller.selectedSize.value;

                if (size == null) {
                  return const SizedBox();
                }

                return Text(
                  'Selected: ${size.label}',

                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFE94560),
                    fontWeight: FontWeight.w600,
                  ),
                );
              }),
            ],
          ),

          const SizedBox(height: 14),

          Wrap(
            spacing: 10,

            runSpacing: 10,

            children: product.sizes.map((size) {
              return Obx(() {
                final isSelected = controller.selectedSize.value == size;

                final isOutOfStock = size.stock <= 0;

                return GestureDetector(
                  onTap: isOutOfStock
                      ? null
                      : () => controller.selectSize(size),

                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),

                    width: 82,

                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),

                    decoration: BoxDecoration(
                      color: isOutOfStock
                          ? Colors.grey.shade100
                          : isSelected
                          ? const Color(0xFFFFF0F3)
                          : Colors.white,

                      border: Border.all(
                        color: isOutOfStock
                            ? Colors.grey.shade300
                            : isSelected
                            ? const Color(0xFFE94560)
                            : Colors.grey.shade400,

                        width: isSelected ? 2 : 1,
                      ),

                      borderRadius: BorderRadius.circular(8),
                    ),

                    child: Column(
                      children: [
                        Text(
                          size.label,

                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,

                            color: isOutOfStock
                                ? Colors.grey
                                : isSelected
                                ? const Color(0xFFE94560)
                                : Colors.black,
                          ),
                        ),

                        const SizedBox(height: 4),

                        // SMALL PRICE
                        Text(
                          size.price > 0
                              ? 'Rs. ${size.price.toStringAsFixed(0)}'
                              : 'Rs. ${controller.basePrice.toStringAsFixed(0)}',

                          style: TextStyle(
                            fontSize: 11,

                            fontWeight: FontWeight.w500,

                            color: isOutOfStock
                                ? Colors.grey
                                : Colors.grey.shade700,
                          ),
                        ),

                        const SizedBox(height: 3),

                        Text(
                          isOutOfStock ? 'Out of stock' : '${size.stock} left',

                          style: TextStyle(
                            fontSize: 9,

                            color: isOutOfStock
                                ? Colors.red
                                : Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            }).toList(),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // QUANTITY
  // =====================================================

  Widget _quantitySection(ModelClass product) {
    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(top: 8),

      padding: const EdgeInsets.all(16),

      color: Colors.white,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          const Text(
            'Quantity',

            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),

          Obx(
            () => Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),

                borderRadius: BorderRadius.circular(7),
              ),

              child: Row(
                children: [
                  IconButton(
                    onPressed: controller.decreaseQuantity,

                    icon: const Icon(Icons.remove, size: 18),
                  ),

                  Text(
                    '${controller.quantity.value}',

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  IconButton(
                    onPressed: controller.increaseQuantity,

                    icon: const Icon(Icons.add, size: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // DESCRIPTION
  // =====================================================

  Widget _descriptionSection(ModelClass product) {
    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(top: 8),

      padding: const EdgeInsets.all(16),

      color: Colors.white,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            'Product Details',

            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 10),

          Text(
            product.description ?? 'No description available.',

            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // RELATED PRODUCTS
  // =====================================================

  Widget _relatedSection() {
    return Obx(() {
      if (controller.isRelatedLoading.value) {
        return Container(
          padding: const EdgeInsets.all(25),

          child: const Center(child: CircularProgressIndicator()),
        );
      }

      if (controller.relatedProducts.isEmpty) {
        return const SizedBox.shrink();
      }

      return Container(
        width: double.infinity,

        margin: const EdgeInsets.only(top: 8),

        padding: const EdgeInsets.all(16),

        color: Colors.white,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'You May Also Like',

              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 14),

            SizedBox(
              height: 255,

              child: ListView.builder(
                scrollDirection: Axis.horizontal,

                itemCount: controller.relatedProducts.length,

                itemBuilder: (context, index) {
                  final item = controller.relatedProducts[index];

                  return GestureDetector(
                    onTap: () => controller.switchToRelatedProduct(item),

                    child: Container(
                      width: 150,

                      margin: const EdgeInsets.only(right: 12),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        border: Border.all(color: Colors.grey.shade200),

                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),

                            child: SizedBox(
                              height: 145,

                              width: double.infinity,

                              child: Image.network(
                                item.image ?? '',

                                fit: BoxFit.cover,

                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.image, size: 50);
                                },
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(9),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  item.title ?? 'Product',

                                  maxLines: 2,

                                  overflow: TextOverflow.ellipsis,

                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  'Rs. ${(item.discountPrice != null && item.discountPrice! > 0 ? item.discountPrice! : item.price ?? 0).toStringAsFixed(0)}',

                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFE94560),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  // =====================================================
  // BOTTOM BUTTONS
  // =====================================================

  Widget _bottomButtons() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),

      decoration: BoxDecoration(
        color: Colors.white,

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),

            blurRadius: 10,

            offset: const Offset(0, -2),
          ),
        ],
      ),

      child: SafeArea(
        child: Row(
          children: [
            // -----------------------------------------
            // CART
            // -----------------------------------------
            Expanded(
              child: OutlinedButton(
                onPressed: controller.addToCart,

                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 50),

                  side: const BorderSide(color: Color(0xFFE94560)),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Icon(
                        controller.isAddedToCart.value
                            ? Icons.check
                            : Icons.shopping_cart,

                        color: const Color(0xFFE94560),
                      ),

                      const SizedBox(width: 6),

                      Text(
                        controller.isAddedToCart.value
                            ? 'Added'
                            : 'Add to Cart',

                        style: const TextStyle(
                          color: Color(0xFFE94560),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            // -----------------------------------------
            // BUY NOW
            // -----------------------------------------
            Expanded(
              child: ElevatedButton(
                onPressed: controller.buyNow,

                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(0, 50),

                  backgroundColor: const Color(0xFFE94560),

                  foregroundColor: Colors.white,

                  elevation: 0,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                child: const Text(
                  'Buy Now',

                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
