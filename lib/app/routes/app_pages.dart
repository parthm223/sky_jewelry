import 'package:get/get.dart';
import 'package:sky_jewelry/app/views/addresses_view.dart';
import 'package:sky_jewelry/app/views/auth/otp_verification.dart';
import 'package:sky_jewelry/app/views/cart_view.dart';
import 'package:sky_jewelry/app/views/categories_view.dart';
import 'package:sky_jewelry/app/views/checkout_view.dart';
import 'package:sky_jewelry/app/views/home_view.dart';
import 'package:sky_jewelry/app/views/metals_view.dart';
import 'package:sky_jewelry/app/views/orders_view.dart';
import 'package:sky_jewelry/app/views/payment_method_view.dart';
import 'package:sky_jewelry/app/views/policy/about_us_view.dart';
import 'package:sky_jewelry/app/views/policy/privacy_policy_view.dart';
import 'package:sky_jewelry/app/views/policy/return_refund_view.dart';
import 'package:sky_jewelry/app/views/policy/shipping_policy_view.dart';
import 'package:sky_jewelry/app/views/policy/terms_conditions_view.dart';
import 'package:sky_jewelry/app/views/product_view.dart';
import 'package:sky_jewelry/app/views/profile_view.dart';
import 'package:sky_jewelry/app/views/search_view.dart';
import 'package:sky_jewelry/app/views/splash_view.dart';
import 'package:sky_jewelry/app/views/support_view.dart';
import 'package:sky_jewelry/app/views/wishlist_view.dart';

import '../views/auth/login_view.dart';
import '../views/auth/register_view.dart';

import '../bindings/home_binding.dart';
import '../bindings/product_binding.dart';
import '../bindings/auth_binding.dart';
import '../bindings/metals_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => const SplashView()),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(name: AppRoutes.categories, page: () => const CategoriesView()),
    GetPage(
      name: AppRoutes.metals,
      page: () => const MetalsView(),
      binding: MetalsBinding(),
    ),
    GetPage(
      name: AppRoutes.product,
      page: () => const ProductView(),
      binding: ProductBinding(),
    ),
    GetPage(name: AppRoutes.cart, page: () => const CartView()),
    GetPage(name: AppRoutes.checkout, page: () => const CheckoutView()),
    GetPage(name: AppRoutes.wishlist, page: () => const WishlistView()),
    GetPage(name: AppRoutes.profile, page: () => const ProfileView()),
    GetPage(name: AppRoutes.addresses, page: () => const AddressesView()),
    GetPage(
      name: AppRoutes.paymentMethods,
      page: () => const PaymentMethodView(),
    ),
    GetPage(name: AppRoutes.search, page: () => const SearchView()),
    GetPage(name: AppRoutes.orders, page: () => const OrdersView()),
    GetPage(name: AppRoutes.support, page: () => const SupportView()),
    GetPage(name: AppRoutes.aboutUs, page: () => const AboutUsView()),
    GetPage(
      name: AppRoutes.privacyPolicy,
      page: () => const PrivacyPolicyView(),
    ),
    GetPage(
      name: AppRoutes.returnRefundPolicy,
      page: () => const ReturnRefundPolicyView(),
    ),
    GetPage(
      name: AppRoutes.shippingPolicy,
      page: () => const ShippingPolicyView(),
    ),
    GetPage(
      name: AppRoutes.termsConditions,
      page: () => const TermsConditionsView(),
    ),
    GetPage(name: '/otp-verification', page: () => OTPVerificationView()),
  ];
}
