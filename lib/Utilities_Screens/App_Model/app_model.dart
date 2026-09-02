// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ModelClass {
//   String? id; // ab int nahi, String (Firestore document ID)
//   String? title;
//   double? price;
//   double? discountPrice; // naya field - sale/discount price (optional)
//   String? description;
//   String? category;
//   String? image;
//   int? stock; // naya field - stock quantity
//   Rating? rating;
//   List<PriceTier> priceTiers; // NAYA - bundle/quantity discount tiers
//
//   ModelClass({
//     this.id,
//     this.title,
//     this.price,
//     this.discountPrice,
//     this.description,
//     this.category,
//     this.image,
//     this.stock,
//     this.rating,
//     this.priceTiers = const [], // NAYA - default empty rahe ga
//   });
//
//   // Firestore se document parse karne ke liye
//   factory ModelClass.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return ModelClass(
//       id: doc.id,
//       title: data['title'] ?? 'No Title',
//       price: _toDouble(data['price']),
//       discountPrice: data['discountPrice'] != null
//           ? _toDouble(data['discountPrice'])
//           : null,
//       description: data['description'] ?? 'No description available',
//       category: data['category'] ?? 'Uncategorized',
//       image: data['image'] ?? '',
//       stock: data['stock'] ?? 0,
//       rating: data['rating'] != null
//           ? Rating.fromJson(data['rating'])
//           : Rating(rate: 0.0, count: 0),
//       priceTiers:
//           data['priceTiers'] !=
//               null // NAYA
//           ? (data['priceTiers'] as List)
//                 .map((t) => PriceTier.fromMap(t))
//                 .toList()
//           : [],
//     );
//   }
//
//   static double _toDouble(dynamic value) {
//     if (value == null) return 0.0;
//     if (value is int) return value.toDouble();
//     if (value is double) return value;
//     if (value is String) return double.tryParse(value) ?? 0.0;
//     return 0.0;
//   }
//
//   // Firestore mein save karne ke liye
//   Map<String, dynamic> toFirestore() {
//     return {
//       'title': title,
//       'price': price,
//       'discountPrice': discountPrice,
//       'description': description,
//       'category': category,
//       'image': image,
//       'stock': stock,
//       'rating': rating?.toJson(),
//       'priceTiers': priceTiers.map((t) => t.toMap()).toList(), // NAYA
//     };
//   }
//
//   // Local storage (SharedPreferences) ke liye - Wishlist mein use hota hai
//   factory ModelClass.fromJson(Map<String, dynamic> json) {
//     return ModelClass(
//       id: json['id']?.toString(),
//       title: json['title'],
//       price: _toDouble(json['price']),
//       discountPrice: json['discountPrice'] != null
//           ? _toDouble(json['discountPrice'])
//           : null,
//       description: json['description'],
//       category: json['category'],
//       image: json['image'],
//       stock: json['stock'],
//       rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null,
//       priceTiers:
//           json['priceTiers'] !=
//               null // NAYA
//           ? (json['priceTiers'] as List)
//                 .map((t) => PriceTier.fromMap(t))
//                 .toList()
//           : [],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'price': price,
//       'discountPrice': discountPrice,
//       'description': description,
//       'category': category,
//       'image': image,
//       'stock': stock,
//       'rating': rating?.toJson(),
//       'priceTiers': priceTiers.map((t) => t.toMap()).toList(), // NAYA
//     };
//   }
// }
//
// class Rating {
//   double? rate;
//   int? count;
//
//   Rating({this.rate, this.count});
//
//   factory Rating.fromJson(Map<String, dynamic> json) {
//     return Rating(
//       rate: (json['rate'] ?? 0).toDouble(),
//       count: json['count'] ?? 0,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'rate': rate, 'count': count};
//   }
// }
//
// // NAYI CLASS - bundle/quantity discount ke liye
// class PriceTier {
//   int minQty; // kitni quantity par ye price lagu ho
//   double price; // us quantity par per-unit price
//
//   PriceTier({required this.minQty, required this.price});
//
//   factory PriceTier.fromMap(Map<String, dynamic> map) {
//     return PriceTier(
//       minQty: map['minQty'] ?? 1,
//       price: ModelClass._toDouble(map['price']),
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {'minQty': minQty, 'price': price};
//   }
// }
//
// // NAYI CLASS - home screen promo banner/carousel ke liye
// class BannerModel {
//   String? id;
//   String? imageUrl;
//   String? title;
//   String? discountText;
//   String actionType; // "category" | "product" | "url" | "none"
//   String? actionValue;
//   bool isActive;
//   int order;
//
//   BannerModel({
//     this.id,
//     this.imageUrl,
//     this.title,
//     this.discountText,
//     this.actionType = 'none',
//     this.actionValue,
//     this.isActive = true,
//     this.order = 0,
//   });
//
//   factory BannerModel.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return BannerModel(
//       id: doc.id,
//       imageUrl: data['imageUrl'] ?? '',
//       title: data['title'] ?? '',
//       discountText: data['discountText'] ?? '',
//       actionType: data['actionType'] ?? 'none',
//       actionValue: data['actionValue'],
//       isActive: data['isActive'] ?? true,
//       order: data['order'] ?? 0,
//     );
//   }
//
//   Map<String, dynamic> toFirestore() {
//     return {
//       'imageUrl': imageUrl,
//       'title': title,
//       'discountText': discountText,
//       'actionType': actionType,
//       'actionValue': actionValue,
//       'isActive': isActive,
//       'order': order,
//     };
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ModelClass {
//   String? id;
//   String? title;
//   double? price;
//   double? discountPrice;
//   String? description;
//   String? category;
//   String? image;
//   int? stock;
//   Rating? rating;
//   List<PriceTier> priceTiers;
//   List<ProductSize> sizes; // NAYA - available sizes (S/M/L ya 38/39/40 wagera)
//
//   ModelClass({
//     this.id,
//     this.title,
//     this.price,
//     this.discountPrice,
//     this.description,
//     this.category,
//     this.image,
//     this.stock,
//     this.rating,
//     this.priceTiers = const [],
//     this.sizes = const [], // NAYA
//   });
//
//   factory ModelClass.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return ModelClass(
//       id: doc.id,
//       title: data['title'] ?? 'No Title',
//       price: _toDouble(data['price']),
//       discountPrice: data['discountPrice'] != null
//           ? _toDouble(data['discountPrice'])
//           : null,
//       description: data['description'] ?? 'No description available',
//       category: data['category'] ?? 'Uncategorized',
//       image: data['image'] ?? '',
//       stock: data['stock'] ?? 0,
//       rating: data['rating'] != null
//           ? Rating.fromJson(data['rating'])
//           : Rating(rate: 0.0, count: 0),
//       priceTiers: data['priceTiers'] != null
//           ? (data['priceTiers'] as List)
//                 .map((t) => PriceTier.fromMap(t))
//                 .toList()
//           : [],
//       sizes:
//           data['sizes'] !=
//               null // NAYA
//           ? (data['sizes'] as List).map((s) => ProductSize.fromMap(s)).toList()
//           : [],
//     );
//   }
//
//   static double _toDouble(dynamic value) {
//     if (value == null) return 0.0;
//     if (value is int) return value.toDouble();
//     if (value is double) return value;
//     if (value is String) return double.tryParse(value) ?? 0.0;
//     return 0.0;
//   }
//
//   Map<String, dynamic> toFirestore() {
//     return {
//       'title': title,
//       'price': price,
//       'discountPrice': discountPrice,
//       'description': description,
//       'category': category,
//       'image': image,
//       'stock': stock,
//       'rating': rating?.toJson(),
//       'priceTiers': priceTiers.map((t) => t.toMap()).toList(),
//       'sizes': sizes.map((s) => s.toMap()).toList(), // NAYA
//     };
//   }
//
//   factory ModelClass.fromJson(Map<String, dynamic> json) {
//     return ModelClass(
//       id: json['id']?.toString(),
//       title: json['title'],
//       price: _toDouble(json['price']),
//       discountPrice: json['discountPrice'] != null
//           ? _toDouble(json['discountPrice'])
//           : null,
//       description: json['description'],
//       category: json['category'],
//       image: json['image'],
//       stock: json['stock'],
//       rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null,
//       priceTiers: json['priceTiers'] != null
//           ? (json['priceTiers'] as List)
//                 .map((t) => PriceTier.fromMap(t))
//                 .toList()
//           : [],
//       sizes:
//           json['sizes'] !=
//               null // NAYA
//           ? (json['sizes'] as List).map((s) => ProductSize.fromMap(s)).toList()
//           : [],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'price': price,
//       'discountPrice': discountPrice,
//       'description': description,
//       'category': category,
//       'image': image,
//       'stock': stock,
//       'rating': rating?.toJson(),
//       'priceTiers': priceTiers.map((t) => t.toMap()).toList(),
//       'sizes': sizes.map((s) => s.toMap()).toList(), // NAYA
//     };
//   }
// }
//
// class Rating {
//   double? rate;
//   int? count;
//
//   Rating({this.rate, this.count});
//
//   factory Rating.fromJson(Map<String, dynamic> json) {
//     return Rating(
//       rate: (json['rate'] ?? 0).toDouble(),
//       count: json['count'] ?? 0,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'rate': rate, 'count': count};
//   }
// }
//
// class PriceTier {
//   int minQty;
//   double price;
//
//   PriceTier({required this.minQty, required this.price});
//
//   factory PriceTier.fromMap(Map<String, dynamic> map) {
//     return PriceTier(
//       minQty: map['minQty'] ?? 1,
//       price: ModelClass._toDouble(map['price']),
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {'minQty': minQty, 'price': price};
//   }
// }
//
// // NAYI CLASS - product size aur uska stock
// class ProductSize {
//   String label; // e.g. "S", "M", "L", "42"
//   int stock; // is size ka available stock, 0 = out of stock
//
//   ProductSize({required this.label, this.stock = 0});
//
//   factory ProductSize.fromMap(Map<String, dynamic> map) {
//     return ProductSize(label: map['label'] ?? '', stock: map['stock'] ?? 0);
//   }
//
//   Map<String, dynamic> toMap() {
//     return {'label': label, 'stock': stock};
//   }
// }
//
// class BannerModel {
//   String? id;
//   String? imageUrl;
//   String? title;
//   String? discountText;
//   String actionType;
//   String? actionValue;
//   bool isActive;
//   int order;
//
//   BannerModel({
//     this.id,
//     this.imageUrl,
//     this.title,
//     this.discountText,
//     this.actionType = 'none',
//     this.actionValue,
//     this.isActive = true,
//     this.order = 0,
//   });
//
//   factory BannerModel.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return BannerModel(
//       id: doc.id,
//       imageUrl: data['imageUrl'] ?? '',
//       title: data['title'] ?? '',
//       discountText: data['discountText'] ?? '',
//       actionType: data['actionType'] ?? 'none',
//       actionValue: data['actionValue'],
//       isActive: data['isActive'] ?? true,
//       order: data['order'] ?? 0,
//     );
//   }
//
//   Map<String, dynamic> toFirestore() {
//     return {
//       'imageUrl': imageUrl,
//       'title': title,
//       'discountText': discountText,
//       'actionType': actionType,
//       'actionValue': actionValue,
//       'isActive': isActive,
//       'order': order,
//     };
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class ModelClass {
  String? id;
  String? title;
  double? price;
  double? discountPrice;
  String? description;
  String? category;
  String? image;
  int? stock;
  Rating? rating;

  List<PriceTier> priceTiers;

  // Product sizes:
  // S / M / L / XL ya 38 / 39 / 40
  List<ProductSize> sizes;

  ModelClass({
    this.id,
    this.title,
    this.price,
    this.discountPrice,
    this.description,
    this.category,
    this.image,
    this.stock,
    this.rating,
    this.priceTiers = const [],
    this.sizes = const [],
  });

  factory ModelClass.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ModelClass(
      id: doc.id,
      title: data['title'] ?? 'No Title',

      price: _toDouble(data['price']),

      discountPrice: data['discountPrice'] != null
          ? _toDouble(data['discountPrice'])
          : null,

      description: data['description'] ?? 'No description available',

      category: data['category'] ?? 'Uncategorized',

      image: data['image'] ?? '',

      stock: data['stock'] ?? 0,

      rating: data['rating'] != null
          ? Rating.fromJson(Map<String, dynamic>.from(data['rating']))
          : Rating(rate: 0.0, count: 0),

      priceTiers: data['priceTiers'] != null
          ? (data['priceTiers'] as List)
                .map((t) => PriceTier.fromMap(Map<String, dynamic>.from(t)))
                .toList()
          : [],

      sizes: data['sizes'] != null
          ? (data['sizes'] as List)
                .map((s) => ProductSize.fromMap(Map<String, dynamic>.from(s)))
                .toList()
          : [],
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;

    if (value is int) {
      return value.toDouble();
    }

    if (value is double) {
      return value;
    }

    if (value is num) {
      return value.toDouble();
    }

    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }

    return 0.0;
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'price': price,
      'discountPrice': discountPrice,
      'description': description,
      'category': category,
      'image': image,
      'stock': stock,
      'rating': rating?.toJson(),

      'priceTiers': priceTiers.map((t) => t.toMap()).toList(),

      'sizes': sizes.map((s) => s.toMap()).toList(),
    };
  }

  factory ModelClass.fromJson(Map<String, dynamic> json) {
    return ModelClass(
      id: json['id']?.toString(),

      title: json['title'],

      price: _toDouble(json['price']),

      discountPrice: json['discountPrice'] != null
          ? _toDouble(json['discountPrice'])
          : null,

      description: json['description'],

      category: json['category'],

      image: json['image'],

      stock: json['stock'],

      rating: json['rating'] != null
          ? Rating.fromJson(Map<String, dynamic>.from(json['rating']))
          : null,

      priceTiers: json['priceTiers'] != null
          ? (json['priceTiers'] as List)
                .map((t) => PriceTier.fromMap(Map<String, dynamic>.from(t)))
                .toList()
          : [],

      sizes: json['sizes'] != null
          ? (json['sizes'] as List)
                .map((s) => ProductSize.fromMap(Map<String, dynamic>.from(s)))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'discountPrice': discountPrice,
      'description': description,
      'category': category,
      'image': image,
      'stock': stock,
      'rating': rating?.toJson(),

      'priceTiers': priceTiers.map((t) => t.toMap()).toList(),

      'sizes': sizes.map((s) => s.toMap()).toList(),
    };
  }
}

// =====================================================
// RATING
// =====================================================

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: ModelClass._toDouble(json['rate']),
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'rate': rate, 'count': count};
  }
}

// =====================================================
// PRICE TIER
// =====================================================

class PriceTier {
  int minQty;
  double price;

  PriceTier({required this.minQty, required this.price});

  factory PriceTier.fromMap(Map<String, dynamic> map) {
    return PriceTier(
      minQty: map['minQty'] ?? 1,
      price: ModelClass._toDouble(map['price']),
    );
  }

  Map<String, dynamic> toMap() {
    return {'minQty': minQty, 'price': price};
  }
}

// =====================================================
// PRODUCT SIZE
// =====================================================
//
// Ab har size ka:
// label
// stock
// price
//
// alag ho sakta hai.
//
// Example:
// S  -> Rs 900  -> stock 10
// M  -> Rs 950  -> stock 8
// L  -> Rs 1000 -> stock 5
//

class ProductSize {
  String label;
  int stock;
  double price;

  ProductSize({required this.label, this.stock = 0, this.price = 0.0});

  factory ProductSize.fromMap(Map<String, dynamic> map) {
    return ProductSize(
      label: map['label'] ?? '',
      stock: map['stock'] ?? 0,
      price: ModelClass._toDouble(map['price']),
    );
  }

  Map<String, dynamic> toMap() {
    return {'label': label, 'stock': stock, 'price': price};
  }
}

// =====================================================
// BANNER MODEL
// =====================================================

class BannerModel {
  String? id;
  String? imageUrl;
  String? title;
  String? discountText;
  String actionType;
  String? actionValue;
  bool isActive;
  int order;

  BannerModel({
    this.id,
    this.imageUrl,
    this.title,
    this.discountText,
    this.actionType = 'none',
    this.actionValue,
    this.isActive = true,
    this.order = 0,
  });

  factory BannerModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return BannerModel(
      id: doc.id,
      imageUrl: data['imageUrl'] ?? '',
      title: data['title'] ?? '',
      discountText: data['discountText'] ?? '',
      actionType: data['actionType'] ?? 'none',
      actionValue: data['actionValue'],
      isActive: data['isActive'] ?? true,
      order: data['order'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'discountText': discountText,
      'actionType': actionType,
      'actionValue': actionValue,
      'isActive': isActive,
      'order': order,
    };
  }
}
