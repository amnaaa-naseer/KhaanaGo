import 'dart:async';

import 'package:flutter/material.dart';
import 'package:khaana_design/khaana_design.dart';

import 'p2_screens.dart';
import 'scope.dart';
import 'session.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    return KhaanaPage(
      uiId: 'E3-US2-UI1',
      title: 'Cart',
      footer: KhaanaPrimaryButton(
        label: session.cart.isEmpty
            ? 'Choose delivery'
            : 'Choose delivery · ${formatRupees(session.foodTotal)}',
        icon: Icons.local_shipping_outlined,
        onPressed: session.cart.isEmpty || session.hasUnavailable || session.cart.any((line) => line.qty < 1)
            ? null
            : () => Navigator.pushNamed(context, '/delivery'),
      ),
      child: session.cart.isEmpty
          ? KhaanaEmptyState(
              title: 'Your cart is empty.',
              message: 'Add freshly prepared dishes or custom cakes from an open kitchen to get started.',
              icon: Icons.shopping_cart_outlined,
              actionLabel: 'Browse restaurants',
              onAction: () => Navigator.pushReplacementNamed(context, '/home'),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (session.hasUnavailable) ...[
                  const KhaanaInlineBanner(
                    kind: CapacityKind.full,
                    text: 'This item is no longer available. Remove it before checkout.',
                  ),
                  const SizedBox(height: 10),
                ],
                for (final line in session.cart)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 46,
                                height: 46,
                                decoration: BoxDecoration(
                                  color: KhaanaColors.orangeTint,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  line.dish.category == 'Cakes'
                                      ? Icons.cake_rounded
                                      : Icons.dinner_dining_rounded,
                                  color: KhaanaColors.onOrangeTint,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      line.dish.name,
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                                    ),
                                    if (line.size != null)
                                      Text(
                                        '${line.size} · ${line.flavour ?? ''}${line.customText.isNotEmpty ? ' · "${line.customText}"' : ''}',
                                        style: const TextStyle(fontSize: 13, color: KhaanaColors.mutedLight),
                                      ),
                                  ],
                                ),
                              ),
                              Text(
                                formatRupees(line.lineTotal),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  fontFeatures: [FontFeature.tabularFigures()],
                                ),
                              ),
                            ],
                          ),
                          if (!line.dish.available) ...[
                            const SizedBox(height: 8),
                            const Text(
                              'This item is no longer available. Remove it before checkout.',
                              style: TextStyle(color: KhaanaColors.full, fontWeight: FontWeight.w700),
                            ),
                          ],
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: KhaanaColors.fieldLight),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      visualDensity: VisualDensity.compact,
                                      onPressed: () => session.setQty(line, line.qty - 1),
                                      icon: const Icon(Icons.remove, size: 18),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Text(
                                        '${line.qty}',
                                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                                      ),
                                    ),
                                    IconButton(
                                      visualDensity: VisualDensity.compact,
                                      onPressed: () => session.setQty(line, line.qty + 1),
                                      icon: const Icon(Icons.add, size: 18),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              TextButton.icon(
                                onPressed: () => session.removeLine(line),
                                icon: const Icon(Icons.delete_outline_rounded, size: 18, color: KhaanaColors.full),
                                label: const Text('Remove', style: TextStyle(color: KhaanaColors.full)),
                              ),
                            ],
                          ),
                          if (line.qty < 1)
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text(
                                'Quantity must be at least 1.',
                                style: TextStyle(color: KhaanaColors.full, fontWeight: FontWeight.w700),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Food subtotal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                        Text(
                          'Subtotal ${formatRupees(session.foodTotal)}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class DeliveryTypeScreen extends StatelessWidget {
  const DeliveryTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    final pooledBlocked = session.hasFragile;
    return KhaanaPage(
      uiId: 'E14-US2-UI1',
      title: 'Delivery type',
      footer: KhaanaPrimaryButton(
        label: 'Choose a time',
        icon: Icons.schedule_rounded,
        onPressed: () => Navigator.pushNamed(context, '/slots'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Option(
            title: 'Express',
            badge: 'Direct rider',
            icon: Icons.bolt_rounded,
            body: 'Single delivery straight from the kitchen to your door. Express is never pooled.',
            selected: session.deliveryType == 'express',
            onTap: () => session.chooseDelivery('express'),
          ),
          _Option(
            title: 'Pooled · ${PrototypeAssumptions.pooledDiscountPercent}% off the delivery fee',
            badge: 'Save ${PrototypeAssumptions.pooledDiscountPercent}%',
            icon: Icons.group_work_outlined,
            body:
                'Estimated extra ${PrototypeAssumptions.pooledExtraMinutesMin}–${PrototypeAssumptions.pooledExtraMinutesMax} minutes. This is an estimate, not a guaranteed delivery time.',
            selected: session.deliveryType == 'pooled',
            enabled: !pooledBlocked,
            onTap: () => session.chooseDelivery('pooled'),
          ),
          if (pooledBlocked) ...[
            const SizedBox(height: 8),
            const KhaanaInlineBanner(
              kind: CapacityKind.limited,
              text:
                  'A fragile item is in the cart, so pooled delivery stays off until that item is removed and the order still qualifies.',
            ),
          ],
          const ProvisionalNote(
            text: 'The 30% discount and 10–15 minute range are provisional and still need review.',
          ),
        ],
      ),
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({
    required this.title,
    required this.badge,
    required this.icon,
    required this.body,
    required this.selected,
    required this.onTap,
    this.enabled = true,
  });

  final String title;
  final String badge;
  final IconData icon;
  final String body;
  final bool selected;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: selected ? KhaanaColors.orangeTint : (enabled ? Colors.white : KhaanaColors.surface2Light),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: selected ? KhaanaColors.orange : KhaanaColors.lineLight,
          width: selected ? 2.5 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: enabled ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: selected ? KhaanaColors.orange : KhaanaColors.surface2Light,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: KhaanaColors.charcoal),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: enabled ? KhaanaColors.charcoal : KhaanaColors.mutedLight,
                            ),
                          ),
                        ),
                        CapacityBadge(
                          kind: enabled ? CapacityKind.available : CapacityKind.closed,
                          label: enabled ? badge : 'Disabled',
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      body,
                      style: TextStyle(
                        fontSize: 13,
                        color: enabled ? KhaanaColors.onOrangeTint : KhaanaColors.mutedLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SlotScreen extends StatefulWidget {
  const SlotScreen({super.key});

  @override
  State<SlotScreen> createState() => _SlotScreenState();
}

class _SlotScreenState extends State<SlotScreen> {
  String _day = 'Today';

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    return KhaanaPage(
      uiId: 'E5-US3-UI1',
      title: 'Choose delivery time',
      footer: KhaanaPrimaryButton(
        label: 'Payment',
        icon: Icons.payment_rounded,
        onPressed: session.selectedSlot == null ? null : () => Navigator.pushNamed(context, '/payment'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Day tabs from Design System (.daytabs)
          Row(
            children: [
              for (final day in ['Today', 'Sun', 'Mon']) ...[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => setState(() => _day = day),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _day == day ? KhaanaColors.charcoal : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: KhaanaColors.lineLight),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          day,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: _day == day ? KhaanaColors.cream : KhaanaColors.mutedLight,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'These bands are an intake rule. Full does not mean the kitchen is physically full.',
            style: TextStyle(fontSize: 13, color: KhaanaColors.mutedLight),
          ),
          const ProvisionalNote(
            text:
                'Available is below 60%, Limited is 60% to below 85%, and Full is 85% or above. Thresholds are awaiting review.',
          ),
          const SizedBox(height: 14),

          // 3-Column Delivery Slot Grid from Design System (.slots)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.55,
            ),
            itemCount: session.slots.length,
            itemBuilder: (context, index) {
              final slot = session.slots[index];
              final selected = session.selectedSlot == slot.label;
              final isFull = slot.isFull;
              final statusColor = switch (slot.band) {
                'Limited' => KhaanaColors.limited,
                'Full' => KhaanaColors.full,
                _ => KhaanaColors.available,
              };
              final statusIcon = switch (slot.band) {
                'Limited' => Icons.schedule_rounded,
                'Full' => Icons.close_rounded,
                _ => Icons.check_rounded,
              };
              return InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: isFull ? null : () => session.selectSlot(slot),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: selected
                        ? KhaanaColors.orangeTint
                        : isFull
                            ? KhaanaColors.surface2Light
                            : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected
                          ? KhaanaColors.orange
                          : isFull
                              ? KhaanaColors.lineLight
                              : KhaanaColors.fieldLight,
                      width: selected ? 2.5 : 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        slot.label,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: selected
                              ? KhaanaColors.onOrangeTint
                              : isFull
                                  ? KhaanaColors.mutedLight
                                  : KhaanaColors.charcoal,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(statusIcon, size: 12, color: statusColor),
                          const SizedBox(width: 3),
                          Flexible(
                            child: Text(
                              isFull
                                  ? 'Full'
                                  : slot.band == 'Limited'
                                      ? '${slot.remaining} left'
                                      : 'Available',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: statusColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 14),
          const KhaanaInlineBanner(
            kind: CapacityKind.info,
            icon: Icons.cloud_queue_rounded,
            text: 'Includes extra time for rain in your area.',
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              TextButton.icon(
                onPressed: () {
                  session.takeSelectedSlot();
                  showDialog<void>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('That slot was just taken'),
                      content: Text('Pick another time. Still free: ${session.nearestFreeSlots().join(', ')}.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Choose another time'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.bolt_rounded, size: 16),
                label: const Text('Preview: that slot was just taken'),
              ),
              TextButton.icon(
                onPressed: session.freeAFullSlot,
                icon: const Icon(Icons.refresh_rounded, size: 16),
                label: const Text('Refresh after a cancellation'),
              ),
            ],
          ),
          const ProvisionalNote(
            text: 'The double-booking itself is a backend test. This button only shows the E5-US4-UI1 message.',
          ),
        ],
      ),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    const methods = [
      ('Cash on delivery', 'Pay cash at your doorstep upon PIN verification', Icons.payments_outlined),
      ('JazzCash', 'Instant mobile wallet checkout', Icons.phone_android_rounded),
      ('Easypaisa', 'Fast mobile account payment', Icons.account_balance_wallet_outlined),
      ('Card', 'Visa / Mastercard / UnionPay', Icons.credit_card_rounded),
    ];
    return KhaanaPage(
      uiId: 'E3-US3-UI1',
      title: 'Payment',
      footer: KhaanaPrimaryButton(
        label: 'Review order',
        icon: Icons.receipt_long_rounded,
        onPressed: () => Navigator.pushNamed(context, '/review'),
      ),
      child: RadioGroup<String>(
        groupValue: session.payment,
        onChanged: (value) {
          if (value != null) session.setPayment(value);
        },
        child: Column(
          children: [
            for (final method in methods)
              Card(
                color: session.payment == method.$1 ? KhaanaColors.orangeTint : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: session.payment == method.$1 ? KhaanaColors.orange : KhaanaColors.lineLight,
                    width: session.payment == method.$1 ? 2.5 : 1,
                  ),
                ),
                child: RadioListTile<String>(
                  value: method.$1,
                  secondary: Icon(method.$3, color: KhaanaColors.charcoal),
                  title: Text(method.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                  subtitle: Text(method.$2, style: const TextStyle(fontSize: 12)),
                ),
              ),
            const ProvisionalNote(
              text:
                  'The payment gateway page belongs to the provider. This screen only records the method in local state.',
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                KhaanaSecondaryButton(
                  label: 'Voucher & offers sheet (E3-US4-UI1)',
                  icon: Icons.confirmation_number_outlined,
                  onPressed: () => showVoucherOffersSheet(context),
                ),
                KhaanaSecondaryButton(
                  label: 'Gateway handoff (E3-US3-UI2)',
                  icon: Icons.open_in_new_rounded,
                  onPressed: () => Navigator.pushNamed(context, '/payment-handoff'),
                ),
                KhaanaSecondaryButton(
                  label: 'Payment failed (E10-US3-UI1)',
                  icon: Icons.error_outline_rounded,
                  onPressed: () => Navigator.pushNamed(context, '/payment-failed'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  Timer? _timer;
  var _placing = false;
  var _expired = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || _expired) return;
      final hold = CustomerScope.of(context).holdUntil;
      if (hold != null && !hold.isAfter(DateTime.now())) {
        _expired = true;
        showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: KhaanaColors.orangeTint,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'E5-US4-UI2',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint),
                  ),
                ),
                const SizedBox(width: 8),
                const Text('Slot released'),
              ],
            ),
            content: const Text('The hold expired. Choose another time.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.popUntil(context, ModalRoute.withName('/slots'));
                },
                child: const Text('Back to slots'),
              ),
            ],
          ),
        );
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    final hold = session.holdUntil;
    final remaining = hold == null ? Duration.zero : hold.difference(DateTime.now());
    final minutes = remaining.isNegative ? 0 : remaining.inMinutes.remainder(60);
    final seconds = remaining.isNegative ? 0 : remaining.inSeconds.remainder(60);
    final clock = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    return KhaanaPage(
      uiId: 'E3-US2-UI2',
      title: 'Review order',
      footer: KhaanaPrimaryButton(
        label: _placing ? 'Placing…' : 'Place order · ${formatRupees(session.total)}',
        loading: _placing,
        icon: Icons.check_circle_outline_rounded,
        onPressed: _placing
            ? null
            : () {
                setState(() => _placing = true);
                final placed = session.placeOrder();
                if (!placed) {
                  setState(() => _placing = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Payment did not go through. Your order has not been placed.'),
                    ),
                  );
                  return;
                }
                Navigator.pushNamedAndRemoveUntil(context, '/placed', ModalRoute.withName('/home'));
              },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CapacityBadge(kind: CapacityKind.info, label: 'Slot held for $clock'),
            ],
          ),
          const SizedBox(height: 12),
          // Summary Table from Design System (.sum)
          Card(
            child: Column(
              children: [
                _SummaryRow(label: 'Deliver to', value: session.address),
                const Divider(height: 1),
                _SummaryRow(label: 'Time', value: 'Today, ${session.selectedSlot ?? 'not chosen'}'),
                const Divider(height: 1),
                _SummaryRow(label: 'Delivery', value: session.deliveryType == 'pooled' ? 'Pooled' : 'Express'),
                const Divider(height: 1),
                _SummaryRow(label: 'Pay with', value: session.payment),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: PriceLines(
                lines: [
                  ('Food', session.foodTotal),
                  ('Delivery base', CustomerSession.deliveryBase),
                  ('Road distance', CustomerSession.distanceCharge),
                  ('Rain surcharge', CustomerSession.rainSurcharge),
                  if (session.pooledDiscount > 0) ('Pooled delivery discount', -session.pooledDiscount),
                ],
                total: session.total,
              ),
            ),
          ),
          if (session.hasFragile) ...[
            const SizedBox(height: 8),
            const KhaanaInlineBanner(
              kind: CapacityKind.limited,
              text: 'Custom cake: the vendor confirms price and lead time before payment is taken.',
            ),
          ],
          const ProvisionalNote(text: 'The hold is a simulated 5 minutes and is awaiting review.'),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: KhaanaColors.mutedLight)),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}

class PlacedScreen extends StatelessWidget {
  const PlacedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = CustomerScope.of(context);
    return KhaanaPage(
      uiId: 'E3-US4-UI2',
      title: 'Order placed',
      footer: KhaanaPrimaryButton(
        label: 'Track order',
        icon: Icons.near_me_rounded,
        onPressed: () => Navigator.pushNamed(context, '/tracking'),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: const BoxDecoration(
                  color: KhaanaColors.availableTint,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded, size: 38, color: KhaanaColors.available),
              ),
              const SizedBox(height: 14),
              const Text(
                'Order Confirmed!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
              Text(session.orderNumber, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: KhaanaColors.orangeText)),
              const SizedBox(height: 8),
              CapacityBadge(kind: CapacityKind.available, label: 'Slot ${session.selectedSlot}'),
              const SizedBox(height: 10),
              Text(
                session.arrivalWindowStale ? 'Earlier estimate 7:10–7:30 PM' : 'Arrives 7:25–7:45 PM',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                'Share delivery code ${session.deliveryCode} with your rider at the door.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: KhaanaColors.mutedLight),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
