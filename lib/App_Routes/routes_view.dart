import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:snapkart/Snapkart_App_Screens/About_Us/about_bind.dart';
import 'package:snapkart/Snapkart_App_Screens/About_Us/about_view.dart';
import 'package:snapkart/Snapkart_App_Screens/Add_Address/address_binding.dart';
import 'package:snapkart/Snapkart_App_Screens/Add_Address/address_view.dart';
import 'package:snapkart/Snapkart_App_Screens/Cart_Screen/cart_binding.dart';
import 'package:snapkart/Snapkart_App_Screens/Cart_Screen/cart_view.dart';
import 'package:snapkart/Snapkart_App_Screens/Detail_Screen/detail_binding.dart';
import 'package:snapkart/Snapkart_App_Screens/Fetch_Profile/fetch_binding.dart';
import 'package:snapkart/Snapkart_App_Screens/Fetch_Profile/fetch_profile.dart';
import 'package:snapkart/Snapkart_App_Screens/History_Screen/History_Binding.dart';
import 'package:snapkart/Snapkart_App_Screens/History_Screen/History_View.dart';
import 'package:snapkart/Snapkart_App_Screens/Home_Screen/search_result_view.dart';
import 'package:snapkart/Snapkart_App_Screens/Login_Screen/login_bind.dart';
import 'package:snapkart/Snapkart_App_Screens/Login_Screen/login_view.dart';
import 'package:snapkart/Snapkart_App_Screens/Order_Detail/orderdetail_binding.dart';
import 'package:snapkart/Snapkart_App_Screens/Order_Detail/orderdetail_view.dart';
import 'package:snapkart/Snapkart_App_Screens/Setting_Screen/setting_binding.dart';
import 'package:snapkart/Snapkart_App_Screens/Setting_Screen/setting_view.dart';
import 'package:snapkart/Snapkart_App_Screens/Signup_Screen/signup_bind.dart';
import 'package:snapkart/Snapkart_App_Screens/Signup_Screen/signup_view.dart';
import 'package:snapkart/Snapkart_App_Screens/Wishlist_Screen/wishlist_binding.dart';
import 'package:snapkart/Snapkart_App_Screens/Wishlist_Screen/wishlist_view.dart';

import '../Snapkart_App_Screens/Detail_Screen/detail_view.dart';
import '../Snapkart_App_Screens/Home_Screen/home_binding.dart';
import '../Snapkart_App_Screens/Home_Screen/home_view.dart';
import '../Snapkart_App_Screens/Order_Checkout/checkout_binding.dart';
import '../Snapkart_App_Screens/Order_Checkout/checkout_view.dart';
import '../Snapkart_App_Screens/Order_Place/order_binding.dart';
import '../Snapkart_App_Screens/Order_Place/order_view.dart';
import '../Snapkart_App_Screens/Splash_Screen/Splash_View.dart';
import '../Snapkart_App_Screens/Splash_Screen/splash_binding.dart';

class AppRoutes {
  static const String initial = '/initial';
  static const String home = '/home';
  static const String searchresult = '/searchresult';
  static const String productdetail = '/productdetail';
  static const String checkout = '/checkout';
  static const String ordercheck = '/ordercheck';
  static const String orderdetail = '/orderdetail';
  static const String setting = '/setting';
  static const String address = '/address';
  static const String login = '/login';
  static const String signup = '/signup';

  static const String cart = '/cart';
  static const String about = '/about';
  static const String profilefetch = '/profilefetch';
  static const String wishlist = '/wishlist';
  static const String history = '/history';

  static final routes = [
    GetPage(name: initial, page: () => SplashView(), binding: SplashBinding()),
    GetPage(name: home, page: () => HomeView(), binding: HomeBinding()),
    GetPage(name: searchresult, page: () => SearchResultsView()),
    GetPage(
      name: productdetail,
      page: () => ProductDetailView(),
      binding: DetailBinding(),
    ),

    GetPage(
      name: checkout,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(name: ordercheck, page: () => OrderView(), binding: OrderBinding()),
    GetPage(
      name: orderdetail,
      page: () => OrderdetailView(),
      binding: OrderdetailBinding(),
    ),

    GetPage(
      name: setting,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),

    GetPage(
      name: address,
      page: () => AddAddressView(),
      binding: AddressBinding(),
    ),

    GetPage(name: login, page: () => LoginView(), binding: LoginBinding()),
    GetPage(name: cart, page: () => CartView(), binding: CartBinding()),
    GetPage(name: about, page: () => AboutView(), binding: AboutBinding()),
    GetPage(
      name: profilefetch,
      page: () => FetchView(),
      binding: FetchBinding(),
    ),
    GetPage(
      name: wishlist,
      page: () => WishlistView(),
      binding: WishlistBinding(),
    ),
    GetPage(
      name: history,
      page: () => HistoryView(),
      binding: HistoryBinding(),
    ),

    GetPage(name: signup, page: () => SignupView(), binding: SignupBind()),
  ];
}
