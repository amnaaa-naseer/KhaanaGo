import 'package:flutter/material.dart';
import 'package:khaana_design/khaana_design.dart';

import 'src/admin_p2_screens.dart';
import 'src/admin_p3_screens.dart';
import 'src/admin_screens.dart';
import 'src/scope.dart';
import 'src/session.dart';
import 'src/shell.dart';
import 'src/vendor_p2_screens.dart';
import 'src/vendor_p3_screens.dart';
import 'src/vendor_screens.dart';

void main() {
  runApp(const PortalApp());
}

class PortalApp extends StatefulWidget {
  const PortalApp({super.key});

  @override
  State<PortalApp> createState() => _PortalAppState();
}

class _PortalAppState extends State<PortalApp> {
  final _session = PortalSession();

  @override
  void dispose() {
    _session.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PortalScope(
      session: _session,
      child: MaterialApp(
        title: 'KhaanaGo Portal',
        theme: khaanaTheme(KhaanaThemeKind.light),
        initialRoute: '/vendor/sign-in',
        onGenerateRoute: _route,
      ),
    );
  }

  Route<void> _route(RouteSettings settings) {
    final name = settings.name ?? '/vendor/sign-in';
    if (name == '/vendor/sign-in') {
      return MaterialPageRoute<void>(builder: (_) => const VendorSignInScreen(), settings: settings);
    }
    if (name == '/admin/sign-in') {
      return MaterialPageRoute<void>(builder: (_) => const AdminSignInScreen(), settings: settings);
    }
    if (!_session.allows(name)) {
      return MaterialPageRoute<void>(
        builder: (_) => const PortalShell(child: AccessDenied(uiId: 'E1-US3-UI3')),
        settings: settings,
      );
    }
    final page = switch (name) {
      // Shared P3
      '/not-found' => const PageNotFoundScreen(homeRoute: '/vendor/dashboard', portalLabel: 'Return to Portal'),
      '/error' => const SomethingWentWrongScreen(),

      // Vendor P3 routes
      '/vendor/reset-password' => const VendorResetPasswordScreen(),
      '/vendor/public-preview' => const PublicStorePreviewScreen(),
      '/vendor/categories' => const CategoryManagerScreen(),
      '/vendor/dietary-tags' => const DietaryAllergenTagsScreen(),
      '/vendor/complaints' => const VendorComplaintsListScreen(),
      '/vendor/complaint-detail' => const VendorComplaintDetailResponseScreen(),

      // Vendor P1 + P2 routes
      '/vendor/apply-1' => const VendorAppStep1Screen(),
      '/vendor/apply-2' => const VendorAppStep2Screen(),
      '/vendor/apply-3' => const VendorAppStep3Screen(),
      '/vendor/apply-status' => const VendorApplicationStatusScreen(),
      '/vendor/locked' => const VendorAccountLockedScreen(),
      '/vendor/staff-home' => const StaffHomeScreen(),
      '/vendor/staff' => const StaffListScreen(),
      '/vendor/staff/edit' => AddEditStaffScreen(existing: settings.arguments as StaffMemberRecord?),
      '/vendor/business-profile' => const VendorBusinessProfileScreen(),
      '/vendor/hours' => const OperatingHoursScreen(),
      '/vendor/delivery-settings' => const VendorDeliverySettingsScreen(),
      '/vendor/tariff' => const VendorTariffSettingsScreen(),
      '/vendor/bank' => const VendorBankDetailsScreen(),
      '/vendor/customization-options' => const VendorCustomizationOptionsScreen(),
      '/vendor/buffers' => const VendorBuffersOverridesScreen(),
      '/vendor/custom-review' => const CustomOrderReviewScreen(),
      '/vendor/recipe-list' => const RecipeListScreen(),
      '/vendor/ingredient/edit' => const AddEditIngredientScreen(),
      '/vendor/low-stock' => const LowStockAlertsScreen(),
      '/vendor/variance' => const VarianceReportScreen(),
      '/vendor/mrp' => const MaterialRequirementsPlannerScreen(),
      '/vendor/invoices' => const VendorInvoiceListScreen(),
      '/vendor/payments' => const VendorPaymentsScreen(),
      '/vendor/refunds' => const VendorRefundsScreen(),
      '/vendor/cod' => const CodReconciliationScreen(),
      '/vendor/commission' => const CommissionPayoutsScreen(),
      '/vendor/expenses' => const VendorExpensesScreen(),
      '/vendor/net-profit' => const NetProfitDishMarginsScreen(),
      '/vendor/offers' => const VendorOffersListScreen(),
      '/vendor/offers/edit' => const CreateEditOfferScreen(),
      '/vendor/combos' => const ComboBuilderScreen(),
      '/vendor/offers/performance' => const OfferPerformanceScreen(),
      '/vendor/feedback' => const ProductFeedbackScreen(),
      '/vendor/audit-log' => const VendorAuditLogScreen(),
      '/vendor/responsive-layouts' => const ResponsivePortalLayoutsScreen(),
      '/vendor/dashboard' => const OwnerDashboardScreen(),
      '/vendor/menu' => const MenuListScreen(),
      '/vendor/menu/edit' => const EditItemScreen(),
      '/vendor/capacity' => const CapacityScreen(),
      '/vendor/utilisation' => const UtilisationScreen(),
      '/vendor/kitchen' => const KitchenScreen(),
      '/vendor/recipe' => const RecipeScreen(),
      '/vendor/nutrition' => const NutritionScreen(),
      '/vendor/stock' => const StockScreen(),
      '/vendor/bom' => const BomScreen(),
      '/vendor/invoice' => const InvoiceScreen(),
      '/vendor/finance' => const FinanceScreen(),

      // Admin P3 routes
      '/admin/tax-settings' => const TaxInvoiceSettingsScreen(),
      '/admin/waiting-rules' => const WaitingTimeThresholdRateScreen(),
      '/admin/pooling-rules' => const PoolingRulesScreen(),
      '/admin/safety-rules' => const SafetyCheckInRulesScreen(),

      // Admin P1 + P2 routes
      '/admin/dashboard' => const AdminDashboardScreen(),
      '/admin/buffers' => const BufferListScreen(),
      '/admin/buffers/edit' => BufferEditorScreen(existing: settings.arguments as BufferRule?),
      '/admin/verification-queue' => const VerificationQueueScreen(),
      '/admin/verify-vendor' => const VendorApplicationReviewScreen(),
      '/admin/verify-rider' => const RiderVerificationReviewScreen(),
      '/admin/fleets' => const PartnerFleetsScreen(),
      '/admin/fleet-detail' => const PartnerDetailsStatusLogScreen(),
      '/admin/commission' => const CommissionSettingsScreen(),
      '/admin/users' => const AdminUsersScreen(),
      '/admin/user-detail' => AdminUserDetailScreen(userName: settings.arguments as String?),
      '/admin/complaints' => const ComplaintsQueueScreen(),
      '/admin/complaint-detail' => const ComplaintDetailScreen(),
      '/admin/reports' => const AdminReportsScreen(),
      '/admin/safety' => const SafetyEscalationsScreen(),
      '/admin/audit-investigation' => const AuditInvestigationScreen(),
      _ => const VendorSignInScreen(),
    };
    final unframed = name.contains('sign-in') ||
        name.startsWith('/vendor/apply') ||
        name == '/vendor/locked' ||
        name == '/vendor/reset-password';
    final shell = unframed ? page : PortalShell(child: page);
    return MaterialPageRoute<void>(builder: (_) => shell, settings: settings);
  }
}
