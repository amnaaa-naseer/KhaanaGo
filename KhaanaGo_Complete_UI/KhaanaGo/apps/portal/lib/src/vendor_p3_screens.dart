import 'package:flutter/material.dart';
import 'package:khaana_design/khaana_design.dart';

/// E1-US3-UI4: Reset password
/// Must show: Owner email reset
class VendorResetPasswordScreen extends StatefulWidget {
  const VendorResetPasswordScreen({super.key});

  @override
  State<VendorResetPasswordScreen> createState() => _VendorResetPasswordScreenState();
}

class _VendorResetPasswordScreenState extends State<VendorResetPasswordScreen> {
  final _email = TextEditingController(text: 'owner@bakecharm.pk');
  bool _sent = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E1-US3-UI4',
      title: 'Vendor owner password reset',
      footer: KhaanaPrimaryButton(
        label: _sent ? 'Return to Vendor Sign-in' : 'Send owner reset link',
        icon: Icons.mark_email_read_outlined,
        onPressed: () {
          if (_sent) {
            Navigator.pushReplacementNamed(context, '/vendor/sign-in');
          } else {
            setState(() => _sent = true);
          }
        },
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enter the store owner email address to receive a password reset link (staff credentials are managed by the owner on E1-US4-UI1):'),
              const SizedBox(height: 12),
              TextField(
                controller: _email,
                decoration: const InputDecoration(labelText: 'Owner Email Address *', prefixIcon: Icon(Icons.email_outlined)),
              ),
              if (_sent) ...[
                const SizedBox(height: 12),
                const KhaanaInlineBanner(
                  kind: CapacityKind.available,
                  text: 'Reset link sent to owner@bakecharm.pk.',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// E2-US1-UI2: Public store preview
/// Must show: Customer-facing card and header preview
class PublicStorePreviewScreen extends StatelessWidget {
  const PublicStorePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E2-US1-UI2',
      title: 'Public store preview (Customer view)',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KhaanaInlineBanner(
            kind: CapacityKind.info,
            text: 'Live preview of how BakeCharm appears on the Customer Home feed (E3-US1-UI1) and Vendor Menu header (E3-US1-UI2).',
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('BakeCharm · Bakery & Custom Cakes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                      CapacityBadge(kind: CapacityKind.limited, label: 'Limited · 72% Load'),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('F-11 Markaz · 4.7 ★ · ETA 35–50 min · Halal & Nut-Free Options'),
                  SizedBox(height: 12),
                  KitchenCapacityMeter(
                    title: 'Customer-Facing Hourly Slot Meter',
                    booked: 9,
                    limit: 12,
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

/// E2-US2-UI3: Delete menu item confirmation (Overlay)
/// Must show: Confirm removal; past orders keep their record
Future<void> showDeleteMenuItemDialog(BuildContext context, {String itemName = 'Chocolate cake'}) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: KhaanaColors.orangeTint, borderRadius: BorderRadius.circular(6)),
            child: const Text('E2-US2-UI3', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint)),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Delete menu item?')),
        ],
      ),
      content: Text(
        'Remove "$itemName" from your active menu? Past orders and tax invoices (#INV-2026-1042) permanently retain their historical item record.',
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Keep item')),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: KhaanaColors.full),
          onPressed: () => Navigator.pop(context),
          child: const Text('Confirm removal'),
        ),
      ],
    ),
  );
}

/// E2-US2-UI4: Category manager
/// Must show: Add, rename, reorder categories
class CategoryManagerScreen extends StatefulWidget {
  const CategoryManagerScreen({super.key});

  @override
  State<CategoryManagerScreen> createState() => _CategoryManagerScreenState();
}

class _CategoryManagerScreenState extends State<CategoryManagerScreen> {
  final List<String> _categories = ['Celebration Cakes', 'Bento & Cupcakes', 'Fudge Brownie Boxes', 'Sides & Candles'];
  final _newCat = TextEditingController();

  @override
  void dispose() {
    _newCat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E2-US2-UI4',
      title: 'Menu category manager',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _newCat,
                  decoration: const InputDecoration(labelText: 'New Category Name'),
                ),
              ),
              const SizedBox(width: 10),
              KhaanaPrimaryButton(
                label: 'Add category',
                icon: Icons.add_rounded,
                onPressed: () {
                  if (_newCat.text.trim().isEmpty) return;
                  setState(() {
                    _categories.add(_newCat.text.trim());
                    _newCat.clear();
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < _categories.length; i++)
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: KhaanaColors.orangeTint,
                  child: Text('${i + 1}', style: const TextStyle(fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint)),
                ),
                title: Text(_categories[i], style: const TextStyle(fontWeight: FontWeight.w800)),
                trailing: Wrap(
                  spacing: 4,
                  children: [
                    IconButton(
                      tooltip: 'Move up',
                      onPressed: i == 0
                          ? null
                          : () => setState(() {
                                final item = _categories.removeAt(i);
                                _categories.insert(i - 1, item);
                              }),
                      icon: const Icon(Icons.arrow_upward_rounded),
                    ),
                    IconButton(
                      tooltip: 'Move down',
                      onPressed: i == _categories.length - 1
                          ? null
                          : () => setState(() {
                                final item = _categories.removeAt(i);
                                _categories.insert(i + 1, item);
                              }),
                      icon: const Icon(Icons.arrow_downward_rounded),
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

/// E8-US3-UI1: Dietary and allergen tags
/// Must show: Tags and allergen warning text
class DietaryAllergenTagsScreen extends StatefulWidget {
  const DietaryAllergenTagsScreen({super.key});

  @override
  State<DietaryAllergenTagsScreen> createState() => _DietaryAllergenTagsScreenState();
}

class _DietaryAllergenTagsScreenState extends State<DietaryAllergenTagsScreen> {
  final Set<String> _tags = {'Contains Dairy', 'Contains Eggs', 'Contains Wheat Gluten', 'Nut-Free Option Available'};
  final _warning = TextEditingController(
    text: 'Contains eggs, dairy and gluten. Prepared in a kitchen that handles tree nuts; select "No nuts" for sanitized prep.',
  );

  @override
  void dispose() {
    _warning.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E8-US3-UI1',
      title: 'Dietary & allergen tags (Chocolate Cake)',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Verified Dietary & Allergen Badges', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final t in ['Contains Dairy', 'Contains Eggs', 'Contains Wheat Gluten', 'Nut-Free Option Available', 'High Protein', 'Halal'])
                    FilterChip(
                      label: Text(t),
                      selected: _tags.contains(t),
                      onSelected: (v) => setState(() => v ? _tags.add(t) : _tags.remove(t)),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _warning,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Customer-Facing Allergen Warning Banner Text *'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// E18-US3-UI4: Customer complaints
/// Must show: Complaints linked to this vendor's orders
class VendorComplaintsListScreen extends StatelessWidget {
  const VendorComplaintsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E18-US3-UI4',
      title: 'Customer complaints (BakeCharm)',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final c in const [
            ('#CMP-204 · Order #KG-1042', 'Damaged fragile item · Corner dent on cake box during rain', 'Awaiting Vendor Reply'),
            ('#CMP-191 · Order #KG-1018', 'Missing birthday candle pack', 'Resolved'),
          ])
            Card(
              child: ListTile(
                title: Text(c.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(c.$2),
                trailing: CapacityBadge(
                  kind: c.$3 == 'Resolved' ? CapacityKind.available : CapacityKind.limited,
                  label: c.$3,
                ),
                onTap: () => Navigator.pushNamed(context, '/vendor/complaint-detail'),
              ),
            ),
        ],
      ),
    );
  }
}

/// E18-US3-UI5: Complaint detail and response
/// Must show: Order details and vendor reply
class VendorComplaintDetailResponseScreen extends StatefulWidget {
  const VendorComplaintDetailResponseScreen({super.key});

  @override
  State<VendorComplaintDetailResponseScreen> createState() => _VendorComplaintDetailResponseScreenState();
}

class _VendorComplaintDetailResponseScreenState extends State<VendorComplaintDetailResponseScreen> {
  final _reply = TextEditingController(
    text: 'Cake left the kitchen in a sealed rigid board box at 7:02 PM (photo logged). Offering Rs 400 goodwill voucher for the corner dent.',
  );
  bool _replied = false;

  @override
  void dispose() {
    _reply.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E18-US3-UI5',
      title: 'Complaint detail & vendor response (#CMP-204)',
      footer: KhaanaPrimaryButton(
        label: _replied ? 'Vendor response submitted to Admin' : 'Submit vendor response',
        icon: Icons.send_rounded,
        onPressed: () => setState(() => _replied = true),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Ticket #CMP-204 · Order #KG-1042 (Chocolate Cake 1 lb)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  const Text('Customer: Ayesha Khan · Category: Damaged fragile item'),
                  const Text('Customer Note: "Box corner was dented upon delivery; cake frosting slightly smudged."'),
                  const Divider(height: 24),
                  TextField(
                    controller: _reply,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: 'Vendor Response to Administrator & Customer *'),
                  ),
                  if (_replied) ...[
                    const SizedBox(height: 12),
                    const KhaanaInlineBanner(
                      kind: CapacityKind.available,
                      text: 'Your response has been attached to Ticket #CMP-204 for administrator resolution.',
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

