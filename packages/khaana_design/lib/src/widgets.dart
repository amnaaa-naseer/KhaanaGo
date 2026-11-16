import 'dart:async';

import 'package:flutter/material.dart';

import 'assumptions.dart';
import 'tokens.dart';

enum KhaanaViewState { normal, loading, empty, error }

/// Brand square logo asset (`khaanago-logo.png`) with fallback icon.
class KhaanaLogo extends StatelessWidget {
  const KhaanaLogo({super.key, this.size = 44, this.borderRadius = 12});

  final double size;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        'assets/brand/khaanago-logo.png',
        package: 'khaana_design',
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: KhaanaColors.orange,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          alignment: Alignment.center,
          child: Icon(Icons.restaurant_rounded, color: KhaanaColors.charcoal, size: size * 0.56),
        ),
      ),
    );
  }
}

/// Brand horizontal wordmark asset (`khaanago-wordmark.png`) with styled text fallback.
class KhaanaWordmark extends StatelessWidget {
  const KhaanaWordmark({super.key, this.height = 28});

  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        'assets/brand/khaanago-wordmark.png',
        package: 'khaana_design',
        height: height,
        fit: BoxFit.contain,
        errorBuilder: (_, _, _) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: KhaanaColors.orange,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'khaanaGo',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: KhaanaColors.charcoal,
            ),
          ),
        ),
      ),
    );
  }
}

class KhaanaPage extends StatefulWidget {
  const KhaanaPage({
    super.key,
    required this.uiId,
    required this.title,
    required this.child,
    this.footer,
    this.actions,
    this.bottomNavigationBar,
    this.maxWidth = 760,
    this.emptyTitle = 'Nothing here yet',
    this.emptyMessage = 'No items are available for this view right now.',
    this.errorTitle = 'Could not load this screen',
    this.errorMessage = 'Please check your connection and try again.',
  });

  final String uiId;
  final String title;
  final Widget child;
  final Widget? footer;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar;
  final double maxWidth;
  final String emptyTitle;
  final String emptyMessage;
  final String errorTitle;
  final String errorMessage;

  @override
  State<KhaanaPage> createState() => _KhaanaPageState();
}

class _KhaanaPageState extends State<KhaanaPage> {
  KhaanaViewState _viewState = KhaanaViewState.normal;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final outlineVariant = Theme.of(context).colorScheme.outlineVariant;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        title: Row(
          children: [
            const KhaanaLogo(size: 32, borderRadius: 8),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                widget.title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          ...?widget.actions,
          PopupMenuButton<KhaanaViewState>(
            tooltip: 'Simulate UI state (Normal / Loading / Empty / Error)',
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _viewState == KhaanaViewState.normal
                    ? (dark ? KhaanaColors.surface2Dark : KhaanaColors.surface2Light)
                    : KhaanaColors.orangeTint,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: _viewState == KhaanaViewState.normal ? outlineVariant : KhaanaColors.orange,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.tune_rounded,
                    size: 14,
                    color: _viewState == KhaanaViewState.normal
                        ? Theme.of(context).colorScheme.onSurface
                        : KhaanaColors.onOrangeTint,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    switch (_viewState) {
                      KhaanaViewState.normal => 'State',
                      KhaanaViewState.loading => 'Loading',
                      KhaanaViewState.empty => 'Empty',
                      KhaanaViewState.error => 'Error',
                    },
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: _viewState == KhaanaViewState.normal
                          ? Theme.of(context).colorScheme.onSurface
                          : KhaanaColors.onOrangeTint,
                    ),
                  ),
                ],
              ),
            ),
            onSelected: (state) => setState(() => _viewState = state),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: KhaanaViewState.normal,
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.check_circle_outline),
                  title: Text('Normal UI state'),
                ),
              ),
              PopupMenuItem(
                value: KhaanaViewState.loading,
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.hourglass_top_rounded),
                  title: Text('Loading state (skeleton)'),
                ),
              ),
              PopupMenuItem(
                value: KhaanaViewState.empty,
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.inbox_outlined),
                  title: Text('Empty state'),
                ),
              ),
              PopupMenuItem(
                value: KhaanaViewState.error,
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.error_outline_rounded),
                  title: Text('Error state (retry)'),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: outlineVariant),
        ),
      ),
      bottomNavigationBar: widget.bottomNavigationBar,
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: widget.maxWidth),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: dark ? KhaanaColors.surface2Dark : KhaanaColors.surface2Light,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: outlineVariant),
                          ),
                          child: Text(
                            widget.uiId,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                              color: dark ? KhaanaColors.mutedDark : KhaanaColors.mutedLight,
                            ),
                          ),
                        ),
                        const Spacer(),
                        if (_viewState != KhaanaViewState.normal)
                          TextButton.icon(
                            onPressed: () => setState(() => _viewState = KhaanaViewState.normal),
                            icon: const Icon(Icons.restore, size: 15),
                            label: const Text('Exit state preview', style: TextStyle(fontSize: 12)),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    switch (_viewState) {
                      KhaanaViewState.normal => widget.child,
                      KhaanaViewState.loading => const KhaanaLoadingState(),
                      KhaanaViewState.empty => KhaanaEmptyState(
                          title: widget.emptyTitle,
                          message: widget.emptyMessage,
                          actionLabel: 'Back to normal view',
                          onAction: () => setState(() => _viewState = KhaanaViewState.normal),
                        ),
                      KhaanaViewState.error => KhaanaErrorState(
                          title: widget.errorTitle,
                          message: widget.errorMessage,
                          onRetry: () => setState(() => _viewState = KhaanaViewState.normal),
                        ),
                    },
                  ],
                ),
              ),
            ),
          ),
          if (widget.footer != null && _viewState == KhaanaViewState.normal)
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border(top: BorderSide(color: outlineVariant)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: dark ? 0.35 : 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, -6),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Align(
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: widget.maxWidth),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                      child: widget.footer,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Reusable loading skeleton state following KhaanaGo tokens.
class KhaanaLoadingState extends StatelessWidget {
  const KhaanaLoadingState({super.key, this.label = 'Loading live kitchen data…'});

  final String label;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final shimmerBg = dark ? KhaanaColors.surface2Dark : KhaanaColors.surface2Light;
    final lineBg = dark ? KhaanaColors.lineDark : KhaanaColors.lineLight;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: dark ? KhaanaColors.orangeTintDark : KhaanaColors.orangeTint,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: KhaanaColors.orange.withValues(alpha: 0.5)),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(KhaanaColors.orange),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: dark ? KhaanaColors.onOrangeTintDark : KhaanaColors.onOrangeTint,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        for (var i = 0; i < 3; i++)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: shimmerBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 16, width: 150, decoration: BoxDecoration(color: lineBg, borderRadius: BorderRadius.circular(6))),
                        const SizedBox(height: 8),
                        Container(height: 12, width: 210, decoration: BoxDecoration(color: shimmerBg, borderRadius: BorderRadius.circular(6))),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(height: 20, width: 64, decoration: BoxDecoration(color: shimmerBg, borderRadius: BorderRadius.circular(999))),
                            const SizedBox(width: 8),
                            Container(height: 20, width: 78, decoration: BoxDecoration(color: shimmerBg, borderRadius: BorderRadius.circular(999))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// Reusable empty state card with icon, title, microcopy, and optional CTA.
class KhaanaEmptyState extends StatelessWidget {
  const KhaanaEmptyState({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.restaurant_menu_rounded,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                color: dark ? KhaanaColors.orangeTintDark : KhaanaColors.orangeTint,
                shape: BoxShape.circle,
                border: Border.all(color: KhaanaColors.orange, width: 1.5),
              ),
              child: Icon(icon, size: 32, color: dark ? KhaanaColors.onOrangeTintDark : KhaanaColors.onOrangeTint),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: dark ? KhaanaColors.mutedDark : KhaanaColors.mutedLight,
              ),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 20),
              KhaanaSecondaryButton(label: actionLabel!, onPressed: onAction),
            ],
          ],
        ),
      ),
    );
  }
}

/// Reusable error state card / banner with icon, clear message, and Retry action.
class KhaanaErrorState extends StatelessWidget {
  const KhaanaErrorState({
    super.key,
    required this.title,
    required this.message,
    this.onRetry,
  });

  final String title;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final fg = dark ? KhaanaColors.fullDark : KhaanaColors.full;
    final bg = dark ? KhaanaColors.fullTintDark : KhaanaColors.fullTint;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: fg.withValues(alpha: 0.6), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: fg, size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: fg),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: fg),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 14),
            KhaanaSecondaryButton(label: 'Retry', onPressed: onRetry),
          ],
        ],
      ),
    );
  }
}

/// Inline alert box for validation or allergen/status warnings.
class KhaanaInlineBanner extends StatelessWidget {
  const KhaanaInlineBanner({
    super.key,
    required this.text,
    this.kind = CapacityKind.full,
    this.icon,
    this.actionLabel,
    this.onAction,
  });

  final String text;
  final CapacityKind kind;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final (bg, fg, defaultIcon) = switch (kind) {
      CapacityKind.available => (
          dark ? KhaanaColors.availableTintDark : KhaanaColors.availableTint,
          dark ? KhaanaColors.availableDark : KhaanaColors.available,
          Icons.check_circle_outline,
        ),
      CapacityKind.limited => (
          dark ? KhaanaColors.limitedTintDark : KhaanaColors.limitedTint,
          dark ? KhaanaColors.limitedDark : KhaanaColors.limited,
          Icons.schedule_rounded,
        ),
      CapacityKind.full => (
          dark ? KhaanaColors.fullTintDark : KhaanaColors.fullTint,
          dark ? KhaanaColors.fullDark : KhaanaColors.full,
          Icons.warning_amber_rounded,
        ),
      CapacityKind.closed => (
          dark ? KhaanaColors.closedTintDark : KhaanaColors.closedTint,
          dark ? KhaanaColors.closedDark : KhaanaColors.closed,
          Icons.lock_outline_rounded,
        ),
      CapacityKind.info => (
          dark ? KhaanaColors.infoTintDark : KhaanaColors.infoTint,
          dark ? KhaanaColors.infoDark : KhaanaColors.info,
          Icons.info_outline_rounded,
        ),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: fg.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon ?? defaultIcon, size: 18, color: fg),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: fg, fontSize: 13, fontWeight: FontWeight.w600, height: 18 / 13),
            ),
          ),
          if (actionLabel != null && onAction != null)
            TextButton(
              onPressed: onAction,
              child: Text(actionLabel!, style: TextStyle(color: fg, fontWeight: FontWeight.w800)),
            ),
        ],
      ),
    );
  }
}

class KhaanaPrimaryButton extends StatelessWidget {
  const KhaanaPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        onPressed: loading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: KhaanaColors.orange,
          foregroundColor: KhaanaColors.charcoal,
          disabledBackgroundColor: dark ? KhaanaColors.surface2Dark : KhaanaColors.surface2Light,
          disabledForegroundColor: dark ? KhaanaColors.mutedDark : KhaanaColors.mutedLight,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loading) ...[
              const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(KhaanaColors.charcoal),
                ),
              ),
              const SizedBox(width: 10),
            ] else if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 8),
            ],
            Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
    );
  }
}

class KhaanaSecondaryButton extends StatelessWidget {
  const KhaanaSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface;
    return SizedBox(
      height: 48,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18),
              const SizedBox(width: 8),
            ],
            Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

enum CapacityKind { available, limited, full, closed, info }

class CapacityBadge extends StatelessWidget {
  const CapacityBadge({super.key, required this.kind, required this.label});

  final CapacityKind kind;
  final String label;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final (bg, fg, icon) = switch (kind) {
      CapacityKind.available => (
          dark ? KhaanaColors.availableTintDark : KhaanaColors.availableTint,
          dark ? KhaanaColors.availableDark : KhaanaColors.available,
          Icons.check,
        ),
      CapacityKind.limited => (
          dark ? KhaanaColors.limitedTintDark : KhaanaColors.limitedTint,
          dark ? KhaanaColors.limitedDark : KhaanaColors.limited,
          Icons.schedule,
        ),
      CapacityKind.full => (
          dark ? KhaanaColors.fullTintDark : KhaanaColors.fullTint,
          dark ? KhaanaColors.fullDark : KhaanaColors.full,
          Icons.close,
        ),
      CapacityKind.closed => (
          dark ? KhaanaColors.closedTintDark : KhaanaColors.closedTint,
          dark ? KhaanaColors.closedDark : KhaanaColors.closed,
          Icons.lock_outline,
        ),
      CapacityKind.info => (
          dark ? KhaanaColors.infoTintDark : KhaanaColors.infoTint,
          dark ? KhaanaColors.infoDark : KhaanaColors.info,
          Icons.near_me_outlined,
        ),
    };
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 4, 10, 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

/// 12-segment Kitchen Capacity Meter from Design System v1.0.
class KitchenCapacityMeter extends StatelessWidget {
  const KitchenCapacityMeter({
    super.key,
    required this.title,
    required this.booked,
    required this.limit,
    this.segments = 12,
  });

  final String title;
  final int booked;
  final int limit;
  final int segments;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final pct = limit <= 0 ? 100 : ((booked * 100) / limit).round();
    final band = PrototypeAssumptions.intakeBandLabel(pct);
    final filledCount = limit <= 0 ? segments : ((booked / limit) * segments).round().clamp(0, segments);
    final (activeColor, kind, badgeLabel) = switch (band) {
      'Full' => (const Color(0xFFDC2626), CapacityKind.full, 'Intake paused'),
      'Limited' => (const Color(0xFFEAB308), CapacityKind.limited, 'Limited'),
      _ => (const Color(0xFF16A34A), CapacityKind.available, 'Available'),
    };
    final emptyColor = dark ? KhaanaColors.lineDark : KhaanaColors.lineLight;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: emptyColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
              ),
              const SizedBox(width: 8),
              Text(
                '$booked of $limit orders',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              for (var i = 0; i < segments; i++) ...[
                if (i > 0) const SizedBox(width: 3),
                Expanded(
                  child: Container(
                    height: 14,
                    decoration: BoxDecoration(
                      color: i < filledCount ? activeColor : emptyColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          CapacityBadge(kind: kind, label: badgeLabel),
        ],
      ),
    );
  }
}

/// 4-cell per-serving nutrition table from Design System v1.0.
class NutritionStrip extends StatelessWidget {
  const NutritionStrip({
    super.key,
    required this.kcal,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  final int kcal;
  final String protein;
  final String carbs;
  final String fat;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final borderCol = dark ? KhaanaColors.lineDark : const Color(0xFFD9C3A5);
    final muted = dark ? KhaanaColors.mutedDark : KhaanaColors.mutedLight;
    final items = [
      ('$kcal', 'KCAL'),
      (protein, 'PROTEIN'),
      (carbs, 'CARBS'),
      (fat, 'FAT'),
    ];
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderCol),
      ),
      child: Row(
        children: [
          for (var i = 0; i < items.length; i++)
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                decoration: BoxDecoration(
                  border: i < items.length - 1 ? Border(right: BorderSide(color: borderCol)) : null,
                ),
                child: Column(
                  children: [
                    Text(
                      items[i].$1,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      items[i].$2,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                        color: muted,
                      ),
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

/// Vertical connected order timeline from Design System v1.0.
class OrderStatusTimeline extends StatelessWidget {
  const OrderStatusTimeline({
    super.key,
    required this.steps,
    required this.activeIndex,
  });

  final List<(String title, String subtitle)> steps;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final lineCol = dark ? KhaanaColors.lineDark : const Color(0xFFD9C3A5);
    final muted = dark ? KhaanaColors.mutedDark : KhaanaColors.mutedLight;

    return Column(
      children: [
        for (var i = 0; i < steps.length; i++)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i < activeIndex
                            ? const Color(0xFF16A34A)
                            : Theme.of(context).colorScheme.surface,
                        border: Border.all(
                          color: i < activeIndex
                              ? const Color(0xFF16A34A)
                              : i == activeIndex
                                  ? const Color(0xFF0284C7)
                                  : (dark ? KhaanaColors.fieldDark : KhaanaColors.fieldLight),
                          width: 2.2,
                        ),
                        boxShadow: i == activeIndex
                            ? [
                                BoxShadow(
                                  color: (dark ? KhaanaColors.infoTintDark : KhaanaColors.infoTint),
                                  spreadRadius: 4,
                                ),
                              ]
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: i < activeIndex
                          ? const Icon(Icons.check, size: 14, color: Colors.white)
                          : i == activeIndex
                              ? Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF0284C7),
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : null,
                    ),
                    if (i < steps.length - 1)
                      Expanded(
                        child: Container(
                          width: 2,
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          color: i < activeIndex ? const Color(0xFF16A34A) : lineCol,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          steps[i].$1,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: i == activeIndex ? FontWeight.w800 : FontWeight.w600,
                            color: i > activeIndex ? muted : null,
                          ),
                        ),
                        if (steps[i].$2.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            steps[i].$2,
                            style: TextStyle(fontSize: 12, color: muted),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Customer 4-tab Bottom Navigation Bar with the Design System orange active pill.
class KhaanaBottomNav extends StatelessWidget {
  const KhaanaBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.cartCount = 0,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final int cartCount;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final items = const [
      (Icons.home_outlined, Icons.home_rounded, 'Home'),
      (Icons.shopping_bag_outlined, Icons.shopping_bag_rounded, 'Orders'),
      (Icons.chat_bubble_outline_rounded, Icons.chat_bubble_rounded, 'Assistant'),
      (Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
    ];
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: InkWell(
                    onTap: () => onTap(i),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 52,
                          height: 28,
                          decoration: BoxDecoration(
                            color: currentIndex == i ? KhaanaColors.orange : Colors.transparent,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            currentIndex == i ? items[i].$2 : items[i].$1,
                            size: 20,
                            color: currentIndex == i
                                ? KhaanaColors.charcoal
                                : (dark ? KhaanaColors.mutedDark : KhaanaColors.mutedLight),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          items[i].$3,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: currentIndex == i
                                ? Theme.of(context).colorScheme.onSurface
                                : (dark ? KhaanaColors.mutedDark : KhaanaColors.mutedLight),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProvisionalNote extends StatelessWidget {
  const ProvisionalNote({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: dark ? KhaanaColors.surface2Dark : KhaanaColors.surface2Light,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.science_outlined, size: 15, color: Theme.of(context).colorScheme.outline),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${PrototypeAssumptions.statusLabel}. $text',
                style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.outline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PriceLines extends StatelessWidget {
  const PriceLines({super.key, required this.lines, required this.total});

  final List<(String, int)> lines;
  final int total;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        for (final line in lines)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Expanded(child: Text(line.$1, style: const TextStyle(fontSize: 14))),
                Text(
                  formatRupees(line.$2),
                  style: TextStyle(
                    fontSize: 14,
                    fontFeatures: const [FontFeature.tabularFigures()],
                    color: line.$2 < 0 ? (dark ? KhaanaColors.availableDark : KhaanaColors.available) : null,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 6),
          child: Divider(),
        ),
        Row(
          children: [
            const Expanded(child: Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800))),
            Text(
              formatRupees(total),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SimulatedMap extends StatelessWidget {
  const SimulatedMap({super.key, required this.address, required this.onRetry, this.restored = false});

  final String address;
  final VoidCallback onRetry;
  final bool restored;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 170,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomPaint(
                  painter: _MapGridPainter(dark: dark, active: restored),
                ),
                if (!restored)
                  Container(
                    color: (dark ? KhaanaColors.fullTintDark : KhaanaColors.fullTint).withValues(alpha: 0.85),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_off_outlined,
                          size: 32,
                          color: dark ? KhaanaColors.fullDark : KhaanaColors.full,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Map unavailable',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: dark ? KhaanaColors.fullDark : KhaanaColors.full,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Tile provider offline · Tap Retry to load simulated route',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: dark ? KhaanaColors.fullDark : KhaanaColors.full,
                          ),
                        ),
                      ],
                    ),
                  )
                else ...[
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: KhaanaColors.charcoal.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.delivery_dining_rounded, size: 16, color: KhaanaColors.orange),
                          SizedBox(width: 6),
                          Text(
                            'Simulated map · Live GPS route',
                            style: TextStyle(color: KhaanaColors.cream, fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: KhaanaColors.orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.pin_drop_rounded, size: 15, color: KhaanaColors.charcoal),
                          SizedBox(width: 4),
                          Text(
                            '3.2 km · F-11 Markaz',
                            style: TextStyle(color: KhaanaColors.charcoal, fontSize: 12, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.place_rounded, size: 18, color: KhaanaColors.orange),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(address, style: const TextStyle(fontWeight: FontWeight.w700)),
                    ),
                    KhaanaSecondaryButton(
                      label: restored ? 'Simulate error' : 'Retry',
                      onPressed: onRetry,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Maps and live tracking are simulated until a provider is integrated.',
                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.outline),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  const _MapGridPainter({required this.dark, required this.active});

  final bool dark;
  final bool active;

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = dark ? const Color(0xFF22252A) : const Color(0xFFF3E8D8);
    canvas.drawRect(Offset.zero & size, bgPaint);

    final roadPaint = Paint()
      ..color = dark ? const Color(0xFF333840) : const Color(0xFFE2D3BE)
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    for (var x = 30.0; x < size.width; x += 65) {
      canvas.drawLine(Offset(x, 0), Offset(x + 20, size.height), roadPaint);
    }
    for (var y = 25.0; y < size.height; y += 45) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y - 10), roadPaint);
    }

    if (!active) return;

    final routePaint = Paint()
      ..color = KhaanaColors.orange
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final start = Offset(size.width * 0.18, size.height * 0.72);
    final mid1 = Offset(size.width * 0.42, size.height * 0.65);
    final mid2 = Offset(size.width * 0.58, size.height * 0.36);
    final end = Offset(size.width * 0.82, size.height * 0.28);

    final path = Path()
      ..moveTo(start.dx, start.dy)
      ..lineTo(mid1.dx, mid1.dy)
      ..lineTo(mid2.dx, mid2.dy)
      ..lineTo(end.dx, end.dy);
    canvas.drawPath(path, routePaint);

    // Store pin
    canvas.drawCircle(start, 9, Paint()..color = KhaanaColors.charcoal);
    canvas.drawCircle(start, 5, Paint()..color = KhaanaColors.orange);

    // Rider live position
    canvas.drawCircle(mid2, 12, Paint()..color = const Color(0xFF0284C7).withValues(alpha: 0.28));
    canvas.drawCircle(mid2, 7, Paint()..color = const Color(0xFF0284C7));

    // Customer pin
    canvas.drawCircle(end, 10, Paint()..color = const Color(0xFF16A34A));
    canvas.drawCircle(end, 4, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant _MapGridPainter oldDelegate) =>
      oldDelegate.dark != dark || oldDelegate.active != active;
}

class HoldButton extends StatefulWidget {
  const HoldButton({super.key, required this.label, required this.doneLabel, required this.onConfirmed});

  final String label;
  final String doneLabel;
  final VoidCallback onConfirmed;

  @override
  State<HoldButton> createState() => _HoldButtonState();
}

class _HoldButtonState extends State<HoldButton> {
  Timer? _timer;
  var _done = false;
  var _progress = 0.0;

  void _start() {
    if (_done) return;
    _timer?.cancel();
    final started = DateTime.now();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      final elapsed = DateTime.now().difference(started).inMilliseconds / 900;
      if (elapsed >= 1) {
        timer.cancel();
        setState(() {
          _done = true;
          _progress = 1;
        });
        widget.onConfirmed();
      } else {
        setState(() => _progress = elapsed);
      }
    });
  }

  void _cancel() {
    if (_done) return;
    _timer?.cancel();
    setState(() => _progress = 0);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTapDown: (_) => _start(),
      onTapUp: (_) => _cancel(),
      onTapCancel: _cancel,
      child: Container(
        height: 72,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _done ? const Color(0xFF22C55E) : KhaanaColors.orange,
            width: 2.5,
          ),
          color: _done
              ? (dark ? KhaanaColors.availableTintDark : KhaanaColors.availableTint)
              : (dark ? const Color(0xFF2A1A0E) : KhaanaColors.orangeTint),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _progress,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: KhaanaColors.orange,
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(13)),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _done ? Icons.check_circle_rounded : Icons.touch_app_rounded,
                  color: _done
                      ? (dark ? KhaanaColors.availableDark : KhaanaColors.available)
                      : (_progress > 0.45
                          ? KhaanaColors.charcoal
                          : (dark ? KhaanaColors.onOrangeTintDark : KhaanaColors.charcoal)),
                ),
                const SizedBox(width: 10),
                Text(
                  _done ? widget.doneLabel : widget.label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: _done
                        ? (dark ? KhaanaColors.availableDark : KhaanaColors.available)
                        : (_progress > 0.45
                            ? KhaanaColors.charcoal
                            : (dark ? KhaanaColors.onOrangeTintDark : KhaanaColors.charcoal)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AccessDenied extends StatelessWidget {
  const AccessDenied({super.key, this.uiId = 'E1-US3-UI3', this.attemptedRoute});

  final String uiId;
  final String? attemptedRoute;

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: uiId,
      title: 'No access',
      child: KhaanaErrorState(
        title: 'You do not have access to this page',
        message:
            'Staff accounts cannot view owner finance, bank details, commission, recipes, audit logs, or bill of materials.${attemptedRoute != null ? ' (Blocked route: $attemptedRoute)' : ''}',
        onRetry: () => Navigator.maybePop(context),
      ),
    );
  }
}

/// Shared Overlay `E22-US3-UI1`: Offline banner and pending-sync badge.
/// Shows offline banner, each queued status action marked Pending, ordered sync after reconnection,
/// and never shows unsynced actions as confirmed.
class OfflineSyncBanner extends StatefulWidget {
  const OfflineSyncBanner({
    super.key,
    this.initialOffline = true,
    this.initialPendingActions = const [
      'Order #123 · Mark 80% prepared',
      'Order #121 · Mark Ready / Bagged',
    ],
    this.onShowConflict,
  });

  final bool initialOffline;
  final List<String> initialPendingActions;
  final VoidCallback? onShowConflict;

  @override
  State<OfflineSyncBanner> createState() => _OfflineSyncBannerState();
}

class _OfflineSyncBannerState extends State<OfflineSyncBanner> {
  late bool _offline = widget.initialOffline;
  late List<String> _pending = List<String>.from(widget.initialPendingActions);
  final List<String> _synced = [];

  void _queueSampleAction() {
    setState(() {
      _pending.add('Action #${_pending.length + _synced.length + 1} · Status update queued while offline');
    });
  }

  void _reconnectAndSync() {
    setState(() {
      _offline = false;
      _synced.addAll(_pending);
      _pending.clear();
    });
  }

  void _goOffline() {
    setState(() {
      _offline = true;
      if (_pending.isEmpty) {
        _pending.addAll(widget.initialPendingActions);
        _synced.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      color: _offline
          ? (dark ? KhaanaColors.limitedTintDark : KhaanaColors.limitedTint)
          : (dark ? KhaanaColors.availableTintDark : KhaanaColors.availableTint),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: _offline
              ? (dark ? KhaanaColors.limitedDark : KhaanaColors.limited)
              : (dark ? KhaanaColors.availableDark : KhaanaColors.available),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: dark ? KhaanaColors.surface2Dark : KhaanaColors.surface2Light,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'E22-US3-UI1',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  _offline ? Icons.cloud_off_rounded : Icons.cloud_done_rounded,
                  size: 20,
                  color: _offline
                      ? (dark ? KhaanaColors.limitedDark : KhaanaColors.limited)
                      : (dark ? KhaanaColors.availableDark : KhaanaColors.available),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _offline
                        ? 'Offline · Actions queued locally (not confirmed on server)'
                        : 'Online · Queued actions synced in order',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                ),
                CapacityBadge(
                  kind: _offline ? CapacityKind.limited : CapacityKind.available,
                  label: _offline ? '${_pending.length} Pending' : 'Synced',
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Unsynced actions remain marked Pending and are never shown as confirmed until reconnection completes.',
              style: TextStyle(fontSize: 12),
            ),
            if (_pending.isNotEmpty) ...[
              const SizedBox(height: 10),
              for (var i = 0; i < _pending.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      const Icon(Icons.schedule_rounded, size: 16, color: KhaanaColors.limited),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${i + 1}. ${_pending[i]}',
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const CapacityBadge(kind: CapacityKind.limited, label: 'Pending'),
                    ],
                  ),
                ),
            ],
            if (_synced.isNotEmpty) ...[
              const SizedBox(height: 10),
              for (var i = 0; i < _synced.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline, size: 16, color: KhaanaColors.available),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${i + 1}. ${_synced[i]}',
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const CapacityBadge(kind: CapacityKind.available, label: 'Confirmed'),
                    ],
                  ),
                ),
            ],
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (_offline) ...[
                  KhaanaSecondaryButton(
                    label: 'Queue action while offline',
                    icon: Icons.add_circle_outline_rounded,
                    onPressed: _queueSampleAction,
                  ),
                  KhaanaSecondaryButton(
                    label: 'Reconnect & flush queue in order',
                    icon: Icons.sync_rounded,
                    onPressed: _reconnectAndSync,
                  ),
                ] else
                  KhaanaSecondaryButton(
                    label: 'Simulate connectivity drop',
                    icon: Icons.cloud_off_rounded,
                    onPressed: _goOffline,
                  ),
                TextButton.icon(
                  onPressed: widget.onShowConflict ?? () => showSyncConflictDialog(context),
                  icon: const Icon(Icons.compare_arrows_rounded, size: 16),
                  label: const Text('Preview Sync Conflict (E22-US3-UI2)'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Shared Overlay `E22-US3-UI2`: Sync conflict message (AC2).
/// Shows what changed while offline and which version was kept.
Future<void> showSyncConflictDialog(
  BuildContext context, {
  String itemTitle = 'Order #KG-1042 status update',
  String offlineChange = 'Offline queued action: Mark order "Preparing" at 6:48 PM',
  String serverChange = 'While offline: Customer cancelled order #KG-1042 at 6:46 PM before preparation',
  String keptVersion = 'Server version kept (Cancelled · Stock restored & invoice voided). Your offline transition was discarded safely without duplicate replay.',
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => SyncConflictDialog(
      itemTitle: itemTitle,
      offlineChange: offlineChange,
      serverChange: serverChange,
      keptVersion: keptVersion,
    ),
  );
}

class SyncConflictDialog extends StatelessWidget {
  const SyncConflictDialog({
    super.key,
    this.itemTitle = 'Order #KG-1042 status update',
    this.offlineChange = 'Offline queued action: Mark order "Preparing" at 6:48 PM',
    this.serverChange = 'While offline: Customer cancelled order #KG-1042 at 6:46 PM before preparation',
    this.keptVersion =
        'Server version kept (Cancelled · Stock restored & invoice voided). Your offline transition was discarded safely without duplicate replay.',
  });

  final String itemTitle;
  final String offlineChange;
  final String serverChange;
  final String keptVersion;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: KhaanaColors.orangeTint,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'E22-US3-UI2',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: KhaanaColors.onOrangeTint),
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text('Sync conflict resolved', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          ),
        ],
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(itemTitle, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
              const SizedBox(height: 10),
              KhaanaInlineBanner(
                kind: CapacityKind.limited,
                icon: Icons.edit_off_outlined,
                text: offlineChange,
              ),
              const SizedBox(height: 8),
              KhaanaInlineBanner(
                kind: CapacityKind.info,
                icon: Icons.cloud_sync_outlined,
                text: serverChange,
              ),
              const SizedBox(height: 12),
              const Text('Resolution (Which version was kept):', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
              const SizedBox(height: 4),
              Text(keptVersion, style: const TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Acknowledge'),
        ),
      ],
    );
  }
}

/// E22-US3-UI3: Something went wrong
/// Must show: Friendly error and Retry
class SomethingWentWrongScreen extends StatelessWidget {
  const SomethingWentWrongScreen({
    super.key,
    this.onRetry,
  });

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E22-US3-UI3',
      title: 'Something went wrong',
      child: KhaanaErrorState(
        title: 'Something went wrong',
        message: 'We encountered an unexpected issue loading this view. Your active order and cart data are safe. Tap Retry to reload.',
        onRetry: onRetry ?? () => Navigator.maybePop(context),
      ),
    );
  }
}

/// E22-US1-UI2: Page not found (web)
/// Must show: Return to Home or Portal
class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({
    super.key,
    this.homeRoute = '/home',
    this.portalLabel = 'Return to Home / Portal',
  });

  final String homeRoute;
  final String portalLabel;

  @override
  Widget build(BuildContext context) {
    return KhaanaPage(
      uiId: 'E22-US1-UI2',
      title: 'Page not found (404)',
      footer: KhaanaPrimaryButton(
        label: portalLabel,
        icon: Icons.home_outlined,
        onPressed: () => Navigator.pushReplacementNamed(context, homeRoute),
      ),
      child: const KhaanaEmptyState(
        title: '404 · Page not found',
        message: 'The web address or route you requested does not exist on KhaanaGo. Use the button below to return to Home or the Portal.',
        icon: Icons.search_off_rounded,
      ),
    );
  }
}
