// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../Utilities_Screens/App_Model/app_model.dart';
// import '../Cart_Screen/cart_controller.dart';
// import '../Recently_Viewed/recently_view_controller.dart';
// import '../Wishlist_Screen/wishlist_controller.dart';
//
// class ProductDetailController extends GetxController {
//   var product = Rx<ModelClass?>(null);
//   var quantity = 1.obs;
//   var isAddedToCart = false.obs;
//   var currentImageIndex = 0.obs;
//   final List<String> dummyImages = [];
//
//   @override
//   void onInit() {
//     super.onInit();
//     if (Get.arguments != null) {
//       product.value = Get.arguments as ModelClass;
//       //RecentlyViewedController.instance.addProduct(product.value!);
//       if (product.value?.image != null) {
//         dummyImages.add(product.value!.image!);
//         dummyImages.add('https://picsum.photos/400/400?random=1');
//         dummyImages.add('https://picsum.photos/400/400?random=2');
//         dummyImages.add('https://picsum.photos/400/400?random=3');
//       }
//     }
//   }
//
//   @override
//   void onReady() {
//     super.onReady();
//     if (product.value != null) {
//       RecentlyViewedController.instance.addProduct(product.value!);
//     }
//   }
//
//   bool get isWishlisted =>
//       WishlistController.instance.isWishlisted(product.value?.id);
//
//   void toggleWishlist() {
//     if (product.value != null) {
//       WishlistController.instance.toggleWishlist(product.value!);
//       product.refresh(); // UI update
//     }
//   }
//
//   // NAYA - tier ke hisaab se current unit price
//   // double getUnitPrice() {
//   //   final p = product.value;
//   //   if (p == null) return 0.0;
//   //
//   //   final tiers = p.priceTiers;
//   //   if (tiers.isEmpty) return p.price ?? 0.0;
//   //
//   //   final sortedTiers = [...tiers]
//   //     ..sort((a, b) => b.minQty.compareTo(a.minQty));
//   //
//   //   for (var tier in sortedTiers) {
//   //     if (quantity.value >= tier.minQty) {
//   //       return tier.price;
//   //     }
//   //   }
//   //   return p.price ?? 0.0;
//   // }
//
//   double getUnitPrice() {
//     final p = product.value;
//     if (p == null) return 0.0;
//
//     final tiers = p.priceTiers;
//     final basePrice = (p.discountPrice != null && p.discountPrice! > 0)
//         ? p.discountPrice!
//         : (p.price ?? 0.0); // CHANGE - discountPrice ko base price banaya
//
//     if (tiers.isEmpty) return basePrice;
//
//     final sortedTiers = [...tiers]
//       ..sort((a, b) => b.minQty.compareTo(a.minQty));
//
//     for (var tier in sortedTiers) {
//       if (quantity.value >= tier.minQty) {
//         return tier.price;
//       }
//     }
//     return basePrice; // CHANGE
//   }
//
//   void increaseQuantity() {
//     if (quantity.value < 10) {
//       quantity.value++;
//     } else {
//       Get.snackbar(
//         'Limit Reached',
//         'Maximum 10 items allowed',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.orange.shade100,
//         colorText: Colors.orange.shade900,
//       );
//     }
//   }
//
//   void decreaseQuantity() {
//     if (quantity.value > 1) quantity.value--;
//   }
//
//   void changeImage(int index) => currentImageIndex.value = index;
//
//   void addToCart() {
//     isAddedToCart.value = true;
//     CartController.instance.addToCart({
//       'productId': product.value?.id,
//       'title': product.value?.title,
//       'price': product.value?.price,
//       'quantity': quantity.value,
//       'image': product.value?.image,
//       'priceTiers':
//           product.value?.priceTiers.map((t) => t.toMap()).toList() ?? [],
//     });
//     Get.snackbar(
//       'Success!',
//       '${product.value?.title ?? 'Product'} added to cart',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.green.shade100,
//       colorText: Colors.green.shade900,
//       duration: const Duration(seconds: 2),
//       margin: const EdgeInsets.all(16),
//       borderRadius: 12,
//       icon: const Icon(Icons.check_circle, color: Colors.green),
//     );
//     Future.delayed(const Duration(seconds: 2), () {
//       isAddedToCart.value = false;
//     });
//   }
//
//   void buyNow() {
//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: const Row(
//           children: [
//             Icon(Icons.shopping_bag, color: Color(0xFFE94560)),
//             SizedBox(width: 8),
//             Text('Confirm Order'),
//           ],
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               product.value?.title ?? '',
//               style: const TextStyle(fontWeight: FontWeight.w500),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const Divider(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text('Quantity:'),
//                 Obx(() => Text('${quantity.value}')),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Total:',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Obx(
//                   () => Text(
//                     // CHANGE - ab tier-aware price use hoga
//                     '₹${(getUnitPrice() * quantity.value).toStringAsFixed(0)}',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFFE94560),
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Get.back();
//               Get.snackbar(
//                 'Order Placed!',
//                 'Your order has been placed successfully!',
//                 snackPosition: SnackPosition.BOTTOM,
//                 backgroundColor: Colors.green.shade100,
//                 colorText: Colors.green.shade900,
//                 duration: const Duration(seconds: 3),
//                 margin: const EdgeInsets.all(16),
//                 borderRadius: 12,
//                 icon: const Icon(Icons.check_circle, color: Colors.green),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFE94560),
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: const Text('Confirm Order'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String get formattedPrice =>
//       '₹${product.value?.price?.toStringAsFixed(0) ?? '0'}';
//
//   // CHANGE - ab tier-aware price use hoga
//   String get totalPrice {
//     final total = getUnitPrice() * quantity.value;
//     return '₹${total.toStringAsFixed(0)}';
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../Utilities_Screens/App_Model/app_model.dart';
// import '../Cart_Screen/cart_controller.dart';
// import '../Recently_Viewed/recently_view_controller.dart';
// import '../Wishlist_Screen/wishlist_controller.dart';
//
// class ProductDetailController extends GetxController {
//   var product = Rx<ModelClass?>(null);
//   var quantity = 1.obs;
//   var isAddedToCart = false.obs;
//   var currentImageIndex = 0.obs;
//   final List<String> dummyImages = [];
//
//   // NAYA - "You May Also Like" section ke liye
//   var relatedProducts = <ModelClass>[].obs;
//   var isRelatedLoading = true.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     if (Get.arguments != null) {
//       product.value = Get.arguments as ModelClass;
//       //RecentlyViewedController.instance.addProduct(product.value!);
//       if (product.value?.image != null) {
//         dummyImages.add(product.value!.image!);
//         dummyImages.add('https://picsum.photos/400/400?random=1');
//         dummyImages.add('https://picsum.photos/400/400?random=2');
//         dummyImages.add('https://picsum.photos/400/400?random=3');
//       }
//       fetchRelatedProducts(); // NAYA
//     }
//   }
//
//   @override
//   void onReady() {
//     super.onReady();
//     if (product.value != null) {
//       RecentlyViewedController.instance.addProduct(product.value!);
//     }
//   }
//
//   // NAYA - same category ke products fetch karta hai, current product ko chorh kar
//   Future<void> fetchRelatedProducts() async {
//     try {
//       isRelatedLoading.value = true;
//
//       final category = product.value?.category;
//
//       if (category == null || category.isEmpty) {
//         relatedProducts.value = [];
//         isRelatedLoading.value = false;
//         return;
//       }
//
//       final snapshot = await FirebaseFirestore.instance
//           .collection('products')
//           .where('category', isEqualTo: category)
//           .limit(12)
//           .get();
//
//       final items = snapshot.docs
//           .map((doc) => ModelClass.fromFirestore(doc))
//           .where((p) => p.id != product.value?.id)
//           .toList();
//
//       relatedProducts.value = items;
//     } catch (e) {
//       relatedProducts.value = [];
//     } finally {
//       isRelatedLoading.value = false;
//     }
//   }
//
//   // NAYA - jab user "You May Also Like" mein se koi product select kare
//   void switchToRelatedProduct(ModelClass newProduct) {
//     product.value = newProduct;
//     quantity.value = 1;
//     isAddedToCart.value = false;
//
//     dummyImages.clear();
//     if (newProduct.image != null) {
//       dummyImages.add(newProduct.image!);
//       dummyImages.add('https://picsum.photos/400/400?random=1');
//       dummyImages.add('https://picsum.photos/400/400?random=2');
//       dummyImages.add('https://picsum.photos/400/400?random=3');
//     }
//
//     RecentlyViewedController.instance.addProduct(newProduct);
//     fetchRelatedProducts();
//   }
//
//   bool get isWishlisted =>
//       WishlistController.instance.isWishlisted(product.value?.id);
//
//   void toggleWishlist() {
//     if (product.value != null) {
//       WishlistController.instance.toggleWishlist(product.value!);
//       product.refresh(); // UI update
//     }
//   }
//
//   double getUnitPrice() {
//     final p = product.value;
//     if (p == null) return 0.0;
//
//     final tiers = p.priceTiers;
//     final basePrice = (p.discountPrice != null && p.discountPrice! > 0)
//         ? p.discountPrice!
//         : (p.price ?? 0.0); // CHANGE - discountPrice ko base price banaya
//
//     if (tiers.isEmpty) return basePrice;
//
//     final sortedTiers = [...tiers]
//       ..sort((a, b) => b.minQty.compareTo(a.minQty));
//
//     for (var tier in sortedTiers) {
//       if (quantity.value >= tier.minQty) {
//         return tier.price;
//       }
//     }
//     return basePrice; // CHANGE
//   }
//
//   void increaseQuantity() {
//     if (quantity.value < 10) {
//       quantity.value++;
//     } else {
//       Get.snackbar(
//         'Limit Reached',
//         'Maximum 10 items allowed',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.orange.shade100,
//         colorText: Colors.orange.shade900,
//       );
//     }
//   }
//
//   void decreaseQuantity() {
//     if (quantity.value > 1) quantity.value--;
//   }
//
//   void changeImage(int index) => currentImageIndex.value = index;
//
//   void addToCart() {
//     isAddedToCart.value = true;
//     CartController.instance.addToCart({
//       'productId': product.value?.id,
//       'title': product.value?.title,
//       'price': product.value?.price,
//       'quantity': quantity.value,
//       'image': product.value?.image,
//       'priceTiers':
//           product.value?.priceTiers.map((t) => t.toMap()).toList() ?? [],
//     });
//     Get.snackbar(
//       'Success!',
//       '${product.value?.title ?? 'Product'} added to cart',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.green.shade100,
//       colorText: Colors.green.shade900,
//       duration: const Duration(seconds: 2),
//       margin: const EdgeInsets.all(16),
//       borderRadius: 12,
//       icon: const Icon(Icons.check_circle, color: Colors.green),
//     );
//     Future.delayed(const Duration(seconds: 2), () {
//       isAddedToCart.value = false;
//     });
//   }
//
//   void buyNow() {
//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: const Row(
//           children: [
//             Icon(Icons.shopping_bag, color: Color(0xFFE94560)),
//             SizedBox(width: 8),
//             Text('Confirm Order'),
//           ],
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               product.value?.title ?? '',
//               style: const TextStyle(fontWeight: FontWeight.w500),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const Divider(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text('Quantity:'),
//                 Obx(() => Text('${quantity.value}')),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Total:',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Obx(
//                   () => Text(
//                     '₹${(getUnitPrice() * quantity.value).toStringAsFixed(0)}',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFFE94560),
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Get.back();
//               Get.snackbar(
//                 'Order Placed!',
//                 'Your order has been placed successfully!',
//                 snackPosition: SnackPosition.BOTTOM,
//                 backgroundColor: Colors.green.shade100,
//                 colorText: Colors.green.shade900,
//                 duration: const Duration(seconds: 3),
//                 margin: const EdgeInsets.all(16),
//                 borderRadius: 12,
//                 icon: const Icon(Icons.check_circle, color: Colors.green),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFE94560),
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: const Text('Confirm Order'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String get formattedPrice =>
//       '₹${product.value?.price?.toStringAsFixed(0) ?? '0'}';
//
//   String get totalPrice {
//     final total = getUnitPrice() * quantity.value;
//     return '₹${total.toStringAsFixed(0)}';
//   }
// }





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utilities_Screens/App_Model/app_model.dart';
import '../Cart_Screen/cart_controller.dart';
import '../Recently_Viewed/recently_view_controller.dart';
import '../Wishlist_Screen/wishlist_controller.dart';

class ProductDetailController extends GetxController {

  // =====================================================
  // PRODUCT
  // =====================================================

  var product = Rx<ModelClass?>(null);


  // =====================================================
  // QUANTITY
  // =====================================================

  var quantity = 1.obs;


  // =====================================================
  // CART
  // =====================================================

  var isAddedToCart = false.obs;


  // =====================================================
  // IMAGE
  // =====================================================

  var currentImageIndex = 0.obs;

  final List<String> dummyImages = [];


  // =====================================================
  // SELECTED SIZE
  // =====================================================

  var selectedSize = Rx<ProductSize?>(null);


  // =====================================================
  // RELATED PRODUCTS
  // =====================================================

  var relatedProducts = <ModelClass>[].obs;

  var isRelatedLoading = true.obs;


  // =====================================================
  // INIT
  // =====================================================

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null &&
        Get.arguments is ModelClass) {

      product.value =
      Get.arguments as ModelClass;

      setupProduct();

      fetchRelatedProducts();
    }
  }


  // =====================================================
  // READY
  // =====================================================

  @override
  void onReady() {
    super.onReady();

    if (product.value != null) {
      RecentlyViewedController.instance
          .addProduct(product.value!);
    }
  }


  // =====================================================
  // SETUP PRODUCT
  // =====================================================

  void setupProduct() {

    quantity.value = 1;

    selectedSize.value = null;

    currentImageIndex.value = 0;

    dummyImages.clear();

    final image = product.value?.image;

    if (image != null &&
        image.isNotEmpty) {

      dummyImages.add(image);

      dummyImages.add(
        'https://picsum.photos/400/400?random=1',
      );

      dummyImages.add(
        'https://picsum.photos/400/400?random=2',
      );

      dummyImages.add(
        'https://picsum.photos/400/400?random=3',
      );
    }

    // Agar product ke sizes hain
    // to pehla available size select hoga.

    final sizes = product.value?.sizes ?? [];

    if (sizes.isNotEmpty) {

      final availableSize =
      sizes.firstWhereOrNull(
            (size) => size.stock > 0,
      );

      selectedSize.value =
          availableSize;
    }
  }


  // =====================================================
  // RELATED PRODUCTS
  // =====================================================

  Future<void> fetchRelatedProducts() async {

    try {

      isRelatedLoading.value = true;

      final category =
          product.value?.category;

      if (category == null ||
          category.isEmpty) {

        relatedProducts.clear();

        return;
      }

      final snapshot =
      await FirebaseFirestore.instance
          .collection('products')
          .where(
        'category',
        isEqualTo: category,
      )
          .limit(12)
          .get();

      final items =
      snapshot.docs
          .map(
            (doc) =>
            ModelClass.fromFirestore(doc),
      )
          .where(
            (p) =>
        p.id !=
            product.value?.id,
      )
          .toList();

      relatedProducts.assignAll(items);

    } catch (e) {

      relatedProducts.clear();

    } finally {

      isRelatedLoading.value = false;
    }
  }


  // =====================================================
  // SWITCH RELATED PRODUCT
  // =====================================================

  void switchToRelatedProduct(
      ModelClass newProduct,
      ) {

    product.value = newProduct;

    isAddedToCart.value = false;

    setupProduct();

    RecentlyViewedController.instance
        .addProduct(newProduct);

    fetchRelatedProducts();
  }


  // =====================================================
  // SIZE SELECT
  // =====================================================

  void selectSize(ProductSize size) {

    if (size.stock <= 0) {

      Get.snackbar(
        'Out of Stock',
        '${size.label} is currently unavailable.',
        snackPosition:
        SnackPosition.BOTTOM,
      );

      return;
    }

    selectedSize.value = size;

    // New size select hone par
    // quantity dobara 1

    quantity.value = 1;
  }


  // =====================================================
  // SELECTED SIZE STOCK
  // =====================================================

  int get selectedStock {

    if (selectedSize.value != null) {
      return selectedSize.value!.stock;
    }

    return product.value?.stock ?? 0;
  }


  // =====================================================
  // WISHLIST
  // =====================================================

  bool get isWishlisted =>
      WishlistController.instance
          .isWishlisted(
        product.value?.id,
      );


  void toggleWishlist() {

    if (product.value != null) {

      WishlistController.instance
          .toggleWishlist(
        product.value!,
      );

      product.refresh();
    }
  }


  // =====================================================
  // BASE PRICE
  // =====================================================

  double get basePrice {

    final p = product.value;

    if (p == null) {
      return 0.0;
    }

    if (p.discountPrice != null &&
        p.discountPrice! > 0) {

      return p.discountPrice!;
    }

    return p.price ?? 0.0;
  }


  // =====================================================
  // UNIT PRICE
  // =====================================================
  //
  // Priority:
  //
  // 1. Selected size price
  // 2. Quantity price tier
  // 3. Discount price
  // 4. Normal price
  //

  double getUnitPrice() {

    final p = product.value;

    if (p == null) {
      return 0.0;
    }


    // -----------------------------------------
    // SIZE PRICE
    // -----------------------------------------

    if (selectedSize.value != null &&
        selectedSize.value!.price > 0) {

      return selectedSize.value!.price;
    }


    // -----------------------------------------
    // PRICE TIERS
    // -----------------------------------------

    final tiers = p.priceTiers;

    if (tiers.isNotEmpty) {

      final sortedTiers = [...tiers]
        ..sort(
              (a, b) =>
              b.minQty.compareTo(
                a.minQty,
              ),
        );

      for (final tier in sortedTiers) {

        if (quantity.value >=
            tier.minQty) {

          return tier.price;
        }
      }
    }


    // -----------------------------------------
    // BASE
    // -----------------------------------------

    return basePrice;
  }


  // =====================================================
  // OLD PRICE
  // =====================================================

  double get oldPrice {

    final p = product.value;

    if (p == null) {
      return 0.0;
    }

    return p.price ?? 0.0;
  }


  // =====================================================
  // DISCOUNT %
  // =====================================================

  int get discountPercentage {

    final old = oldPrice;

    final current = getUnitPrice();

    if (old <= 0 ||
        current <= 0 ||
        current >= old) {

      return 0;
    }

    return ((old - current) /
        old *
        100)
        .round();
  }


  // =====================================================
  // QUANTITY INCREASE
  // =====================================================

  void increaseQuantity() {

    final maxStock = selectedStock;

    if (maxStock <= 0) {

      Get.snackbar(
        'Out of Stock',
        'This product is currently unavailable.',
        snackPosition:
        SnackPosition.BOTTOM,
      );

      return;
    }


    if (quantity.value < maxStock &&
        quantity.value < 10) {

      quantity.value++;

    } else if (quantity.value >= 10) {

      Get.snackbar(
        'Limit Reached',
        'Maximum 10 items allowed.',
        snackPosition:
        SnackPosition.BOTTOM,
        backgroundColor:
        Colors.orange.shade100,
        colorText:
        Colors.orange.shade900,
      );

    } else {

      Get.snackbar(
        'Stock Limit',
        'Only $maxStock item(s) available.',
        snackPosition:
        SnackPosition.BOTTOM,
      );
    }
  }


  // =====================================================
  // QUANTITY DECREASE
  // =====================================================

  void decreaseQuantity() {

    if (quantity.value > 1) {
      quantity.value--;
    }
  }


  // =====================================================
  // IMAGE
  // =====================================================

  void changeImage(int index) {

    currentImageIndex.value = index;
  }


  // =====================================================
  // ADD TO CART
  // =====================================================

  void addToCart() {

    final p = product.value;

    if (p == null) {
      return;
    }


    // -----------------------------------------
    // SIZE REQUIRED
    // -----------------------------------------

    if (p.sizes.isNotEmpty &&
        selectedSize.value == null) {

      Get.snackbar(
        'Select Size',
        'Please select a size first.',
        snackPosition:
        SnackPosition.BOTTOM,
      );

      return;
    }


    // -----------------------------------------
    // STOCK CHECK
    // -----------------------------------------

    if (selectedStock <= 0) {

      Get.snackbar(
        'Out of Stock',
        'This product is currently unavailable.',
        snackPosition:
        SnackPosition.BOTTOM,
      );

      return;
    }


    if (quantity.value > selectedStock) {

      Get.snackbar(
        'Stock Limit',
        'Only $selectedStock item(s) available.',
        snackPosition:
        SnackPosition.BOTTOM,
      );

      return;
    }


    isAddedToCart.value = true;


    // -----------------------------------------
    // CART DATA
    // -----------------------------------------

    CartController.instance.addToCart({

      'productId': p.id,

      'title': p.title,

      // IMPORTANT:
      // selected size ka actual price

      'price': getUnitPrice(),

      'quantity': quantity.value,

      'image': p.image,

      // selected size
      'size': selectedSize.value?.label,

      // size stock
      'sizeStock': selectedStock,

      // old price
      'oldPrice': oldPrice,

      'discountPercentage':
      discountPercentage,

      // existing price tiers
      'priceTiers':
      p.priceTiers
          .map(
            (t) => t.toMap(),
      )
          .toList(),
    });


    Get.snackbar(
      'Added to Cart',

      '${p.title ?? 'Product'}'
          '${selectedSize.value != null ? ' (${selectedSize.value!.label})' : ''}'
          ' added to cart.',

      snackPosition:
      SnackPosition.BOTTOM,

      backgroundColor:
      Colors.green.shade100,

      colorText:
      Colors.green.shade900,

      duration:
      const Duration(seconds: 2),

      margin:
      const EdgeInsets.all(16),

      borderRadius: 12,

      icon: const Icon(
        Icons.check_circle,
        color: Colors.green,
      ),
    );


    Future.delayed(
      const Duration(seconds: 2),
          () {

        isAddedToCart.value = false;

      },
    );
  }


  // =====================================================
  // BUY NOW
  // =====================================================

  void buyNow() {

    final p = product.value;

    if (p == null) {
      return;
    }


    if (p.sizes.isNotEmpty &&
        selectedSize.value == null) {

      Get.snackbar(
        'Select Size',
        'Please select a size first.',
        snackPosition:
        SnackPosition.BOTTOM,
      );

      return;
    }


    if (selectedStock <= 0) {

      Get.snackbar(
        'Out of Stock',
        'This product is currently unavailable.',
        snackPosition:
        SnackPosition.BOTTOM,
      );

      return;
    }


    Get.dialog(
      AlertDialog(

        shape:
        RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(16),
        ),

        title: const Row(
          children: [

            Icon(
              Icons.shopping_bag,
              color: Color(0xFFE94560),
            ),

            SizedBox(width: 8),

            Text('Confirm Order'),
          ],
        ),

        content: Column(

          mainAxisSize:
          MainAxisSize.min,

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Text(
              p.title ?? '',
              style:
              const TextStyle(
                fontWeight:
                FontWeight.w500,
              ),
              maxLines: 2,
              overflow:
              TextOverflow.ellipsis,
            ),

            const Divider(height: 20),


            if (selectedSize.value != null)
              Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
                children: [

                  const Text(
                    'Size:',
                  ),

                  Text(
                    selectedSize.value!
                        .label,
                    style:
                    const TextStyle(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),


            const SizedBox(height: 8),


            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,

              children: [

                const Text(
                  'Price:',
                ),

                Text(
                  'Rs. ${getUnitPrice().toStringAsFixed(0)}',
                  style:
                  const TextStyle(
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ],
            ),


            const SizedBox(height: 8),


            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,

              children: [

                const Text(
                  'Quantity:',
                ),

                Obx(
                      () => Text(
                    '${quantity.value}',
                  ),
                ),
              ],
            ),


            const SizedBox(height: 8),


            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,

              children: [

                const Text(
                  'Total:',
                  style:
                  TextStyle(
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                Obx(
                      () => Text(
                    'Rs. ${totalPriceValue.toStringAsFixed(0)}',

                    style:
                    const TextStyle(
                      fontWeight:
                      FontWeight.bold,
                      color:
                      Color(0xFFE94560),
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        actions: [

          TextButton(
            onPressed:
                () => Get.back(),

            child:
            const Text(
              'Cancel',
              style:
              TextStyle(
                color: Colors.grey,
              ),
            ),
          ),


          ElevatedButton(

            onPressed: () {

              Get.back();

              Get.snackbar(
                'Order Placed!',
                'Your order has been placed successfully!',

                snackPosition:
                SnackPosition.BOTTOM,

                backgroundColor:
                Colors.green.shade100,

                colorText:
                Colors.green.shade900,

                duration:
                const Duration(
                  seconds: 3,
                ),

                margin:
                const EdgeInsets.all(16),

                borderRadius: 12,

                icon:
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
              );
            },

            style:
            ElevatedButton.styleFrom(
              backgroundColor:
              const Color(0xFFE94560),

              foregroundColor:
              Colors.white,

              shape:
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(12),
              ),
            ),

            child:
            const Text(
              'Confirm Order',
            ),
          ),
        ],
      ),
    );
  }


  // =====================================================
  // FORMATTED PRICE
  // =====================================================

  String get formattedPrice {

    return
      'Rs. ${getUnitPrice().toStringAsFixed(0)}';
  }


  // =====================================================
  // TOTAL
  // =====================================================

  double get totalPriceValue {

    return getUnitPrice() *
        quantity.value;
  }


  String get totalPrice {

    return
      'Rs. ${totalPriceValue.toStringAsFixed(0)}';
  }
}