import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/Currency_Service/currency_service.dart';
import '../Home_Screen/home_controller.dart';

class SearchResultsView extends StatefulWidget {
  const SearchResultsView({super.key});

  @override
  State<SearchResultsView> createState() => _SearchResultsViewState();
}

class _SearchResultsViewState extends State<SearchResultsView> {
  late TextEditingController _searchCtrl;
  late String _query;
  final HomeController controller = Get.find<HomeController>();

  String _normalize(String s) =>
      s.toLowerCase().replaceAll(RegExp(r"[\s\-'’.]"), '');

  @override
  void initState() {
    super.initState();
    _query = Get.arguments as String? ?? '';
    _searchCtrl = TextEditingController(text: _query);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _query = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final normalizedQuery = _normalize(_query);

    final results = controller.productList.where((product) {
      final title = product.title ?? '';
      return _normalize(title).contains(normalizedQuery);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.cardBackground(context),
        foregroundColor: AppColors.textPrimary(context),
        automaticallyImplyLeading: true, // sirf back button, drawer nahi
        titleSpacing: 0,
        title: Container(
          height: 40,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: AppColors.background(context),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            controller: _searchCtrl,
            autofocus: false,
            textInputAction: TextInputAction.search,
            onChanged: _onSearchChanged,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary(context),
            ),
            decoration: InputDecoration(
              isDense: true,
              hintText: 'type_product_name'.tr,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              prefixIcon: const Icon(Icons.search, size: 20),
              suffixIcon: _searchCtrl.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: () {
                        _searchCtrl.clear();
                        _onSearchChanged('');
                      },
                    )
                  : null,
            ),
          ),
        ),
        // Note: no cart icon, no drawer icon here - only back + search field
      ),
      body: results.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text(
                    'no_products_found'.tr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary(context),
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.65,
                ),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final product = results[index];
                  return GestureDetector(
                    onTap: () => controller.goToProductDetail(product),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground(context),
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
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Image.network(
                                product.image ?? '',
                                fit: BoxFit.contain,
                                width: double.infinity,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.broken_image, size: 50),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary(context),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                ValueListenableBuilder<String>(
                                  valueListenable:
                                      CurrencyService.instance.symbol,
                                  builder: (context, currency, _) {
                                    return Text(
                                      '$currency ${product.price?.toStringAsFixed(0) ?? '0'}',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepOrange,
                                      ),
                                    );
                                  },
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
    );
  }
}
