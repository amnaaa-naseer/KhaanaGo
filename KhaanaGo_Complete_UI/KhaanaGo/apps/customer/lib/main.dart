import 'package:flutter/material.dart';
import 'package:khaana_design/khaana_design.dart';

import 'src/checkout.dart';
import 'src/p2_screens.dart';
import 'src/p3_screens.dart';
import 'src/scope.dart';
import 'src/screens.dart';
import 'src/session.dart';
import 'src/tracking.dart';

void main() {
  runApp(const CustomerApp());
}

class CustomerApp extends StatefulWidget {
  const CustomerApp({super.key});

  @override
  State<CustomerApp> createState() => _CustomerAppState();
}

class _CustomerAppState extends State<CustomerApp> {
  final _session = CustomerSession();

  @override
  void dispose() {
    _session.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomerScope(
      session: _session,
      child: MaterialApp(
        title: 'KhaanaGo',
        theme: khaanaTheme(KhaanaThemeKind.light),
        initialRoute: '/login',
        onGenerateRoute: _route,
      ),
    );
  }

  Route<void> _route(RouteSettings settings) {
    final arg = settings.arguments as String?;
    final page = switch (settings.name) {
      '/launch' => const CustomerAppLaunchScreen(),
      '/vendor-info' => const VendorInfoReviewsScreen(),
      '/complaint-status' => const ComplaintStatusScreen(),
      '/not-found' => const PageNotFoundScreen(homeRoute: '/home', portalLabel: 'Return to Customer Home'),
      '/error' => const SomethingWentWrongScreen(),
      '/register' => const RegistrationScreen(),
      '/verify' => const VerificationCodeScreen(),
      '/reset-request' => const ResetPasswordRequestScreen(),
      '/reset-confirm' => const ResetPasswordConfirmScreen(),
      '/profile' => const CustomerProfileScreen(),
      '/profile/edit' => const EditProfileScreen(),
      '/addresses' => const SavedAddressesScreen(),
      '/addresses/edit' => EditAddressScreen(existingAddress: arg),
      '/search' => const SearchResultsScreen(),
      '/revised-quote' => const RevisedQuoteApprovalScreen(),
      '/payment-handoff' => const PaymentGatewayHandoffScreen(),
      '/payment-failed' => const PaymentFailedScreen(),
      '/notifications' => const NotificationCentreScreen(),
      '/orders' => const OrderHistoryScreen(),
      '/order-detail' => OrderDetailInvoiceScreen(orderId: arg),
      '/rating' => RatingScreen(orderId: arg),
      '/complaint' => CustomerComplaintFormScreen(orderId: arg),
      '/assistant' => const AssistantChatScreen(),
      '/voice-order' => const VoiceOrderScreen(),
      '/responsive-web' => const ResponsiveWebLayoutsScreen(),
      '/home' => const HomeScreen(),
      '/menu' => const MenuScreen(),
      '/item' => ItemScreen(dishId: arg ?? 'cake'),
      '/customize' => CustomizeScreen(dishId: arg ?? 'cake'),
      '/cart' => const CartScreen(),
      '/delivery' => const DeliveryTypeScreen(),
      '/slots' => const SlotScreen(),
      '/payment' => const PaymentScreen(),
      '/review' => const ReviewScreen(),
      '/placed' => const PlacedScreen(),
      '/tracking' => const TrackingScreen(),
      '/delay' => const DelayScreen(),
      _ => const LoginScreen(),
    };
    return MaterialPageRoute<void>(builder: (_) => page, settings: settings);
  }
}
