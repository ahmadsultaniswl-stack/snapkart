// import 'dart:developer' as developer;
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../Utilities_Screens/App_Model/app_model.dart';
// import '../../Utilities_Screens/Help_Function_Api/helping_function.dart';
// import '../Detail_Screen/detail_view.dart';
//
// class HomeController extends GetxController {
//   var productList = <ModelClass>[].obs;
//   var filteredProductList = <ModelClass>[].obs;
//   var isLoading = true.obs;
//   var isError = false.obs;
//   var errorMessage = ''.obs;
//
//   var selectedCategory = 'All'.obs;
//   var categories = <String>[].obs;
//   var categoryCounts = <String, int>{}.obs;
//   var imageIndex = 0.obs;
//
//   // NAYA - home screen promo banner/carousel
//   var banners = <BannerModel>[].obs;
//   var isBannersLoading = true.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchProducts();
//     fetchBanners(); // <-- naya
//     _changeImage();
//   }
//
//   final List<String> shoppingImages = [
//     'https://images.unsplash.com/photo-1441986300917-64674bd600d8',
//     'https://images.unsplash.com/photo-1483985988355-763728e1935b',
//     'https://images.unsplash.com/photo-1472851294608-062f824d29cc',
//     'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da',
//     'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d',
//     'https://images.unsplash.com/photo-1519415943484-9fa1873496d4',
//     'https://loremflickr.com/800/600/shopping,bags',
//     'https://loremflickr.com/800/600/shopping,mall',
//     'https://loremflickr.com/800/600/clothes,shopping',
//     'https://loremflickr.com/800/600/online,shopping',
//     'https://loremflickr.com/800/600/shopping,cart',
//     'https://loremflickr.com/800/600/fashion,store',
//     'https://loremflickr.com/800/600/retail,shop',
//     'https://loremflickr.com/800/600/supermarket',
//   ];
//
//   void _changeImage() async {
//     while (true) {
//       await Future.delayed(const Duration(seconds: 7));
//       //imageIndex.value++;
//       imageIndex.value = (imageIndex.value + 1) % shoppingImages.length;
//     }
//   }
//
//   //copy to firebase
//   Future<void> fetchProducts() async {
//     try {
//       isLoading.value = true;
//       isError.value = false;
//       errorMessage.value = '';
//
//       final querySnapshot = await FirebaseFirestore.instance
//           .collection('products')
//           .get();
//
//       productList.value = querySnapshot.docs
//           .map((doc) => ModelClass.fromFirestore(doc))
//           .toList();
//
//       _extractCategories();
//       filterByCategory('All');
//     } catch (e) {
//       isError.value = true;
//       errorMessage.value = 'An error occurred: ${e.toString()}';
//       developer.log('FetchProducts Error: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//   //end of copy to firebase
//
//   // NAYA - Firestore se active banners fetch karna, order field se sort
//   Future<void> fetchBanners() async {
//     try {
//       isBannersLoading.value = true;
//       final snapshot = await FirebaseFirestore.instance
//           .collection('banners')
//           .where('isActive', isEqualTo: true)
//           .orderBy('order')
//           .get();
//
//       banners.value = snapshot.docs
//           .map((doc) => BannerModel.fromFirestore(doc))
//           .toList();
//     } catch (e) {
//       developer.log('FetchBanners Error: $e');
//     } finally {
//       isBannersLoading.value = false;
//     }
//   }
//
//   // NAYA - banner tap hone par kahan navigate karna hai
//   void handleBannerTap(BannerModel banner) {
//     switch (banner.actionType) {
//       case 'category':
//         filterByCategory(banner.actionValue ?? 'All');
//         break;
//       case 'product':
//         FirebaseFirestore.instance
//             .collection('products')
//             .doc(banner.actionValue)
//             .get()
//             .then((doc) {
//               if (doc.exists) {
//                 goToProductDetail(ModelClass.fromFirestore(doc));
//               }
//             });
//         break;
//       case 'url':
//         // agar external link kholni ho to url_launcher use karein
//         break;
//       default:
//         break;
//     }
//   }
//
//   void _extractCategories() {
//     final uniqueCategories = <String>{};
//     final counts = <String, int>{};
//
//     for (var product in productList) {
//       final category = product.category ?? 'Uncategorized';
//       uniqueCategories.add(category);
//       counts[category] = (counts[category] ?? 0) + 1;
//     }
//
//     // Sort categories alphabetically
//     final sortedCategories = uniqueCategories.toList()..sort();
//     categories.value = ['All', ...sortedCategories]; // 'All' at top
//
//     // Add counts for 'All'
//     categoryCounts.value = {'All': productList.length, ...counts};
//   }
//
//   //  Filter products by category
//   void filterByCategory(String category) {
//     selectedCategory.value = category;
//
//     if (category == 'All') {
//       filteredProductList.value = List.from(productList);
//     } else {
//       filteredProductList.value = productList
//           .where((product) => product.category == category)
//           .toList();
//     }
//   }
//
//   //  Navigate to Product Detail
//   void goToProductDetail(ModelClass product) {
//     Get.to(
//       () => const ProductDetailView(),
//       arguments: product,
//       transition: Transition.rightToLeft,
//       duration: const Duration(milliseconds: 300),
//     );
//   }
//
//   Future<void> refreshProducts() async {
//     await fetchProducts();
//   }
//
//   //  Search Products (filter in current category)
//   void searchProducts(String query) {
//     if (query.isEmpty) {
//       filterByCategory(selectedCategory.value);
//     } else {
//       final sourceList = selectedCategory.value == 'All'
//           ? productList
//           : productList
//                 .where((p) => p.category == selectedCategory.value)
//                 .toList();
//
//       final filtered = sourceList.where((product) {
//         return product.title?.toLowerCase().contains(query.toLowerCase()) ??
//             false;
//       }).toList();
//
//       filteredProductList.value = filtered;
//     }
//   }
//
//   //  Add to Cart
//   void addToCart(Map<String, dynamic> productData) async {
//     try {
//       final response = await Functions.sendJson(
//         url: 'https://fakestoreapi.com/carts',
//         method: 'POST',
//         jsonMap: {
//           'userId': 1,
//           'date': DateTime.now().toIso8601String(),
//           'products': productData,
//         },
//       );
//
//       if (response is Map<String, dynamic> && response['DocType'] == 'Error') {
//         Get.snackbar(
//           'Error',
//           response['Message'] ?? 'Failed to add to cart',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red.shade100,
//           colorText: Colors.red.shade900,
//         );
//       } else {
//         Get.snackbar(
//           'Success! ',
//           'Product added to cart!',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green.shade100,
//           colorText: Colors.green.shade900,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to add to cart: ${e.toString()}',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
//
//   //  Get icon for category
//   IconData getCategoryIcon(String category) {
//     switch (category.toLowerCase()) {
//       case 'men\'s clothing':
//       case 'women\'s clothing':
//         return Icons.checkroom;
//       case 'jewelery':
//         return Icons.diamond;
//       case 'electronics':
//         return Icons.electrical_services;
//       default:
//         return Icons.category;
//     }
//   }
//
//   //  Get color for category
//   Color getCategoryColor(String category) {
//     switch (category.toLowerCase()) {
//       case 'men\'s clothing':
//         return Colors.blue;
//       case 'women\'s clothing':
//         return Colors.pink;
//       case 'jewelery':
//         return Colors.amber;
//       case 'electronics':
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }
// }

// import 'dart:developer' as developer;
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../Utilities_Screens/App_Model/app_model.dart';
// import '../../Utilities_Screens/Help_Function_Api/helping_function.dart';
// import '../Detail_Screen/detail_view.dart';
//
// class HomeController extends GetxController {
//   var productList = <ModelClass>[].obs;
//   var filteredProductList = <ModelClass>[].obs;
//   var isLoading = true.obs;
//   var isError = false.obs;
//   var errorMessage = ''.obs;
//
//   var selectedCategory = 'All'.obs;
//   var categories = <String>[].obs;
//   var categoryCounts = <String, int>{}.obs;
//   var imageIndex = 0.obs;
//
//   // NAYA - home screen promo banner/carousel
//   var banners = <BannerModel>[].obs;
//   var isBannersLoading = true.obs;
//
//   // NAYA - track kis kis image ka precache ho chuka hai
//   final Set<int> _precachedIndexes = {};
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchProducts();
//     fetchBanners(); // <-- naya
//     _changeImage();
//   }
//
//   @override
//   void onReady() {
//     super.onReady();
//     // context ab guaranteed available hai, yahan se precache shuru karein
//     _precacheAllImages();
//   }
//
//   // final List<String> shoppingImages = [
//   //   'https://images.unsplash.com/photo-1441986300917-64674bd600d8',
//   //   'https://images.unsplash.com/photo-1483985988355-763728e1935b',
//   //   'https://images.unsplash.com/photo-1472851294608-062f824d29cc',
//   //   'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da',
//   //   'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d',
//   //   'https://images.unsplash.com/photo-1519415943484-9fa1873496d4',
//   //   'https://loremflickr.com/800/600/shopping,bags',
//   //   'https://loremflickr.com/800/600/shopping,mall',
//   //   'https://loremflickr.com/800/600/clothes,shopping',
//   //   'https://loremflickr.com/800/600/online,shopping',
//   //   'https://loremflickr.com/800/600/shopping,cart',
//   //   'https://loremflickr.com/800/600/fashion,store',
//   //   'https://loremflickr.com/800/600/retail,shop',
//   //   'https://loremflickr.com/800/600/supermarket',
//   // ];
//
//   final List<String> shoppingImages = [
//     'https://images.unsplash.com/photo-1441986300917-64674bd600d8',
//     'https://images.unsplash.com/photo-1483985988355-763728e1935b',
//     'https://images.unsplash.com/photo-1472851294608-062f824d29cc',
//     'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da',
//     'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d',
//     'https://images.unsplash.com/photo-1519415943484-9fa1873496d4',
//     'https://picsum.photos/id/1005/800/600',
//     'https://picsum.photos/id/1011/800/600',
//     'https://picsum.photos/id/1027/800/600',
//     'https://picsum.photos/id/1035/800/600',
//     'https://picsum.photos/id/1043/800/600',
//     'https://picsum.photos/id/1050/800/600',
//     'https://picsum.photos/id/1062/800/600',
//     'https://picsum.photos/id/1074/800/600',
//   ];
//
//   void _changeImage() async {
//     while (true) {
//       await Future.delayed(const Duration(seconds: 7));
//       //imageIndex.value++;
//       imageIndex.value = (imageIndex.value + 1) % shoppingImages.length;
//     }
//   }
//
//   // NAYA - sab drawer images ko background mein precache karna
//   // taake switch hote waqt shimmer/flicker na dikhe
//   Future<void> _precacheAllImages() async {
//     final context = Get.context;
//     if (context == null) return;
//
//     for (int i = 0; i < shoppingImages.length; i++) {
//       if (_precachedIndexes.contains(i)) continue;
//       try {
//         await precacheImage(NetworkImage(shoppingImages[i]), context);
//         _precachedIndexes.add(i);
//       } catch (e) {
//         developer.log('Precache image error ($i): $e');
//       }
//     }
//   }
//
//   //copy to firebase
//   Future<void> fetchProducts() async {
//     try {
//       isLoading.value = true;
//       isError.value = false;
//       errorMessage.value = '';
//
//       final querySnapshot = await FirebaseFirestore.instance
//           .collection('products')
//           .get();
//
//       productList.value = querySnapshot.docs
//           .map((doc) => ModelClass.fromFirestore(doc))
//           .toList();
//
//       _extractCategories();
//       filterByCategory('All');
//     } catch (e) {
//       isError.value = true;
//       errorMessage.value = 'An error occurred: ${e.toString()}';
//       developer.log('FetchProducts Error: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//   //end of copy to firebase
//
//   // NAYA - Firestore se active banners fetch karna, order field se sort
//   Future<void> fetchBanners() async {
//     try {
//       isBannersLoading.value = true;
//       final snapshot = await FirebaseFirestore.instance
//           .collection('banners')
//           .where('isActive', isEqualTo: true)
//           .orderBy('order')
//           .get();
//
//       banners.value = snapshot.docs
//           .map((doc) => BannerModel.fromFirestore(doc))
//           .toList();
//     } catch (e) {
//       developer.log('FetchBanners Error: $e');
//     } finally {
//       isBannersLoading.value = false;
//     }
//   }
//
//   // NAYA - banner tap hone par kahan navigate karna hai
//   void handleBannerTap(BannerModel banner) {
//     switch (banner.actionType) {
//       case 'category':
//         filterByCategory(banner.actionValue ?? 'All');
//         break;
//       case 'product':
//         FirebaseFirestore.instance
//             .collection('products')
//             .doc(banner.actionValue)
//             .get()
//             .then((doc) {
//               if (doc.exists) {
//                 goToProductDetail(ModelClass.fromFirestore(doc));
//               }
//             });
//         break;
//       case 'url':
//         // agar external link kholni ho to url_launcher use karein
//         break;
//       default:
//         break;
//     }
//   }
//
//   void _extractCategories() {
//     final uniqueCategories = <String>{};
//     final counts = <String, int>{};
//
//     for (var product in productList) {
//       final category = product.category ?? 'Uncategorized';
//       uniqueCategories.add(category);
//       counts[category] = (counts[category] ?? 0) + 1;
//     }
//
//     // Sort categories alphabetically
//     final sortedCategories = uniqueCategories.toList()..sort();
//     categories.value = ['All', ...sortedCategories]; // 'All' at top
//
//     // Add counts for 'All'
//     categoryCounts.value = {'All': productList.length, ...counts};
//   }
//
//   //  Filter products by category
//   void filterByCategory(String category) {
//     selectedCategory.value = category;
//
//     if (category == 'All') {
//       filteredProductList.value = List.from(productList);
//     } else {
//       filteredProductList.value = productList
//           .where((product) => product.category == category)
//           .toList();
//     }
//   }
//
//   //  Navigate to Product Detail
//   void goToProductDetail(ModelClass product) {
//     Get.to(
//       () => const ProductDetailView(),
//       arguments: product,
//       transition: Transition.rightToLeft,
//       duration: const Duration(milliseconds: 300),
//     );
//   }
//
//   Future<void> refreshProducts() async {
//     await fetchProducts();
//   }
//
//   //  Search Products (filter in current category)
//   void searchProducts(String query) {
//     if (query.isEmpty) {
//       filterByCategory(selectedCategory.value);
//     } else {
//       final sourceList = selectedCategory.value == 'All'
//           ? productList
//           : productList
//                 .where((p) => p.category == selectedCategory.value)
//                 .toList();
//
//       final filtered = sourceList.where((product) {
//         return product.title?.toLowerCase().contains(query.toLowerCase()) ??
//             false;
//       }).toList();
//
//       filteredProductList.value = filtered;
//     }
//   }
//
//   //  Add to Cart
//   void addToCart(Map<String, dynamic> productData) async {
//     try {
//       final response = await Functions.sendJson(
//         url: 'https://fakestoreapi.com/carts',
//         method: 'POST',
//         jsonMap: {
//           'userId': 1,
//           'date': DateTime.now().toIso8601String(),
//           'products': productData,
//         },
//       );
//
//       if (response is Map<String, dynamic> && response['DocType'] == 'Error') {
//         Get.snackbar(
//           'Error',
//           response['Message'] ?? 'Failed to add to cart',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red.shade100,
//           colorText: Colors.red.shade900,
//         );
//       } else {
//         Get.snackbar(
//           'Success! ',
//           'Product added to cart!',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green.shade100,
//           colorText: Colors.green.shade900,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to add to cart: ${e.toString()}',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
//
//   //  Get icon for category
//   IconData getCategoryIcon(String category) {
//     switch (category.toLowerCase()) {
//       case 'men\'s clothing':
//       case 'women\'s clothing':
//         return Icons.checkroom;
//       case 'jewelery':
//         return Icons.diamond;
//       case 'electronics':
//         return Icons.electrical_services;
//       default:
//         return Icons.category;
//     }
//   }
//
//   //  Get color for category
//   Color getCategoryColor(String category) {
//     switch (category.toLowerCase()) {
//       case 'men\'s clothing':
//         return Colors.blue;
//       case 'women\'s clothing':
//         return Colors.pink;
//       case 'jewelery':
//         return Colors.amber;
//       case 'electronics':
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }
// }


import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utilities_Screens/App_Model/app_model.dart';
import '../../Utilities_Screens/Help_Function_Api/helping_function.dart';
import '../Detail_Screen/detail_view.dart';

class HomeController extends GetxController {
  var productList = <ModelClass>[].obs;
  var filteredProductList = <ModelClass>[].obs;
  var isLoading = true.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  var selectedCategory = 'All'.obs;
  var categories = <String>[].obs;
  var categoryCounts = <String, int>{}.obs;
  var imageIndex = 0.obs;

  // NAYA - home screen promo banner/carousel
  var banners = <BannerModel>[].obs;
  var isBannersLoading = true.obs;

  // NAYA - track kis kis image ka precache ho chuka hai
  final Set<int> _precachedIndexes = {};

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchBanners(); // <-- naya
    _changeImage();
  }

  @override
  void onReady() {
    super.onReady();
    // context ab guaranteed available hai, yahan se precache shuru karein
    _precacheAllImages();
  }

  final List<String> shoppingImages = [
    'https://images.unsplash.com/photo-1441986300917-64674bd600d8',
    'https://images.unsplash.com/photo-1483985988355-763728e1935b',
    'https://images.unsplash.com/photo-1472851294608-062f824d29cc',
    'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da',
    'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d',
    'https://images.unsplash.com/photo-1519415943484-9fa1873496d4',
    'https://picsum.photos/id/1005/800/600',
    'https://picsum.photos/id/1011/800/600',
    'https://picsum.photos/id/1027/800/600',
    'https://picsum.photos/id/1035/800/600',
    'https://picsum.photos/id/1043/800/600',
    'https://picsum.photos/id/1050/800/600',
    'https://picsum.photos/id/1062/800/600',
    'https://picsum.photos/id/1074/800/600',
  ];

  void _changeImage() async {
    while (true) {
      await Future.delayed(const Duration(seconds: 7));
      imageIndex.value = (imageIndex.value + 1) % shoppingImages.length;
    }
  }

  Future<void> _precacheAllImages() async {
    final context = Get.context;
    if (context == null) return;

    for (int i = 0; i < shoppingImages.length; i++) {
      if (_precachedIndexes.contains(i)) continue;
      try {
        await precacheImage(NetworkImage(shoppingImages[i]), context);
        _precachedIndexes.add(i);
      } catch (e) {
        developer.log('Precache image error ($i): $e');
      }
    }
  }

  //copy to firebase
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      isError.value = false;
      errorMessage.value = '';

      final querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .get();

      productList.value = querySnapshot.docs
          .map((doc) => ModelClass.fromFirestore(doc))
          .toList();

      _extractCategories();
      filterByCategory('All');
    } catch (e) {
      isError.value = true;
      errorMessage.value = 'An error occurred: ${e.toString()}';
      developer.log('FetchProducts Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
  //end of copy to firebase

  // NAYA - Firestore se active banners fetch karna, order field se sort
  Future<void> fetchBanners() async {
    try {
      isBannersLoading.value = true;
      final snapshot = await FirebaseFirestore.instance
          .collection('banners')
          .where('isActive', isEqualTo: true)
          .orderBy('order')
          .get();

      banners.value = snapshot.docs
          .map((doc) => BannerModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      developer.log('FetchBanners Error: $e');
    } finally {
      isBannersLoading.value = false;
    }
  }

  // NAYA - banner tap hone par kahan navigate karna hai
  void handleBannerTap(BannerModel banner) {
    switch (banner.actionType) {
      case 'category':
        filterByCategory(banner.actionValue ?? 'All');
        break;
      case 'product':
        FirebaseFirestore.instance
            .collection('products')
            .doc(banner.actionValue)
            .get()
            .then((doc) {
          if (doc.exists) {
            goToProductDetail(ModelClass.fromFirestore(doc));
          }
        });
        break;
      case 'url':
      // agar external link kholni ho to url_launcher use karein
        break;
      default:
        break;
    }
  }

  void _extractCategories() {
    final uniqueCategories = <String>{};
    final counts = <String, int>{};

    for (var product in productList) {
      final category = product.category ?? 'Uncategorized';
      uniqueCategories.add(category);
      counts[category] = (counts[category] ?? 0) + 1;
    }

    // Sort categories alphabetically
    final sortedCategories = uniqueCategories.toList()..sort();
    categories.value = ['All', ...sortedCategories]; // 'All' at top

    // Add counts for 'All'
    categoryCounts.value = {'All': productList.length, ...counts};
  }

  //  Filter products by category
  void filterByCategory(String category) {
    selectedCategory.value = category;

    if (category == 'All') {
      filteredProductList.value = List.from(productList);
    } else {
      filteredProductList.value = productList
          .where((product) => product.category == category)
          .toList();
    }
  }

  //  Navigate to Product Detail
  void goToProductDetail(ModelClass product) {
    Get.to(
          () => const ProductDetailView(),
      arguments: product,
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );
  }

  Future<void> refreshProducts() async {
    await fetchProducts();
  }

  // Title/query se space, hyphen, apostrophe, dot hata kar lowercase karta
  // hai, taake "tshirt", "t-shirt", "T Shirt" sab match ho jayein.
  String _normalize(String s) =>
      s.toLowerCase().replaceAll(RegExp(r"[\s\-'’.]"), '');

  //  Search Products (filter in current category)
  void searchProducts(String query) {
    if (query.isEmpty) {
      filterByCategory(selectedCategory.value);
    } else {
      final sourceList = selectedCategory.value == 'All'
          ? productList
          : productList
          .where((p) => p.category == selectedCategory.value)
          .toList();

      final normalizedQuery = _normalize(query);

      final filtered = sourceList.where((product) {
        final title = product.title ?? '';
        return _normalize(title).contains(normalizedQuery);
      }).toList();

      filteredProductList.value = filtered;
    }
  }

  //  Add to Cart
  void addToCart(Map<String, dynamic> productData) async {
    try {
      final response = await Functions.sendJson(
        url: 'https://fakestoreapi.com/carts',
        method: 'POST',
        jsonMap: {
          'userId': 1,
          'date': DateTime.now().toIso8601String(),
          'products': productData,
        },
      );

      if (response is Map<String, dynamic> && response['DocType'] == 'Error') {
        Get.snackbar(
          'Error',
          response['Message'] ?? 'Failed to add to cart',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade900,
        );
      } else {
        Get.snackbar(
          'Success! ',
          'Product added to cart!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade900,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add to cart: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  //  Get icon for category
  IconData getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'men\'s clothing':
      case 'women\'s clothing':
        return Icons.checkroom;
      case 'jewelery':
        return Icons.diamond;
      case 'electronics':
        return Icons.electrical_services;
      default:
        return Icons.category;
    }
  }

  //  Get color for category
  Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'men\'s clothing':
        return Colors.blue;
      case 'women\'s clothing':
        return Colors.pink;
      case 'jewelery':
        return Colors.amber;
      case 'electronics':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}