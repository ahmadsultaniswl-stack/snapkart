// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:snapkart/App_Routes/routes_view.dart';
//
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import '../../Utilities_Screens/App_Model/app_model.dart';
// import '../../Utilities_Screens/Currency_Service/currency_service.dart';
// import '../../Utilities_Screens/Wave_Skelton_Box/wave_skelton_box.dart';
// import '../Cart_Screen/cart_controller.dart';
// import '../Recently_Viewed/recently_view_controller.dart';
// import '../Wishlist_Screen/wishlist_controller.dart';
// import 'home_controller.dart';
//
// class HomeView extends StatelessWidget {
//   const HomeView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final HomeController controller = Get.put(HomeController());
//     return Scaffold(
//       backgroundColor: AppColors.background(context),
//       drawer: _buildDrawer(controller, context),
//       appBar: _buildAppBar(controller, context),
//       body: Column(
//         children: [
//           _buildPromoBanner(controller, context),
//
//           _buildCategoryChips(controller, context),
//
//           _buildRecentlyViewed(context),
//
//           Expanded(
//             child: Obx(() {
//               // if (controller.isLoading.value)
//               //   return _buildLoadingState(context);
//               if (controller.isLoading.value) return _buildSkeletonGrid();
//               if (controller.isError.value)
//                 return _buildErrorState(controller, context);
//               if (controller.filteredProductList.isEmpty)
//                 return _buildEmptyState(controller, context);
//               return _buildProductGrid(controller, context);
//             }),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDrawer(HomeController controller, BuildContext context) {
//     return Drawer(
//       backgroundColor: AppColors.cardBackground(context),
//       child: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Obx(
//             //   () => Container(
//             //     height: 220,
//             //     decoration: BoxDecoration(
//             //       image: DecorationImage(
//             //         image: NetworkImage(
//             //           controller.shoppingImages[controller.imageIndex.value],
//             //         ),
//             //         fit: BoxFit.cover,
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             Obx(
//               () => SizedBox(
//                 height: 220,
//                 width: double.infinity,
//                 child: Image.network(
//                   controller.shoppingImages[controller.imageIndex.value],
//                   fit: BoxFit.cover,
//
//                   // loadingBuilder: (context, child, loadingProgress) {
//                   //   if (loadingProgress == null) return child;
//                   //   return Shimmer.fromColors(
//                   //     baseColor: Colors.grey.shade300,
//                   //     highlightColor: Colors.grey.shade100,
//                   //     child: Container(
//                   //       color: Colors.white,
//                   //       height: 220,
//                   //       width: double.infinity,
//                   //     ),
//                   //   );
//                   // },
//                   loadingBuilder: (context, child, loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return WaveSkeletonBox(
//                       height: 220,
//                       borderRadius: BorderRadius.zero,
//                     );
//                   },
//
//                   errorBuilder: (context, error, stackTrace) => Container(
//                     height: 220,
//                     width: double.infinity,
//                     color: Colors.grey.shade300,
//                     child: const Icon(Icons.image_not_supported, size: 40),
//                   ),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 8),
//
//             Obx(() {
//               final count = WishlistController.instance.wishlistCount;
//               return _buildDrawerItem(
//                 icon: Icons.favorite_rounded,
//                 title: 'my_wishlist'.tr,
//                 badge: count > 0 ? '$count' : null,
//                 color: Colors.pink,
//                 onTap: () {
//                   Get.back();
//                   Get.toNamed(AppRoutes.wishlist);
//                 },
//               );
//             }),
//
//             _buildDrawerItem(
//               icon: Icons.shopping_cart_outlined,
//               title: 'my_cart'.tr,
//               badge: null,
//               color: Colors.deepOrange,
//               onTap: () {
//                 Get.back();
//                 Get.toNamed(AppRoutes.cart);
//               },
//             ),
//
//             _buildDrawerItem(
//               icon: Icons.shopping_bag,
//               title: 'order_checkout'.tr,
//               badge: null,
//               color: Colors.deepOrange,
//               onTap: () {
//                 Get.back();
//                 Get.toNamed(AppRoutes.checkout);
//               },
//             ),
//
//             _buildDrawerItem(
//               icon: Icons.work_history_outlined,
//               title: 'order_history'.tr,
//               badge: null,
//               color: Colors.deepOrange,
//               onTap: () {
//                 Get.back();
//                 Get.toNamed(AppRoutes.history);
//               },
//             ),
//
//             _buildDrawerItem(
//               icon: Icons.settings,
//               title: 'settings'.tr,
//               badge: null,
//               color: Colors.deepOrange,
//               onTap: () {
//                 Get.back();
//                 Get.toNamed(AppRoutes.setting);
//               },
//             ),
//
//             const Divider(height: 32, indent: 20, endIndent: 20),
//
//             _buildDrawerItem(
//               icon: Icons.info_outline_rounded,
//               title: 'about_us'.tr,
//               color: AppColors.textPrimary(context),
//               onTap: () {
//                 Get.back();
//                 Get.toNamed(AppRoutes.about);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDrawerItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//     String? badge,
//     Color color = Colors.black87,
//   }) {
//     return ListTile(
//       contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
//       leading: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Icon(icon, color: color, size: 22),
//       ),
//       title: Text(
//         title,
//         style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//       ),
//       trailing: badge != null
//           ? Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: color,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 badge,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             )
//           : null,
//       onTap: onTap,
//     );
//   }
//
//   PreferredSizeWidget _buildAppBar(
//     HomeController controller,
//     BuildContext context,
//   ) {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: AppColors.cardBackground(context),
//       foregroundColor: AppColors.textPrimary(context),
//       title: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [Colors.orange, Colors.green],
//               ),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Text(
//               'SnapKart',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//           ),
//           const SizedBox(width: 4),
//           const Text('⚡', style: TextStyle(fontSize: 20)),
//         ],
//       ),
//       actions: [
//         IconButton(
//           icon: Icon(Icons.search, color: AppColors.textPrimary(context)),
//           onPressed: () => _showSearchDialog(controller),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(right: 8),
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               IconButton(
//                 icon: Icon(
//                   Icons.shopping_cart_outlined,
//                   color: AppColors.textPrimary(context),
//                 ),
//                 onPressed: () {
//                   Get.dialog(
//                     AlertDialog(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       title: Row(
//                         children: [
//                           const Icon(
//                             Icons.shopping_cart_outlined,
//                             color: Colors.deepOrange,
//                           ),
//                           const SizedBox(width: 8),
//                           Text('clear_cart_title'.tr),
//                         ],
//                       ),
//                       content: Obx(() {
//                         CartController.instance.cartItems.value;
//                         final count = CartController.instance.cartItemCount;
//                         return Text(
//                           count == 0
//                               ? 'cart_is_empty'.tr
//                               : 'clear_cart_confirm'.trParams({
//                                   'count': count.toString(),
//                                 }),
//                         );
//                       }),
//                       actions: [
//                         TextButton(
//                           onPressed: () => Get.back(),
//                           child: Text(
//                             'cancel'.tr,
//                             style: const TextStyle(color: Colors.grey),
//                           ),
//                         ),
//                         Obx(() {
//                           CartController.instance.cartItems.value;
//                           final count = CartController.instance.cartItemCount;
//                           if (count == 0) {
//                             return TextButton(
//                               onPressed: () => Get.back(),
//                               child: Text('ok'.tr),
//                             );
//                           }
//                           return ElevatedButton.icon(
//                             onPressed: () {
//                               CartController.instance.clearCart();
//                               Get.back();
//                               Get.snackbar(
//                                 'cart_cleared_title'.tr,
//                                 'cart_cleared_sub'.tr,
//                                 snackPosition: SnackPosition.BOTTOM,
//                                 backgroundColor: Colors.red.shade100,
//                                 colorText: Colors.red.shade900,
//                                 margin: const EdgeInsets.all(16),
//                                 borderRadius: 12,
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.deepOrange,
//                               foregroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             icon: const Icon(Icons.delete_outline, size: 18),
//                             label: Text('clear'.tr),
//                           );
//                         }),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               Positioned(
//                 right: 4,
//                 top: 8,
//                 child: Obx(() {
//                   CartController.instance.cartItems.value;
//                   final count = CartController.instance.cartItemCount;
//                   if (count == 0) return const SizedBox.shrink();
//                   return Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: const BoxDecoration(
//                       color: Colors.green,
//                       shape: BoxShape.circle,
//                     ),
//                     constraints: const BoxConstraints(
//                       minWidth: 18,
//                       minHeight: 18,
//                     ),
//                     child: Text(
//                       '$count',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ],
//       bottom: PreferredSize(
//         preferredSize: const Size.fromHeight(1),
//         child: Container(height: 1, color: Colors.grey.shade200),
//       ),
//     );
//   }
//
//   // NAYA - home screen ke top pe promo banner/carousel
//   // Widget _buildPromoBanner(HomeController controller, BuildContext context) {
//   //   return Obx(() {
//   //     if (controller.isBannersLoading.value) {
//   //       return const SizedBox(
//   //         height: 160,
//   //         child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
//   //       );
//   //     }
//   //     if (controller.banners.isEmpty) return const SizedBox();
//
//   Widget _buildPromoBanner(HomeController controller, BuildContext context) {
//     return Obx(() {
//       // if (controller.isBannersLoading.value) {
//       //   return Padding(
//       //     padding: const EdgeInsets.only(top: 8),
//       //     child: SizedBox(
//       //       height: 160,
//       //       child: WaveSkeletonBox(borderRadius: BorderRadius.circular(16)),
//       //     ),
//       //   );
//       // }
//
//       if (controller.isBannersLoading.value) {
//         return Padding(
//           padding: const EdgeInsets.only(top: 8),
//           child: SizedBox(
//             height: 160,
//             child: WaveSkeletonBox(borderRadius: BorderRadius.circular(16)),
//           ),
//         );
//       }
//
//       if (controller.banners.isEmpty) return const SizedBox();
//
//       return Padding(
//         padding: const EdgeInsets.only(top: 8),
//         child: CarouselSlider(
//           options: CarouselOptions(
//             height: 160,
//             autoPlay: true,
//             autoPlayInterval: const Duration(seconds: 4),
//             enlargeCenterPage: true,
//             viewportFraction: 0.9,
//           ),
//           items: controller.banners.map((banner) {
//             return GestureDetector(
//               onTap: () => controller.handleBannerTap(banner),
//               child: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 6),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   color: Colors.grey.shade100,
//                 ),
//                 clipBehavior: Clip.antiAlias,
//                 child: Stack(
//                   fit: StackFit.expand,
//                   children: [
//                     Image.network(
//                       banner.imageUrl ?? '',
//                       fit: BoxFit.contain,
//                       errorBuilder: (_, __, ___) => Container(
//                         color: Colors.grey.shade200,
//                         child: const Icon(Icons.image_not_supported),
//                       ),
//                     ),
//                     if ((banner.discountText ?? '').isNotEmpty)
//                       Positioned(
//                         bottom: 12,
//                         left: 12,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 6,
//                           ),
//                           decoration: BoxDecoration(
//                             gradient: const LinearGradient(
//                               colors: [Colors.orange, Colors.deepOrange],
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Text(
//                             banner.discountText!,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 13,
//                             ),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       );
//     });
//   }
//
//   Widget _buildCategoryChips(HomeController controller, BuildContext context) {
//     return Obx(
//       () => Container(
//         height: 62,
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: controller.categories.length,
//           itemBuilder: (context, index) {
//             final category = controller.categories[index];
//             final count = controller.categoryCounts[category] ?? 0;
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 4),
//               child: Obx(() {
//                 final isSelected =
//                     controller.selectedCategory.value == category;
//                 return _buildCategoryChip(
//                   context: context,
//                   category: category,
//                   count: count,
//                   isSelected: isSelected,
//                   onTap: () => controller.filterByCategory(category),
//                   icon: controller.getCategoryIcon(category),
//                   color: Colors.blue,
//                 );
//               }),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   // NAYA - Recently Viewed horizontal section
//   Widget _buildRecentlyViewed(BuildContext context) {
//     return Obx(() {
//       final items = RecentlyViewedController.instance.recentItems;
//       if (items.isEmpty) return const SizedBox();
//
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
//             child: Text(
//               'recently_viewed'.tr,
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textPrimary(context),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 130,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               itemCount: items.length,
//               itemBuilder: (context, index) {
//                 final item = items[index];
//                 return GestureDetector(
//                   onTap: () async {
//                     final doc = await FirebaseFirestore.instance
//                         .collection('products')
//                         .doc(item['id'])
//                         .get();
//                     if (doc.exists) {
//                       final product = ModelClass.fromFirestore(doc);
//                       Get.toNamed(AppRoutes.productdetail, arguments: product);
//                     }
//                   },
//                   child: Container(
//                     width: 100,
//                     margin: const EdgeInsets.only(right: 10),
//                     decoration: BoxDecoration(
//                       color: AppColors.cardBackground(context),
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.shade200,
//                           blurRadius: 6,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ClipRRect(
//                           borderRadius: const BorderRadius.vertical(
//                             top: Radius.circular(12),
//                           ),
//                           child: Image.network(
//                             item['image'] ?? '',
//                             height: 80,
//                             width: 100,
//                             fit: BoxFit.contain,
//                             errorBuilder: (_, __, ___) => Container(
//                               height: 80,
//                               width: 100,
//                               color: Colors.grey.shade100,
//                               child: const Icon(
//                                 Icons.image_not_supported,
//                                 color: Colors.grey,
//                                 size: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 6,
//                             vertical: 4,
//                           ),
//                           child: Text(
//                             item['title'] ?? '',
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               fontSize: 11,
//                               color: AppColors.textPrimary(context),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       );
//     });
//   }
//
//   Widget _buildCategoryChip({
//     required BuildContext context,
//     required String category,
//     required int count,
//     required bool isSelected,
//     required VoidCallback onTap,
//     required IconData icon,
//     required Color color,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//           gradient: isSelected
//               ? LinearGradient(colors: [color, color.withValues(alpha: 0.7)])
//               : null,
//           color: isSelected ? null : AppColors.cardBackground(context),
//           borderRadius: BorderRadius.circular(30),
//           border: Border.all(
//             color: isSelected ? Colors.transparent : Colors.grey.shade300,
//             width: 1.5,
//           ),
//           boxShadow: isSelected
//               ? [
//                   BoxShadow(
//                     color: color.withValues(alpha: 0.3),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ]
//               : null,
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, size: 18, color: isSelected ? Colors.white : color),
//             const SizedBox(width: 6),
//             Text(
//               category,
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//                 color: isSelected
//                     ? Colors.white
//                     : AppColors.textSecondary(context),
//               ),
//             ),
//             const SizedBox(width: 4),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//               decoration: BoxDecoration(
//                 color: isSelected
//                     ? Colors.white.withValues(alpha: 0.2)
//                     : Colors.grey.shade200,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 '$count',
//                 style: TextStyle(
//                   fontSize: 10,
//                   fontWeight: FontWeight.bold,
//                   color: isSelected
//                       ? Colors.white
//                       : AppColors.textSecondary(context),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showSearchDialog(HomeController controller) {
//     Get.dialog(
//       Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'search_products'.tr,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 // onSubmitted: (value) {
//                 //   controller.searchProducts(value);
//                 //   Get.back();
//                 // },
//                 onSubmitted: (value) {
//                   if (value.trim().isEmpty) return;
//                   Get.back();
//                   Get.toNamed(AppRoutes.searchresult, arguments: value.trim());
//                 },
//
//                 decoration: InputDecoration(
//                   hintText: 'type_product_name'.tr,
//                   prefixIcon: const Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               TextButton(onPressed: () => Get.back(), child: Text('cancel'.tr)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLoadingState(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const SizedBox(
//             width: 50,
//             height: 50,
//             child: CircularProgressIndicator(
//               color: Colors.deepOrange,
//               strokeWidth: 3,
//             ),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'loading_products'.tr,
//             style: TextStyle(
//               color: AppColors.textSecondary(context),
//               fontSize: 16,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildErrorState(HomeController controller, BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.error_outline, color: Colors.red.shade300, size: 64),
//             const SizedBox(height: 16),
//             Text(
//               'something_wrong'.tr,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textPrimary(context),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               controller.errorMessage.value.isNotEmpty
//                   ? controller.errorMessage.value
//                   : 'unable_load_products'.tr,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: AppColors.textSecondary(context),
//               ),
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton.icon(
//               onPressed: controller.refreshProducts,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.deepOrange,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 24,
//                   vertical: 12,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               icon: const Icon(Icons.refresh),
//               label: Text('try_again'.tr),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(HomeController controller, BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.shopping_bag_outlined,
//             size: 64,
//             color: Colors.grey.shade300,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'no_products_found'.tr,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: AppColors.textPrimary(context),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'try_different_category'.tr,
//             style: TextStyle(
//               fontSize: 14,
//               color: AppColors.textSecondary(context),
//             ),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton.icon(
//             onPressed: controller.refreshProducts,
//             icon: const Icon(Icons.refresh),
//             label: Text('refresh'.tr),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.deepOrange,
//               foregroundColor: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProductGrid(HomeController controller, BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: controller.refreshProducts,
//       color: Colors.deepOrange,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 12,
//             mainAxisSpacing: 12,
//             childAspectRatio: 0.65,
//           ),
//           itemCount: controller.filteredProductList.length,
//           itemBuilder: (context, index) {
//             final product = controller.filteredProductList[index];
//             return _buildProductCard(product, controller, context);
//           },
//         ),
//       ),
//     );
//   }
//
//   // skelton loader wave
//
//   Widget _buildSkeletonGrid() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//           childAspectRatio: 0.65,
//         ),
//         itemCount: 6, // fake placeholder count
//         itemBuilder: (context, index) => _skeletonProductCard(),
//       ),
//     );
//   }
//
//   Widget _skeletonProductCard() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.shade200,
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // image area
//           const Expanded(
//             child: WaveSkeletonBox(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(16),
//                 topRight: Radius.circular(16),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // title line 1
//                 WaveSkeletonBox(
//                   width: double.infinity,
//                   height: 12,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 const SizedBox(height: 6),
//                 // title line 2 (shorter)
//                 const SizedBox(
//                   width: 80,
//                   child: WaveSkeletonBox(
//                     height: 12,
//                     borderRadius: BorderRadius.all(Radius.circular(4)),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 // price
//                 const SizedBox(
//                   width: 60,
//                   child: WaveSkeletonBox(
//                     height: 16,
//                     borderRadius: BorderRadius.all(Radius.circular(4)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProductCard(
//     ModelClass product,
//     HomeController controller,
//     BuildContext context,
//   ) {
//     final hasDiscount =
//         product.discountPrice != null && product.discountPrice! > 0;
//     final percentOff = hasDiscount && (product.price ?? 0) > 0
//         ? (((product.price! - product.discountPrice!) / product.price!) * 100)
//               .round()
//         : 0;
//
//     return GestureDetector(
//       onTap: () => controller.goToProductDetail(product),
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColors.cardBackground(context),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.shade200,
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade50,
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(16),
//                     topRight: Radius.circular(16),
//                   ),
//                 ),
//                 child: Stack(
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(16),
//                         topRight: Radius.circular(16),
//                       ),
//                       child: Image.network(
//                         product.image ?? '',
//                         fit: BoxFit.contain,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Icon(
//                             Icons.broken_image,
//                             size: 50,
//                             color: Colors.grey.shade300,
//                           );
//                         },
//                         loadingBuilder: (context, child, loadingProgress) {
//                           if (loadingProgress == null) return child;
//                           return Center(
//                             child: SizedBox(
//                               width: 30,
//                               height: 30,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 color: Colors.deepOrange.shade100,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     Positioned(
//                       top: 8,
//                       left: 8,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: controller
//                               .getCategoryColor(product.category ?? '')
//                               .withValues(alpha: 0.9),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(
//                               controller.getCategoryIcon(
//                                 product.category ?? '',
//                               ),
//                               size: 12,
//                               color: Colors.white,
//                             ),
//                             const SizedBox(width: 4),
//                             Text(
//                               product.category?.split(' ').first ?? '',
//                               style: const TextStyle(
//                                 fontSize: 9,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     if (hasDiscount)
//                       Positioned(
//                         top: 8,
//                         right: 8,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 8,
//                             vertical: 4,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.red.shade600,
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Text(
//                             '$percentOff% off',
//                             style: const TextStyle(
//                               fontSize: 9,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.title ?? 'No Title',
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimary(context),
//                       height: 1.3,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Icon(Icons.star, size: 14, color: Colors.amber.shade600),
//                       const SizedBox(width: 2),
//                       Text(
//                         product.rating?.rate?.toStringAsFixed(1) ?? '0.0',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.textSecondary(context),
//                         ),
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         '(${product.rating?.count ?? 0})',
//                         style: TextStyle(
//                           fontSize: 10,
//                           color: AppColors.textSecondary(context),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: ValueListenableBuilder<String>(
//                           valueListenable: CurrencyService.instance.symbol,
//                           builder: (context, currency, _) {
//                             if (!hasDiscount) {
//                               return Text(
//                                 '$currency ${product.price?.toStringAsFixed(0) ?? '0'}',
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.deepOrange,
//                                 ),
//                               );
//                             }
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   '$currency ${product.price?.toStringAsFixed(0) ?? '0'}',
//                                   style: const TextStyle(
//                                     fontSize: 11,
//                                     color: Colors.grey,
//                                     decoration: TextDecoration.lineThrough,
//                                   ),
//                                 ),
//                                 Text(
//                                   '$currency ${product.discountPrice?.toStringAsFixed(0) ?? '0'}',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.deepOrange,
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           CartController.instance.addToCart({
//                             'productId': product.id,
//                             'title': product.title,
//                             'price': hasDiscount
//                                 ? product.discountPrice
//                                 : product.price,
//                             'quantity': 1,
//                             'image': product.image,
//                           });
//                           Get.snackbar(
//                             '🛒 ${'added_exclaim'.tr}',
//                             'added_to_cart'.trParams({
//                               'product': product.title ?? '',
//                             }),
//                             snackPosition: SnackPosition.BOTTOM,
//                             backgroundColor: Colors.green.shade100,
//                             colorText: Colors.green.shade900,
//                             duration: const Duration(seconds: 1),
//                             margin: const EdgeInsets.all(16),
//                             borderRadius: 12,
//                           );
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.all(4),
//                           decoration: BoxDecoration(
//                             color: Colors.deepOrange.shade50,
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                           child: const Icon(
//                             Icons.add_shopping_cart,
//                             size: 16,
//                             color: Colors.deepOrange,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:snapkart/App_Routes/routes_view.dart';
//
// import '../../Utilities_Screens/App_Colors/app_colors.dart';
// import '../../Utilities_Screens/App_Model/app_model.dart';
// import '../../Utilities_Screens/Currency_Service/currency_service.dart';
// import '../../Utilities_Screens/Wave_Skelton_Box/wave_skelton_box.dart';
// import '../Cart_Screen/cart_controller.dart';
// import '../Recently_Viewed/recently_view_controller.dart';
// import '../Wishlist_Screen/wishlist_controller.dart';
// import 'home_controller.dart';
//
// class HomeView extends StatelessWidget {
//   const HomeView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final HomeController controller = Get.put(HomeController());
//     return Scaffold(
//       backgroundColor: AppColors.background(context),
//       drawer: _buildDrawer(controller, context),
//       appBar: _buildAppBar(controller, context),
//       body: RefreshIndicator(
//         onRefresh: controller.refreshProducts,
//         color: Colors.deepOrange,
//         child: CustomScrollView(
//           slivers: [
//             SliverToBoxAdapter(child: _buildPromoBanner(controller, context)),
//
//             // NAYA - category chips ab sticky/pinned hain
//             SliverPersistentHeader(
//               pinned: true,
//               delegate: _StickyHeaderDelegate(
//                 height: 62,
//                 backgroundColor: AppColors.background(context),
//                 child: _buildCategoryChips(controller, context),
//               ),
//             ),
//
//             SliverToBoxAdapter(child: _buildRecentlyViewed(context)),
//
//             Obx(() {
//               if (controller.isLoading.value) {
//                 return _buildSkeletonSliverGrid();
//               }
//               if (controller.isError.value) {
//                 return SliverFillRemaining(
//                   hasScrollBody: false,
//                   child: _buildErrorState(controller, context),
//                 );
//               }
//               if (controller.filteredProductList.isEmpty) {
//                 return SliverFillRemaining(
//                   hasScrollBody: false,
//                   child: _buildEmptyState(controller, context),
//                 );
//               }
//               return _buildProductSliverGrid(controller, context);
//             }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDrawer(HomeController controller, BuildContext context) {
//     return Drawer(
//       backgroundColor: AppColors.cardBackground(context),
//       child: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Obx(
//               () => SizedBox(
//                 height: 220,
//                 width: double.infinity,
//                 child: Image.network(
//                   controller.shoppingImages[controller.imageIndex.value],
//                   fit: BoxFit.cover,
//                   loadingBuilder: (context, child, loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return WaveSkeletonBox(
//                       height: 220,
//                       borderRadius: BorderRadius.zero,
//                     );
//                   },
//                   errorBuilder: (context, error, stackTrace) => Container(
//                     height: 220,
//                     width: double.infinity,
//                     color: Colors.grey.shade300,
//                     child: const Icon(Icons.image_not_supported, size: 40),
//                   ),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 8),
//
//             Obx(() {
//               final count = WishlistController.instance.wishlistCount;
//               return _buildDrawerItem(
//                 icon: Icons.favorite_rounded,
//                 title: 'my_wishlist'.tr,
//                 badge: count > 0 ? '$count' : null,
//                 color: Colors.pink,
//                 onTap: () {
//                   Get.back();
//                   Get.toNamed(AppRoutes.wishlist);
//                 },
//               );
//             }),
//
//             _buildDrawerItem(
//               icon: Icons.shopping_cart_outlined,
//               title: 'my_cart'.tr,
//               badge: null,
//               color: Colors.deepOrange,
//               onTap: () {
//                 Get.back();
//                 Get.toNamed(AppRoutes.cart);
//               },
//             ),
//
//             _buildDrawerItem(
//               icon: Icons.shopping_bag,
//               title: 'order_checkout'.tr,
//               badge: null,
//               color: Colors.deepOrange,
//               onTap: () {
//                 Get.back();
//                 Get.toNamed(AppRoutes.checkout);
//               },
//             ),
//
//             _buildDrawerItem(
//               icon: Icons.work_history_outlined,
//               title: 'order_history'.tr,
//               badge: null,
//               color: Colors.deepOrange,
//               onTap: () {
//                 Get.back();
//                 Get.toNamed(AppRoutes.history);
//               },
//             ),
//
//             _buildDrawerItem(
//               icon: Icons.settings,
//               title: 'settings'.tr,
//               badge: null,
//               color: Colors.deepOrange,
//               onTap: () {
//                 Get.back();
//                 Get.toNamed(AppRoutes.setting);
//               },
//             ),
//
//             const Divider(height: 32, indent: 20, endIndent: 20),
//
//             _buildDrawerItem(
//               icon: Icons.info_outline_rounded,
//               title: 'about_us'.tr,
//               color: AppColors.textPrimary(context),
//               onTap: () {
//                 Get.back();
//                 Get.toNamed(AppRoutes.about);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDrawerItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//     String? badge,
//     Color color = Colors.black87,
//   }) {
//     return ListTile(
//       contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
//       leading: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Icon(icon, color: color, size: 22),
//       ),
//       title: Text(
//         title,
//         style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//       ),
//       trailing: badge != null
//           ? Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: color,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 badge,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             )
//           : null,
//       onTap: onTap,
//     );
//   }
//
//   PreferredSizeWidget _buildAppBar(
//     HomeController controller,
//     BuildContext context,
//   ) {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: AppColors.cardBackground(context),
//       foregroundColor: AppColors.textPrimary(context),
//       title: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [Colors.orange, Colors.green],
//               ),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Text(
//               'SnapKart',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//           ),
//           const SizedBox(width: 4),
//           const Text('⚡', style: TextStyle(fontSize: 20)),
//         ],
//       ),
//       actions: [
//         IconButton(
//           icon: Icon(Icons.search, color: AppColors.textPrimary(context)),
//           onPressed: () => _showSearchDialog(controller),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(right: 8),
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               IconButton(
//                 icon: Icon(
//                   Icons.shopping_cart_outlined,
//                   color: AppColors.textPrimary(context),
//                 ),
//                 onPressed: () {
//                   Get.dialog(
//                     AlertDialog(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       title: Row(
//                         children: [
//                           const Icon(
//                             Icons.shopping_cart_outlined,
//                             color: Colors.deepOrange,
//                           ),
//                           const SizedBox(width: 8),
//                           Text('clear_cart_title'.tr),
//                         ],
//                       ),
//                       content: Obx(() {
//                         CartController.instance.cartItems.value;
//                         final count = CartController.instance.cartItemCount;
//                         return Text(
//                           count == 0
//                               ? 'cart_is_empty'.tr
//                               : 'clear_cart_confirm'.trParams({
//                                   'count': count.toString(),
//                                 }),
//                         );
//                       }),
//                       actions: [
//                         TextButton(
//                           onPressed: () => Get.back(),
//                           child: Text(
//                             'cancel'.tr,
//                             style: const TextStyle(color: Colors.grey),
//                           ),
//                         ),
//                         Obx(() {
//                           CartController.instance.cartItems.value;
//                           final count = CartController.instance.cartItemCount;
//                           if (count == 0) {
//                             return TextButton(
//                               onPressed: () => Get.back(),
//                               child: Text('ok'.tr),
//                             );
//                           }
//                           return ElevatedButton.icon(
//                             onPressed: () {
//                               CartController.instance.clearCart();
//                               Get.back();
//                               Get.snackbar(
//                                 'cart_cleared_title'.tr,
//                                 'cart_cleared_sub'.tr,
//                                 snackPosition: SnackPosition.BOTTOM,
//                                 backgroundColor: Colors.red.shade100,
//                                 colorText: Colors.red.shade900,
//                                 margin: const EdgeInsets.all(16),
//                                 borderRadius: 12,
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.deepOrange,
//                               foregroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             icon: const Icon(Icons.delete_outline, size: 18),
//                             label: Text('clear'.tr),
//                           );
//                         }),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               Positioned(
//                 right: 4,
//                 top: 8,
//                 child: Obx(() {
//                   CartController.instance.cartItems.value;
//                   final count = CartController.instance.cartItemCount;
//                   if (count == 0) return const SizedBox.shrink();
//                   return Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: const BoxDecoration(
//                       color: Colors.green,
//                       shape: BoxShape.circle,
//                     ),
//                     constraints: const BoxConstraints(
//                       minWidth: 18,
//                       minHeight: 18,
//                     ),
//                     child: Text(
//                       '$count',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ],
//       bottom: PreferredSize(
//         preferredSize: const Size.fromHeight(1),
//         child: Container(height: 1, color: Colors.grey.shade200),
//       ),
//     );
//   }
//
//   Widget _buildPromoBanner(HomeController controller, BuildContext context) {
//     return Obx(() {
//       if (controller.isBannersLoading.value) {
//         return Padding(
//           padding: const EdgeInsets.only(top: 8),
//           child: SizedBox(
//             height: 160,
//             child: WaveSkeletonBox(borderRadius: BorderRadius.circular(16)),
//           ),
//         );
//       }
//
//       if (controller.banners.isEmpty) return const SizedBox();
//
//       return Padding(
//         padding: const EdgeInsets.only(top: 8),
//         child: CarouselSlider(
//           options: CarouselOptions(
//             height: 160,
//             autoPlay: true,
//             autoPlayInterval: const Duration(seconds: 4),
//             enlargeCenterPage: true,
//             viewportFraction: 0.9,
//           ),
//           items: controller.banners.map((banner) {
//             return GestureDetector(
//               onTap: () => controller.handleBannerTap(banner),
//               child: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 6),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   color: Colors.grey.shade100,
//                 ),
//                 clipBehavior: Clip.antiAlias,
//                 child: Stack(
//                   fit: StackFit.expand,
//                   children: [
//                     Image.network(
//                       banner.imageUrl ?? '',
//                       fit: BoxFit.contain,
//                       errorBuilder: (_, __, ___) => Container(
//                         color: Colors.grey.shade200,
//                         child: const Icon(Icons.image_not_supported),
//                       ),
//                     ),
//                     if ((banner.discountText ?? '').isNotEmpty)
//                       Positioned(
//                         bottom: 12,
//                         left: 12,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 6,
//                           ),
//                           decoration: BoxDecoration(
//                             gradient: const LinearGradient(
//                               colors: [Colors.orange, Colors.deepOrange],
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Text(
//                             banner.discountText!,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 13,
//                             ),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       );
//     });
//   }
//
//   Widget _buildCategoryChips(HomeController controller, BuildContext context) {
//     return Obx(
//       () => Container(
//         height: 62,
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: controller.categories.length,
//           itemBuilder: (context, index) {
//             final category = controller.categories[index];
//             final count = controller.categoryCounts[category] ?? 0;
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 4),
//               child: Obx(() {
//                 final isSelected =
//                     controller.selectedCategory.value == category;
//                 return _buildCategoryChip(
//                   context: context,
//                   category: category,
//                   count: count,
//                   isSelected: isSelected,
//                   onTap: () => controller.filterByCategory(category),
//                   icon: controller.getCategoryIcon(category),
//                   color: Colors.blue,
//                 );
//               }),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRecentlyViewed(BuildContext context) {
//     return Obx(() {
//       final items = RecentlyViewedController.instance.recentItems;
//       if (items.isEmpty) return const SizedBox();
//
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
//             child: Text(
//               'recently_viewed'.tr,
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textPrimary(context),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 130,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               itemCount: items.length,
//               itemBuilder: (context, index) {
//                 final item = items[index];
//                 return GestureDetector(
//                   onTap: () async {
//                     final doc = await FirebaseFirestore.instance
//                         .collection('products')
//                         .doc(item['id'])
//                         .get();
//                     if (doc.exists) {
//                       final product = ModelClass.fromFirestore(doc);
//                       Get.toNamed(AppRoutes.productdetail, arguments: product);
//                     }
//                   },
//                   child: Container(
//                     width: 100,
//                     margin: const EdgeInsets.only(right: 10),
//                     decoration: BoxDecoration(
//                       color: AppColors.cardBackground(context),
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.shade200,
//                           blurRadius: 6,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ClipRRect(
//                           borderRadius: const BorderRadius.vertical(
//                             top: Radius.circular(12),
//                           ),
//                           child: Image.network(
//                             item['image'] ?? '',
//                             height: 80,
//                             width: 100,
//                             fit: BoxFit.contain,
//                             errorBuilder: (_, __, ___) => Container(
//                               height: 80,
//                               width: 100,
//                               color: Colors.grey.shade100,
//                               child: const Icon(
//                                 Icons.image_not_supported,
//                                 color: Colors.grey,
//                                 size: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 6,
//                             vertical: 4,
//                           ),
//                           child: Text(
//                             item['title'] ?? '',
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               fontSize: 11,
//                               color: AppColors.textPrimary(context),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       );
//     });
//   }
//
//   Widget _buildCategoryChip({
//     required BuildContext context,
//     required String category,
//     required int count,
//     required bool isSelected,
//     required VoidCallback onTap,
//     required IconData icon,
//     required Color color,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//           gradient: isSelected
//               ? LinearGradient(colors: [color, color.withValues(alpha: 0.7)])
//               : null,
//           color: isSelected ? null : AppColors.cardBackground(context),
//           borderRadius: BorderRadius.circular(30),
//           border: Border.all(
//             color: isSelected ? Colors.transparent : Colors.grey.shade300,
//             width: 1.5,
//           ),
//           boxShadow: isSelected
//               ? [
//                   BoxShadow(
//                     color: color.withValues(alpha: 0.3),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ]
//               : null,
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, size: 18, color: isSelected ? Colors.white : color),
//             const SizedBox(width: 6),
//             Text(
//               category,
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//                 color: isSelected
//                     ? Colors.white
//                     : AppColors.textSecondary(context),
//               ),
//             ),
//             const SizedBox(width: 4),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//               decoration: BoxDecoration(
//                 color: isSelected
//                     ? Colors.white.withValues(alpha: 0.2)
//                     : Colors.grey.shade200,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 '$count',
//                 style: TextStyle(
//                   fontSize: 10,
//                   fontWeight: FontWeight.bold,
//                   color: isSelected
//                       ? Colors.white
//                       : AppColors.textSecondary(context),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showSearchDialog(HomeController controller) {
//     Get.dialog(
//       Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'search_products'.tr,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 onSubmitted: (value) {
//                   if (value.trim().isEmpty) return;
//                   Get.back();
//                   Get.toNamed(AppRoutes.searchresult, arguments: value.trim());
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'type_product_name'.tr,
//                   prefixIcon: const Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               TextButton(onPressed: () => Get.back(), child: Text('cancel'.tr)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildErrorState(HomeController controller, BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.error_outline, color: Colors.red.shade300, size: 64),
//             const SizedBox(height: 16),
//             Text(
//               'something_wrong'.tr,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textPrimary(context),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               controller.errorMessage.value.isNotEmpty
//                   ? controller.errorMessage.value
//                   : 'unable_load_products'.tr,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: AppColors.textSecondary(context),
//               ),
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton.icon(
//               onPressed: controller.refreshProducts,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.deepOrange,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 24,
//                   vertical: 12,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               icon: const Icon(Icons.refresh),
//               label: Text('try_again'.tr),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(HomeController controller, BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.shopping_bag_outlined,
//             size: 64,
//             color: Colors.grey.shade300,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'no_products_found'.tr,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: AppColors.textPrimary(context),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'try_different_category'.tr,
//             style: TextStyle(
//               fontSize: 14,
//               color: AppColors.textSecondary(context),
//             ),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton.icon(
//             onPressed: controller.refreshProducts,
//             icon: const Icon(Icons.refresh),
//             label: Text('refresh'.tr),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.deepOrange,
//               foregroundColor: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // NAYA - product grid ab sliver hai (CustomScrollView ke andar)
//   Widget _buildProductSliverGrid(
//     HomeController controller,
//     BuildContext context,
//   ) {
//     return SliverPadding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       sliver: SliverGrid(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//           childAspectRatio: 0.65,
//         ),
//         delegate: SliverChildBuilderDelegate((context, index) {
//           final product = controller.filteredProductList[index];
//           return _buildProductCard(product, controller, context);
//         }, childCount: controller.filteredProductList.length),
//       ),
//     );
//   }
//
//   // NAYA - skeleton grid ab sliver hai
//   Widget _buildSkeletonSliverGrid() {
//     return SliverPadding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       sliver: SliverGrid(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//           childAspectRatio: 0.65,
//         ),
//         delegate: SliverChildBuilderDelegate(
//           (context, index) => _skeletonProductCard(),
//           childCount: 6,
//         ),
//       ),
//     );
//   }
//
//   Widget _skeletonProductCard() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.shade200,
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Expanded(
//             child: WaveSkeletonBox(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(16),
//                 topRight: Radius.circular(16),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 WaveSkeletonBox(
//                   width: double.infinity,
//                   height: 12,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 const SizedBox(height: 6),
//                 const SizedBox(
//                   width: 80,
//                   child: WaveSkeletonBox(
//                     height: 12,
//                     borderRadius: BorderRadius.all(Radius.circular(4)),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const SizedBox(
//                   width: 60,
//                   child: WaveSkeletonBox(
//                     height: 16,
//                     borderRadius: BorderRadius.all(Radius.circular(4)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProductCard(
//     ModelClass product,
//     HomeController controller,
//     BuildContext context,
//   ) {
//     final hasDiscount =
//         product.discountPrice != null && product.discountPrice! > 0;
//     final percentOff = hasDiscount && (product.price ?? 0) > 0
//         ? (((product.price! - product.discountPrice!) / product.price!) * 100)
//               .round()
//         : 0;
//
//     return GestureDetector(
//       onTap: () => controller.goToProductDetail(product),
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColors.cardBackground(context),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.shade200,
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(16),
//                   topRight: Radius.circular(16),
//                 ),
//                 child: Container(
//                   width: double.infinity,
//                   color: Colors.grey.shade50,
//                   child: Stack(
//                     children: [
//                       Positioned.fill(
//                         child: Image.network(
//                           product.image ?? '',
//                           fit: BoxFit.contain,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Icon(
//                               Icons.broken_image,
//                               size: 50,
//                               color: Colors.grey.shade300,
//                             );
//                           },
//                           loadingBuilder: (context, child, loadingProgress) {
//                             if (loadingProgress == null) return child;
//                             return Center(
//                               child: SizedBox(
//                                 width: 30,
//                                 height: 30,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   color: Colors.deepOrange.shade100,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//
//                       // category tag - ab neeche-left corner
//                       Positioned(
//                         bottom: 8,
//                         left: 8,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 8,
//                             vertical: 4,
//                           ),
//                           decoration: BoxDecoration(
//                             color: controller
//                                 .getCategoryColor(product.category ?? '')
//                                 .withValues(alpha: 0.9),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 controller.getCategoryIcon(
//                                   product.category ?? '',
//                                 ),
//                                 size: 12,
//                                 color: Colors.white,
//                               ),
//                               const SizedBox(width: 4),
//                               Text(
//                                 product.category?.split(' ').first ?? '',
//                                 style: const TextStyle(
//                                   fontSize: 9,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                       // NAYA - Daraz style diagonal discount ribbon
//                       if (hasDiscount) _buildDiscountRibbon(percentOff),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.title ?? 'No Title',
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimary(context),
//                       height: 1.3,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Icon(Icons.star, size: 14, color: Colors.amber.shade600),
//                       const SizedBox(width: 2),
//                       Text(
//                         product.rating?.rate?.toStringAsFixed(1) ?? '0.0',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.textSecondary(context),
//                         ),
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         '(${product.rating?.count ?? 0})',
//                         style: TextStyle(
//                           fontSize: 10,
//                           color: AppColors.textSecondary(context),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: ValueListenableBuilder<String>(
//                           valueListenable: CurrencyService.instance.symbol,
//                           builder: (context, currency, _) {
//                             if (!hasDiscount) {
//                               return Text(
//                                 '$currency ${product.price?.toStringAsFixed(0) ?? '0'}',
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.deepOrange,
//                                 ),
//                               );
//                             }
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   '$currency ${product.price?.toStringAsFixed(0) ?? '0'}',
//                                   style: const TextStyle(
//                                     fontSize: 11,
//                                     color: Colors.grey,
//                                     decoration: TextDecoration.lineThrough,
//                                   ),
//                                 ),
//                                 Text(
//                                   '$currency ${product.discountPrice?.toStringAsFixed(0) ?? '0'}',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.deepOrange,
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           CartController.instance.addToCart({
//                             'productId': product.id,
//                             'title': product.title,
//                             'price': hasDiscount
//                                 ? product.discountPrice
//                                 : product.price,
//                             'quantity': 1,
//                             'image': product.image,
//                           });
//                           Get.snackbar(
//                             '🛒 ${'added_exclaim'.tr}',
//                             'added_to_cart'.trParams({
//                               'product': product.title ?? '',
//                             }),
//                             snackPosition: SnackPosition.BOTTOM,
//                             backgroundColor: Colors.green.shade100,
//                             colorText: Colors.green.shade900,
//                             duration: const Duration(seconds: 1),
//                             margin: const EdgeInsets.all(16),
//                             borderRadius: 12,
//                           );
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.all(4),
//                           decoration: BoxDecoration(
//                             color: Colors.deepOrange.shade50,
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                           child: const Icon(
//                             Icons.add_shopping_cart,
//                             size: 16,
//                             color: Colors.deepOrange,
//                           ),
//                         ),
//                       ),
//                     ],
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
//   // NAYA - Daraz jaisa diagonal discount ribbon (top-right corner)
//   Widget _buildDiscountRibbon(int percentOff) {
//     return Positioned(
//       top: 10,
//       right: -34,
//       child: Transform.rotate(
//         angle: 0.7853981634, // 45 degrees
//         child: Container(
//           width: 110,
//           alignment: Alignment.center,
//           padding: const EdgeInsets.symmetric(vertical: 4),
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFFFF3D3D), Color(0xFFE60023)],
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 3,
//                 offset: Offset(0, 1),
//               ),
//             ],
//           ),
//           child: Text(
//             '$percentOff% OFF',
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 10,
//               fontWeight: FontWeight.w800,
//               letterSpacing: 0.3,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // NAYA - category chips ko CustomScrollView mein pin/sticky karne ke liye
// class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final Widget child;
//   final double height;
//   final Color backgroundColor;
//
//   _StickyHeaderDelegate({
//     required this.child,
//     required this.height,
//     required this.backgroundColor,
//   });
//
//   @override
//   double get minExtent => height;
//
//   @override
//   double get maxExtent => height;
//
//   @override
//   Widget build(
//     BuildContext context,
//     double shrinkOffset,
//     bool overlapsContent,
//   ) {
//     return Container(color: backgroundColor, child: child);
//   }
//
//   @override
//   bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) {
//     return oldDelegate.child != child ||
//         oldDelegate.height != height ||
//         oldDelegate.backgroundColor != backgroundColor;
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snapkart/App_Routes/routes_view.dart';

import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/App_Model/app_model.dart';
import '../../Utilities_Screens/Currency_Service/currency_service.dart';
import '../../Utilities_Screens/Wave_Skelton_Box/wave_skelton_box.dart';
import '../Cart_Screen/cart_controller.dart';
import '../Recently_Viewed/recently_view_controller.dart';
import '../Wishlist_Screen/wishlist_controller.dart';
import 'home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: AppColors.background(context),
      drawer: _buildDrawer(controller, context),
      appBar: _buildAppBar(controller, context),
      body: RefreshIndicator(
        onRefresh: controller.refreshProducts,
        color: Colors.deepOrange,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildPromoBanner(controller, context)),

            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyHeaderDelegate(
                height: 62,
                backgroundColor: AppColors.background(context),
                child: _buildCategoryChips(controller, context),
              ),
            ),

            SliverToBoxAdapter(child: _buildRecentlyViewed(context)),

            Obx(() {
              if (controller.isLoading.value) {
                return _buildSkeletonSliverGrid();
              }

              if (controller.isError.value) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: _buildErrorState(controller, context),
                );
              }

              if (controller.filteredProductList.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: _buildEmptyState(controller, context),
                );
              }

              return _buildProductSliverGrid(controller, context);
            }),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DRAWER
  // ============================================================

  Widget _buildDrawer(HomeController controller, BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.cardBackground(context),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => SizedBox(
                height: 220,
                width: double.infinity,
                child: Image.network(
                  controller.shoppingImages[controller.imageIndex.value],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return WaveSkeletonBox(
                      height: 220,
                      borderRadius: BorderRadius.zero,
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 220,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image_not_supported, size: 40),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 8),

            Obx(() {
              final count = WishlistController.instance.wishlistCount;

              return _buildDrawerItem(
                icon: Icons.favorite_rounded,
                title: 'my_wishlist'.tr,
                badge: count > 0 ? '$count' : null,
                color: Colors.pink,
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.wishlist);
                },
              );
            }),

            _buildDrawerItem(
              icon: Icons.shopping_cart_outlined,
              title: 'my_cart'.tr,
              badge: null,
              color: Colors.deepOrange,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.cart);
              },
            ),

            _buildDrawerItem(
              icon: Icons.shopping_bag,
              title: 'order_checkout'.tr,
              badge: null,
              color: Colors.deepOrange,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.checkout);
              },
            ),

            _buildDrawerItem(
              icon: Icons.work_history_outlined,
              title: 'order_history'.tr,
              badge: null,
              color: Colors.deepOrange,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.history);
              },
            ),

            _buildDrawerItem(
              icon: Icons.settings,
              title: 'settings'.tr,
              badge: null,
              color: Colors.deepOrange,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.setting);
              },
            ),

            const Divider(height: 32, indent: 20, endIndent: 20),

            _buildDrawerItem(
              icon: Icons.info_outline_rounded,
              title: 'about_us'.tr,
              color: AppColors.textPrimary(context),
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.about);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    String? badge,
    Color color = Colors.black87,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      trailing: badge != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
      onTap: onTap,
    );
  }

  // ============================================================
  // APP BAR
  // ============================================================

  PreferredSizeWidget _buildAppBar(
    HomeController controller,
    BuildContext context,
  ) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.cardBackground(context),
      foregroundColor: AppColors.textPrimary(context),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.orange, Colors.green],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'SnapKart',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 4),
          const Text('⚡', style: TextStyle(fontSize: 20)),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: AppColors.textPrimary(context)),
          onPressed: () => _showSearchDialog(controller),
        ),

        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: AppColors.textPrimary(context),
                ),
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      title: Row(
                        children: [
                          const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.deepOrange,
                          ),
                          const SizedBox(width: 8),
                          Text('clear_cart_title'.tr),
                        ],
                      ),
                      content: Obx(() {
                        CartController.instance.cartItems.value;

                        final count = CartController.instance.cartItemCount;

                        return Text(
                          count == 0
                              ? 'cart_is_empty'.tr
                              : 'clear_cart_confirm'.trParams({
                                  'count': count.toString(),
                                }),
                        );
                      }),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: Text(
                            'cancel'.tr,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),

                        Obx(() {
                          CartController.instance.cartItems.value;

                          final count = CartController.instance.cartItemCount;

                          if (count == 0) {
                            return TextButton(
                              onPressed: () => Get.back(),
                              child: Text('ok'.tr),
                            );
                          }

                          return ElevatedButton.icon(
                            onPressed: () {
                              CartController.instance.clearCart();

                              Get.back();

                              Get.snackbar(
                                'cart_cleared_title'.tr,
                                'cart_cleared_sub'.tr,
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red.shade100,
                                colorText: Colors.red.shade900,
                                margin: const EdgeInsets.all(16),
                                borderRadius: 12,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(Icons.delete_outline, size: 18),
                            label: Text('clear'.tr),
                          );
                        }),
                      ],
                    ),
                  );
                },
              ),

              Positioned(
                right: 4,
                top: 8,
                child: Obx(() {
                  CartController.instance.cartItems.value;

                  final count = CartController.instance.cartItemCount;

                  if (count == 0) {
                    return const SizedBox.shrink();
                  }

                  return Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '$count',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: Colors.grey.shade200),
      ),
    );
  }

  // ============================================================
  // DARAZ STYLE PROMO BANNER
  // ============================================================

  Widget _buildPromoBanner(HomeController controller, BuildContext context) {
    return Obx(() {
      if (controller.isBannersLoading.value) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
          child: SizedBox(
            height: 185,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: WaveSkeletonBox(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        );
      }

      if (controller.banners.isEmpty) {
        return const SizedBox.shrink();
      }

      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
        child: CarouselSlider(
          options: CarouselOptions(
            height: 185,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 700),
            enlargeCenterPage: true,
            enlargeFactor: 0.08,
            viewportFraction: 0.92,
            enableInfiniteScroll: controller.banners.length > 1,
          ),

          items: controller.banners.map((banner) {
            return GestureDetector(
              onTap: () => controller.handleBannerTap(banner),

              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                clipBehavior: Clip.antiAlias,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),

                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // ------------------------------------------------
                    // BACKGROUND IMAGE
                    // ------------------------------------------------
                    Image.network(
                      banner.imageUrl ?? '',
                      fit: BoxFit.cover,

                      errorBuilder: (_, __, ___) {
                        return Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFFF6B00), Color(0xFFE91E63)],
                            ),
                          ),
                        );
                      },

                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }

                        return Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFFF6B00), Color(0xFFE91E63)],
                            ),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      },
                    ),

                    // ------------------------------------------------
                    // DARK OVERLAY
                    // ------------------------------------------------
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xE6000000),
                            Color(0x99000000),
                            Color(0x10000000),
                          ],
                          stops: [0.0, 0.48, 1.0],
                        ),
                      ),
                    ),

                    // ------------------------------------------------
                    // DECORATIVE CIRCLES
                    // ------------------------------------------------
                    Positioned(
                      right: -35,
                      top: -35,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.10),
                        ),
                      ),
                    ),

                    Positioned(
                      right: 35,
                      bottom: -55,
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                    ),

                    // ------------------------------------------------
                    // TEXT / OFFER
                    // ------------------------------------------------
                    Positioned(
                      left: 18,
                      top: 15,
                      bottom: 15,
                      right: 125,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          // HOT DEAL
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  size: 14,
                                  color: Colors.deepOrange,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'HOT DEAL',
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 8),

                          // TITLE
                          Text(
                            banner.title?.isNotEmpty == true
                                ? banner.title!
                                : 'MEGA SALE',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                              height: 1.05,
                              letterSpacing: 0.3,
                            ),
                          ),

                          const SizedBox(height: 5),

                          // DISCOUNT
                          if ((banner.discountText ?? '').isNotEmpty)
                            Text(
                              banner.discountText!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                          const SizedBox(height: 10),

                          // SHOP NOW
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 13,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Shop Now',
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(width: 4),
                                // Icon(
                                //   Icons.arrow_forward,
                                //   color: Colors.deepOrange,
                                //   size: 14,
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ------------------------------------------------
                    // DISCOUNT BADGE
                    // ------------------------------------------------
                    if ((banner.discountText ?? '').isNotEmpty)
                      Positioned(
                        right: 12,
                        top: 12,

                        child: Transform.rotate(
                          angle: 0.12,

                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 9,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.red.shade600,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                                width: 1.5,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),

                            child: Column(
                              children: [
                                const Text(
                                  'UP TO',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),

                                const SizedBox(height: 1),

                                Text(
                                  banner.discountText!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    // ------------------------------------------------
                    // BOTTOM COLOR STRIP
                    // ------------------------------------------------
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 4,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.yellow, Colors.orange, Colors.red],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }

  // ============================================================
  // CATEGORY CHIPS
  // ============================================================

  Widget _buildCategoryChips(HomeController controller, BuildContext context) {
    return Obx(
      () => Container(
        height: 62,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final category = controller.categories[index];

            final count = controller.categoryCounts[category] ?? 0;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Obx(() {
                final isSelected =
                    controller.selectedCategory.value == category;

                return _buildCategoryChip(
                  context: context,
                  category: category,
                  count: count,
                  isSelected: isSelected,
                  onTap: () => controller.filterByCategory(category),
                  icon: controller.getCategoryIcon(category),
                  color: Colors.blue,
                );
              }),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // RECENTLY VIEWED
  // ============================================================

  Widget _buildRecentlyViewed(BuildContext context) {
    return Obx(() {
      final items = RecentlyViewedController.instance.recentItems;

      if (items.isEmpty) {
        return const SizedBox();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              'Recently Viewed'.tr,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary(context),
              ),
            ),
          ),

          // SizedBox(
          //   height: 130,
          //
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     padding: const EdgeInsets.symmetric(horizontal: 16),
          //     itemCount: items.length,
          //
          //     itemBuilder: (context, index) {
          //       final item = items[index];
          //
          //       return GestureDetector(
          //         onTap: () async {
          //           final doc = await FirebaseFirestore.instance
          //               .collection('products')
          //               .doc(item['id'])
          //               .get();
          //
          //           if (doc.exists) {
          //             final product = ModelClass.fromFirestore(doc);
          //
          //             Get.toNamed(AppRoutes.productdetail, arguments: product);
          //           }
          //         },
          //
          //         child: Container(
          //           width: 100,
          //           margin: const EdgeInsets.only(right: 10),
          //
          //           decoration: BoxDecoration(
          //             color: AppColors.cardBackground(context),
          //             borderRadius: BorderRadius.circular(12),
          //             boxShadow: [
          //               BoxShadow(
          //                 color: Colors.grey.shade200,
          //                 blurRadius: 6,
          //                 offset: const Offset(0, 2),
          //               ),
          //             ],
          //           ),
          //
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               ClipRRect(
          //                 borderRadius: const BorderRadius.vertical(
          //                   top: Radius.circular(12),
          //                 ),
          //
          //                 child: Image.network(
          //                   item['image'] ?? '',
          //                   height: 80,
          //                   width: 100,
          //                   fit: BoxFit.contain,
          //                   errorBuilder: (_, __, ___) => Container(
          //                     height: 80,
          //                     width: 100,
          //                     color: Colors.grey.shade100,
          //                     child: const Icon(
          //                       Icons.image_not_supported,
          //                       color: Colors.grey,
          //                       size: 20,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //
          //               Padding(
          //                 padding: const EdgeInsets.symmetric(
          //                   horizontal: 6,
          //                   vertical: 4,
          //                 ),
          //                 child: Text(
          //                   item['title'] ?? '',
          //                   maxLines: 1,
          //                   overflow: TextOverflow.ellipsis,
          //                   style: TextStyle(
          //                     fontSize: 11,
          //                     color: AppColors.textPrimary(context),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          SizedBox(
            height: 100, // pehle 130 tha

            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: items.length,

              itemBuilder: (context, index) {
                final item = items[index];

                return GestureDetector(
                  onTap: () async {
                    final doc = await FirebaseFirestore.instance
                        .collection('products')
                        .doc(item['id'])
                        .get();

                    if (doc.exists) {
                      final product = ModelClass.fromFirestore(doc);
                      Get.toNamed(AppRoutes.productdetail, arguments: product);
                    }
                  },

                  child: Container(
                    width: 72, // pehle 100 tha
                    margin: const EdgeInsets.only(right: 8),

                    decoration: BoxDecoration(
                      color: AppColors.cardBackground(context),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),

                          child: Image.network(
                            item['image'] ?? '',
                            height: 56, // pehle 80 tha
                            width: 72, // pehle 100 tha
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => Container(
                              height: 56,
                              width: 72,
                              color: Colors.grey.shade100,
                              child: const Icon(
                                Icons.image_not_supported,
                                color: Colors.grey,
                                size: 16,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 3,
                          ),
                          child: Text(
                            item['title'] ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 9,
                              color: AppColors.textPrimary(context),
                            ),
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
      );
    });
  }

  // ============================================================
  // CATEGORY CHIP
  // ============================================================

  Widget _buildCategoryChip({
    required BuildContext context,
    required String category,
    required int count,
    required bool isSelected,
    required VoidCallback onTap,
    required IconData icon,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),

        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(colors: [color, color.withValues(alpha: 0.7)])
              : null,

          color: isSelected ? null : AppColors.cardBackground(context),

          borderRadius: BorderRadius.circular(30),

          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
            width: 1.5,
          ),

          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: isSelected ? Colors.white : color),

            const SizedBox(width: 6),

            Text(
              category,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : AppColors.textSecondary(context),
              ),
            ),

            const SizedBox(width: 4),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.2)
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? Colors.white
                      : AppColors.textSecondary(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SEARCH
  // ============================================================

  void _showSearchDialog(HomeController controller) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              const Text(
                'Search Products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              TextField(
                onSubmitted: (value) {
                  if (value.trim().isEmpty) {
                    return;
                  }

                  Get.back();

                  Get.toNamed(AppRoutes.searchresult, arguments: value.trim());
                },

                decoration: InputDecoration(
                  hintText: 'type_product_name'.tr,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              TextButton(onPressed: () => Get.back(), child: Text('cancel'.tr)),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ERROR STATE
  // ============================================================

  Widget _buildErrorState(HomeController controller, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red.shade300, size: 64),

            const SizedBox(height: 16),

            Text(
              'something_wrong'.tr,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary(context),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              controller.errorMessage.value.isNotEmpty
                  ? controller.errorMessage.value
                  : 'unable_load_products'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary(context),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: controller.refreshProducts,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.refresh),
              label: Text('try_again'.tr),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _buildEmptyState(HomeController controller, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 64,
            color: Colors.grey.shade300,
          ),

          const SizedBox(height: 16),

          Text(
            'no_products_found'.tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary(context),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'try_different_category'.tr,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary(context),
            ),
          ),

          const SizedBox(height: 16),

          ElevatedButton.icon(
            onPressed: controller.refreshProducts,
            icon: const Icon(Icons.refresh),
            label: Text('refresh'.tr),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PRODUCT GRID
  // ============================================================

  Widget _buildProductSliverGrid(
    HomeController controller,
    BuildContext context,
  ) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.65,
        ),

        delegate: SliverChildBuilderDelegate((context, index) {
          final product = controller.filteredProductList[index];

          return _buildProductCard(product, controller, context);
        }, childCount: controller.filteredProductList.length),
      ),
    );
  }

  // ============================================================
  // SKELETON
  // ============================================================

  Widget _buildSkeletonSliverGrid() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.65,
        ),

        delegate: SliverChildBuilderDelegate(
          (context, index) => _skeletonProductCard(),
          childCount: 6,
        ),
      ),
    );
  }

  Widget _skeletonProductCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Expanded(
            child: WaveSkeletonBox(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                WaveSkeletonBox(
                  width: double.infinity,
                  height: 12,
                  borderRadius: BorderRadius.circular(4),
                ),

                const SizedBox(height: 6),

                const SizedBox(
                  width: 80,
                  child: WaveSkeletonBox(
                    height: 12,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),

                const SizedBox(height: 10),

                const SizedBox(
                  width: 60,
                  child: WaveSkeletonBox(
                    height: 16,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PRODUCT CARD
  // ============================================================

  // Widget _buildProductCard(
  //   ModelClass product,
  //   HomeController controller,
  //   BuildContext context,
  // ) {
  //   final hasDiscount =
  //       product.discountPrice != null && product.discountPrice! > 0;
  //
  //   final percentOff = hasDiscount && (product.price ?? 0) > 0
  //       ? (((product.price! - product.discountPrice!) / product.price!) * 100)
  //             .round()
  //       : 0;
  //
  //   return GestureDetector(
  //     onTap: () => controller.goToProductDetail(product),
  //
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: AppColors.cardBackground(context),
  //         borderRadius: BorderRadius.circular(16),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.shade200,
  //             blurRadius: 8,
  //             offset: const Offset(0, 4),
  //           ),
  //         ],
  //       ),
  //
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //
  //         children: [
  //           Expanded(
  //             child: ClipRRect(
  //               borderRadius: const BorderRadius.only(
  //                 topLeft: Radius.circular(16),
  //                 topRight: Radius.circular(16),
  //               ),
  //
  //               child: Container(
  //                 width: double.infinity,
  //                 color: Colors.grey.shade50,
  //
  //                 child: Stack(
  //                   children: [
  //                     Positioned.fill(
  //                       child: Image.network(
  //                         product.image ?? '',
  //                         fit: BoxFit.contain,
  //
  //                         errorBuilder: (context, error, stackTrace) {
  //                           return Icon(
  //                             Icons.broken_image,
  //                             size: 50,
  //                             color: Colors.grey.shade300,
  //                           );
  //                         },
  //
  //                         loadingBuilder: (context, child, loadingProgress) {
  //                           if (loadingProgress == null) {
  //                             return child;
  //                           }
  //
  //                           return Center(
  //                             child: SizedBox(
  //                               width: 30,
  //                               height: 30,
  //                               child: CircularProgressIndicator(
  //                                 strokeWidth: 2,
  //                                 color: Colors.deepOrange.shade100,
  //                               ),
  //                             ),
  //                           );
  //                         },
  //                       ),
  //                     ),
  //
  //                     // CATEGORY
  //                     Positioned(
  //                       bottom: 8,
  //                       left: 8,
  //
  //                       child: Container(
  //                         padding: const EdgeInsets.symmetric(
  //                           horizontal: 8,
  //                           vertical: 4,
  //                         ),
  //
  //                         decoration: BoxDecoration(
  //                           color: controller
  //                               .getCategoryColor(product.category ?? '')
  //                               .withValues(alpha: 0.9),
  //                           borderRadius: BorderRadius.circular(12),
  //                         ),
  //
  //                         child: Row(
  //                           mainAxisSize: MainAxisSize.min,
  //                           children: [
  //                             Icon(
  //                               controller.getCategoryIcon(
  //                                 product.category ?? '',
  //                               ),
  //                               size: 12,
  //                               color: Colors.white,
  //                             ),
  //
  //                             const SizedBox(width: 4),
  //
  //                             Text(
  //                               product.category?.split(' ').first ?? '',
  //                               style: const TextStyle(
  //                                 fontSize: 9,
  //                                 color: Colors.white,
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //
  //                     // DISCOUNT RIBBON
  //                     if (hasDiscount) _buildDiscountRibbon(percentOff),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //
  //           Padding(
  //             padding: const EdgeInsets.all(10),
  //
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //
  //               children: [
  //                 Text(
  //                   product.title ?? 'No Title',
  //                   maxLines: 2,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: TextStyle(
  //                     fontSize: 13,
  //                     fontWeight: FontWeight.w600,
  //                     color: AppColors.textPrimary(context),
  //                     height: 1.3,
  //                   ),
  //                 ),
  //
  //                 const SizedBox(height: 4),
  //
  //                 Row(
  //                   children: [
  //                     Icon(Icons.star, size: 14, color: Colors.amber.shade600),
  //
  //                     const SizedBox(width: 2),
  //
  //                     Text(
  //                       product.rating?.rate?.toStringAsFixed(1) ?? '0.0',
  //                       style: TextStyle(
  //                         fontSize: 12,
  //                         fontWeight: FontWeight.w500,
  //                         color: AppColors.textSecondary(context),
  //                       ),
  //                     ),
  //
  //                     const SizedBox(width: 4),
  //
  //                     Text(
  //                       '(${product.rating?.count ?? 0})',
  //                       style: TextStyle(
  //                         fontSize: 10,
  //                         color: AppColors.textSecondary(context),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //
  //                 const SizedBox(height: 4),
  //
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //
  //                   children: [
  //                     Expanded(
  //                       child: ValueListenableBuilder<String>(
  //                         valueListenable: CurrencyService.instance.symbol,
  //
  //                         builder: (context, currency, _) {
  //                           if (!hasDiscount) {
  //                             return Text(
  //                               '$currency ${product.price?.toStringAsFixed(0) ?? '0'}',
  //                               style: const TextStyle(
  //                                 fontSize: 16,
  //                                 fontWeight: FontWeight.bold,
  //                                 color: Colors.deepOrange,
  //                               ),
  //                             );
  //                           }
  //
  //                           return Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //
  //                             children: [
  //                               Text(
  //                                 '$currency ${product.price?.toStringAsFixed(0) ?? '0'}',
  //                                 style: const TextStyle(
  //                                   fontSize: 11,
  //                                   color: Colors.grey,
  //                                   decoration: TextDecoration.lineThrough,
  //                                 ),
  //                               ),
  //
  //                               Text(
  //                                 '$currency ${product.discountPrice?.toStringAsFixed(0) ?? '0'}',
  //                                 style: const TextStyle(
  //                                   fontSize: 16,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: Colors.deepOrange,
  //                                 ),
  //                               ),
  //                             ],
  //                           );
  //                         },
  //                       ),
  //                     ),
  //
  //                     GestureDetector(
  //                       onTap: () {
  //                         CartController.instance.addToCart({
  //                           'productId': product.id,
  //                           'title': product.title,
  //                           'price': hasDiscount
  //                               ? product.discountPrice
  //                               : product.price,
  //                           'quantity': 1,
  //                           'image': product.image,
  //                         });
  //
  //                         Get.snackbar(
  //                           '🛒 ${'added_exclaim'.tr}',
  //                           'added_to_cart'.trParams({
  //                             'product': product.title ?? '',
  //                           }),
  //                           snackPosition: SnackPosition.BOTTOM,
  //                           backgroundColor: Colors.green.shade100,
  //                           colorText: Colors.green.shade900,
  //                           duration: const Duration(seconds: 1),
  //                           margin: const EdgeInsets.all(16),
  //                           borderRadius: 12,
  //                         );
  //                       },
  //
  //                       child: Container(
  //                         padding: const EdgeInsets.all(4),
  //
  //                         decoration: BoxDecoration(
  //                           color: Colors.deepOrange.shade50,
  //                           borderRadius: BorderRadius.circular(6),
  //                         ),
  //
  //                         child: const Icon(
  //                           Icons.add_shopping_cart,
  //                           size: 16,
  //                           color: Colors.deepOrange,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildProductCard(
    ModelClass product,
    HomeController controller,
    BuildContext context,
  ) {
    final double oldPrice = product.price ?? 0;
    final double salePrice = product.discountPrice ?? 0;
    final int stock = product.stock ?? 0;

    final bool hasDiscount =
        salePrice > 0 && oldPrice > 0 && salePrice < oldPrice;

    final int discountPercent = hasDiscount
        ? (((oldPrice - salePrice) / oldPrice) * 100).round()
        : 0;

    // ------------------------------------------------------------
    // DARAZ STYLE OFFER TEXT
    // ------------------------------------------------------------

    String offerText;

    if (hasDiscount && stock > 0 && stock <= 10) {
      offerText = '🔥 $discountPercent% OFF • Only $stock left';
    } else if (hasDiscount) {
      offerText = '🔥 Flash Sale • $discountPercent% OFF';
    } else if (stock > 0 && stock <= 5) {
      offerText = '⚡ Hurry! Only $stock left';
    } else if (stock > 0 && stock <= 20) {
      offerText = '🔥 Selling Fast';
    } else {
      offerText = '⚡ Limited Time Offer';
    }

    return GestureDetector(
      onTap: () {
        controller.goToProductDetail(product);
      },

      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground(context),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========================================================
            // IMAGE SECTION
            // ========================================================
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),

                child: Stack(
                  children: [
                    // ------------------------------------------------
                    // PRODUCT IMAGE
                    // ------------------------------------------------
                    Positioned.fill(
                      child: Container(
                        color: Colors.white,

                        child: Image.network(
                          product.image ?? '',
                          fit: BoxFit.contain,

                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                size: 45,
                                color: Colors.grey.shade300,
                              ),
                            );
                          },

                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }

                            return const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.deepOrange,
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // =================================================
                    // TOP LEFT DISCOUNT
                    // =================================================
                    if (hasDiscount)
                      Positioned(
                        left: 0,
                        top: 10,

                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 6,
                          ),

                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFFF3B30), Color(0xFFFF1744)],
                            ),

                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(7),
                              bottomRight: Radius.circular(7),
                            ),
                          ),

                          child: Text(
                            '-$discountPercent%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),

                    // =================================================
                    // TOP RIGHT STOCK
                    // =================================================
                    if (stock > 0 && stock <= 10)
                      Positioned(
                        right: 7,
                        top: 8,

                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 5,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.orange.shade700,
                            borderRadius: BorderRadius.circular(6),
                          ),

                          child: Text(
                            'Only $stock left',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),

                    // =================================================
                    // DARAZ STYLE BOTTOM OFFER STRIP
                    // =================================================
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,

                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 8,
                        ),

                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Color(0xE6000000),
                              Color(0x99000000),
                              Colors.transparent,
                            ],
                          ),
                        ),

                        child: Row(
                          children: [
                            const Icon(
                              Icons.local_fire_department,
                              color: Colors.orange,
                              size: 15,
                            ),

                            const SizedBox(width: 4),

                            Expanded(
                              child: Text(
                                offerText,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,

                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // =================================================
                    // CATEGORY BADGE
                    // =================================================
                    Positioned(
                      left: 7,
                      bottom: 42,

                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 4,
                        ),

                        decoration: BoxDecoration(
                          color: controller
                              .getCategoryColor(product.category ?? '')
                              .withValues(alpha: 0.95),

                          borderRadius: BorderRadius.circular(6),
                        ),

                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              controller.getCategoryIcon(
                                product.category ?? '',
                              ),
                              size: 11,
                              color: Colors.white,
                            ),

                            const SizedBox(width: 3),

                            Text(
                              product.category ?? 'Product',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,

                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ========================================================
            // PRODUCT INFORMATION
            // ========================================================
            Padding(
              padding: const EdgeInsets.fromLTRB(9, 8, 9, 9),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // PRODUCT TITLE
                  Text(
                    product.title ?? 'Product',

                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary(context),
                      height: 1.25,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // DESCRIPTION
                  if ((product.description ?? '').isNotEmpty)
                    Text(
                      product.description!,

                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,

                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.textSecondary(context),
                      ),
                    ),

                  const SizedBox(height: 5),

                  // RATING
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),

                      const SizedBox(width: 3),

                      Text(
                        product.rating?.rate?.toStringAsFixed(1) ?? '0.0',

                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary(context),
                        ),
                      ),

                      const SizedBox(width: 3),

                      Text(
                        '(${product.rating?.count ?? 0})',

                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  // =================================================
                  // PRICE + CART
                  // =================================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Expanded(
                        child: ValueListenableBuilder<String>(
                          valueListenable: CurrencyService.instance.symbol,

                          builder: (context, currency, _) {
                            // NORMAL PRICE
                            if (!hasDiscount) {
                              return Text(
                                '$currency ${oldPrice.toStringAsFixed(0)}',

                                style: const TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                ),
                              );
                            }

                            // DISCOUNT PRICE
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                // OLD PRICE
                                Text(
                                  '$currency ${oldPrice.toStringAsFixed(0)}',

                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 10,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),

                                // NEW PRICE
                                Row(
                                  children: [
                                    Text(
                                      '$currency ${salePrice.toStringAsFixed(0)}',

                                      style: const TextStyle(
                                        color: Colors.deepOrange,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),

                                    const SizedBox(width: 5),

                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 2,
                                      ),

                                      decoration: BoxDecoration(
                                        color: Colors.red.shade50,
                                        borderRadius: BorderRadius.circular(4),
                                      ),

                                      child: Text(
                                        '-$discountPercent%',

                                        style: TextStyle(
                                          color: Colors.red.shade600,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      // ADD CART
                      GestureDetector(
                        onTap: () {
                          CartController.instance.addToCart({
                            'productId': product.id,
                            'title': product.title,
                            'price': hasDiscount
                                ? product.discountPrice
                                : product.price,
                            'quantity': 1,
                            'image': product.image,
                          });

                          Get.snackbar(
                            '🛒 ${'added_exclaim'.tr}',
                            'added_to_cart'.trParams({
                              'product': product.title ?? '',
                            }),

                            snackPosition: SnackPosition.BOTTOM,

                            backgroundColor: Colors.green.shade100,

                            colorText: Colors.green.shade900,

                            duration: const Duration(seconds: 1),

                            margin: const EdgeInsets.all(16),

                            borderRadius: 12,
                          );
                        },

                        child: Container(
                          padding: const EdgeInsets.all(7),

                          decoration: BoxDecoration(
                            color: Colors.deepOrange.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),

                          child: const Icon(
                            Icons.add_shopping_cart,
                            size: 18,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DISCOUNT RIBBON
  // ============================================================

  Widget _buildDiscountRibbon(int percentOff) {
    return Positioned(
      top: 10,
      right: -34,

      child: Transform.rotate(
        angle: 0.7853981634,

        child: Container(
          width: 110,
          alignment: Alignment.center,

          padding: const EdgeInsets.symmetric(vertical: 4),

          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF3D3D), Color(0xFFE60023)],
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),

          child: Text(
            '$percentOff% OFF',
            textAlign: TextAlign.center,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// STICKY CATEGORY HEADER
// ============================================================

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;
  final Color backgroundColor;

  _StickyHeaderDelegate({
    required this.child,
    required this.height,
    required this.backgroundColor,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: backgroundColor, child: child);
  }

  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.height != height ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
