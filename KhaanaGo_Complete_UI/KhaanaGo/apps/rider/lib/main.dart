import 'package:flutter/material.dart';
import 'package:khaana_design/khaana_design.dart';

import 'src/p2_screens.dart';
import 'src/p3_screens.dart';
import 'src/scope.dart';
import 'src/screens.dart';
import 'src/session.dart';

void main() {
  runApp(const RiderApp());
}

class RiderApp extends StatefulWidget {
  const RiderApp({super.key});

  @override
  State<RiderApp> createState() => _RiderAppState();
}

class _RiderAppState extends State<RiderApp> {
  final _session = RiderSession();

  @override
  void dispose() {
    _session.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RiderScope(
      session: _session,
      child: MaterialApp(
        title: 'KhaanaGo Rider',
        theme: khaanaTheme(KhaanaThemeKind.rider),
        initialRoute: '/sign-in',
        onGenerateRoute: _route,
      ),
    );
  }

  Route<void> _route(RouteSettings settings) {
    final page = switch (settings.name) {
      '/launch' => const RiderAppLaunchScreen(),
      '/reset-request' => const RiderResetPasswordRequestScreen(),
      '/reset-confirm' => const RiderResetPasswordConfirmScreen(),
      '/audio-settings' => const AudioPromptSettingsScreen(),
      '/reg-1' => const RiderRegStep1Screen(),
      '/reg-2' => const RiderRegStep2Screen(),
      '/reg-3' => const RiderRegStep3Screen(),
      '/pending-verification' => const PendingVerificationScreen(),
      '/application-rejected' => const ApplicationRejectedScreen(),
      '/pooled-offer' => const PooledTripOfferScreen(),
      '/pooled-parcels' => const PooledParcelsScreen(),
      '/collect-cash' => const CollectCashScreen(),
      '/report-problem' => const RiderReportProblemScreen(),
      '/shift-summary' => const ShiftSummaryScreen(),
      '/shift-invoice' => const ShiftEarningsInvoiceScreen(),
      '/earnings-detail' => const DeliveryEarningsDetailScreen(),
      '/history' => const RiderDeliveryHistoryScreen(),
      '/ratings' => const RiderRatingsScreen(),
      '/profile' => const RiderProfileScreen(),
      '/navigation-pref' => const NavigationPreferenceScreen(),
      '/display-alerts' => const DisplayAndAlertsScreen(),
      '/tariff' => const RiderTariffSettingsScreen(),
      '/home' => const RiderHomeScreen(),
      '/offer' => const OfferScreen(),
      '/pickup' => const PickupScreen(),
      '/ready' => const ReadyAlertScreen(),
      '/at-store' => const AtStoreScreen(),
      '/handover' => const HandoverScreen(),
      '/dropoff' => const DropOffScreen(),
      '/code' => const CodeScreen(),
      '/delivered' => const DeliveredScreen(),
      _ => const RiderSignInScreen(),
    };
    return MaterialPageRoute<void>(builder: (_) => page, settings: settings);
  }
}
