import 'package:flutter/material.dart';
import 'package:khaana_design/khaana_design.dart';

import 'p2_screens.dart';
import 'p3_screens.dart';
import 'scope.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    final window = session.arrivalWindowStale ? '7:10–7:30 PM (stale)' : '7:25–7:45 PM';
    return KhaanaPage(
      uiId: 'E17-US1-UI1',
      title: 'Live tracking',
      actions: [
        IconButton(
          tooltip: 'Notification centre (E17-US1-UI2)',
          onPressed: () => Navigator.pushNamed(context, '/notifications'),
          icon: const Icon(Icons.notifications_active_outlined),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Preparing', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                      CapacityBadge(kind: CapacityKind.info, label: 'Arrival window $window'),
                    ],
                  ),
                  if (session.arrivalWindowStale)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: TextButton.icon(
                        onPressed: session.replaceStaleWindow,
                        icon: const Icon(Icons.update_rounded, size: 16),
                        label: const Text('Replace stale estimate'),
                      ),
                    ),
                  const SizedBox(height: 12),
                  OrderStatusTimeline(
                    activeIndex: 1,
                    steps: [
                      ('Confirmed', '6:42 PM · Kitchen accepted order #${session.orderNumber}'),
                      ('Preparing', '6:45 PM · Oven batch in progress'),
                      ('Out for delivery', 'Arrives $window'),
                      ('Delivered', 'Requires 6-digit PIN verification'),
                    ],
                  ),
                  const Text(
                    'Confirmed · Preparing · Out for delivery · Delivered',
                    style: TextStyle(fontSize: 12, color: KhaanaColors.mutedLight),
                  ),
                  const Divider(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              session.deliveryType == 'pooled'
                                  ? 'Pooled stop 1 of 2. The extra time is an estimate.'
                                  : 'Express, one stop.',
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 2),
                            const Text('Refund status: none', style: TextStyle(fontSize: 12, color: KhaanaColors.mutedLight)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: KhaanaColors.orangeTint,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: KhaanaColors.orange),
                        ),
                        child: Text(
                          'Delivery code ${session.deliveryCode}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: KhaanaColors.onOrangeTint,
                            fontFeatures: [FontFeature.tabularFigures()],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          SimulatedMap(address: session.address, restored: session.mapVisible, onRetry: session.toggleMap),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              KhaanaSecondaryButton(
                label: 'Confirm corrected drop-off pin (E16-US4-UI1)',
                icon: Icons.pin_drop_outlined,
                onPressed: () => showConfirmCorrectedPinDialog(context),
              ),
              KhaanaSecondaryButton(
                label: 'Notifications (E17-US1-UI2)',
                icon: Icons.notifications_outlined,
                onPressed: () => Navigator.pushNamed(context, '/notifications'),
              ),
              KhaanaSecondaryButton(
                label: 'Rate order (E18-US1-UI1)',
                icon: Icons.star_outline_rounded,
                onPressed: () => Navigator.pushNamed(context, '/rating', arguments: session.orderNumber),
              ),
              KhaanaSecondaryButton(
                label: 'Raise complaint (E18-US3-UI1)',
                icon: Icons.report_problem_outlined,
                onPressed: () => Navigator.pushNamed(context, '/complaint', arguments: session.orderNumber),
              ),
              KhaanaSecondaryButton(
                label: 'Complaint status (E18-US3-UI2)',
                icon: Icons.fact_check_outlined,
                onPressed: () => Navigator.pushNamed(context, '/complaint-status', arguments: session.orderNumber),
              ),
              KhaanaSecondaryButton(
                label: 'Cancel order (E10-US1-UI1)',
                icon: Icons.cancel_outlined,
                onPressed: () => showCancelOrderDialog(context, orderNumber: session.orderNumber),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Card(
            color: KhaanaColors.limitedTint,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Color(0xFFEAB308)),
            ),
            child: ListTile(
              leading: const Icon(Icons.schedule_rounded, color: KhaanaColors.limited),
              title: const Text(
                'Your order is running about 15 minutes late because of rain in your area.',
                style: TextStyle(fontWeight: FontWeight.w700, color: KhaanaColors.limited),
              ),
              subtitle: const Text(
                'In-app update. Push delivery is not part of this mock.',
                style: TextStyle(color: KhaanaColors.limited),
              ),
              trailing: const Icon(Icons.chevron_right_rounded, color: KhaanaColors.limited),
              onTap: () => Navigator.pushNamed(context, '/delay'),
            ),
          ),
          const ProvisionalNote(text: 'Maps and live rider position are simulated until a provider is integrated.'),
        ],
      ),
    );
  }
}

class DelayScreen extends StatelessWidget {
  const DelayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E6-US4-UI1',
      title: 'Delay',
      footer: KhaanaPrimaryButton(
        label: 'Back to live tracking',
        onPressed: () => Navigator.pop(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KhaanaInlineBanner(
            kind: CapacityKind.limited,
            icon: Icons.thunderstorm_outlined,
            text: 'Your order is running about 15 minutes late because of rain in your area.',
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Updated ETA Breakdown', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                  SizedBox(height: 8),
                  Text('• Original slot window: 7:10–7:30 PM'),
                  SizedBox(height: 4),
                  Text('• Weather buffer (+15%): +15 minutes'),
                  SizedBox(height: 4),
                  Text('• Revised arrival window: 7:25–7:45 PM', style: TextStyle(fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
