import 'package:flutter/material.dart';

import 'tokens.dart';

enum KhaanaButtonVariant { primary, secondary, ghost }

enum BrandLogoVariant { stacked, onLight, onDark }

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.variant = BrandLogoVariant.stacked});

  final BrandLogoVariant variant;

  @override
  Widget build(BuildContext context) {
    final file = switch (variant) {
      BrandLogoVariant.stacked => 'assets/brand/khaanago-logo.png',
      BrandLogoVariant.onLight => 'assets/brand/khaanago-wordmark.png',
      BrandLogoVariant.onDark => 'assets/brand/khaanago-wordmark.png',
    };
    final height = variant == BrandLogoVariant.stacked ? 160.0 : 28.0;
    return Image.asset(
      file,
      package: 'khaana_screens',
      height: height,
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) => _WordmarkFallback(variant: variant),
    );
  }
}

class _WordmarkFallback extends StatelessWidget {
  const _WordmarkFallback({required this.variant});

  final BrandLogoVariant variant;

  @override
  Widget build(BuildContext context) {
    final onPrimary = variant == BrandLogoVariant.stacked;
    final onDark = variant == BrandLogoVariant.onDark;
    final base = onPrimary || onDark ? KhaanaColors.onBrand : KhaanaColors.ink;
    final accent = onPrimary ? KhaanaColors.onBrand : KhaanaColors.brand;
    final size = variant == BrandLogoVariant.stacked ? 28.0 : 20.0;
    return Text.rich(TextSpan(style: TextStyle(fontSize: size, height: 1.2, fontWeight: FontWeight.w800, color: base), children: [
      const TextSpan(text: 'Khaana'),
      TextSpan(text: 'Go', style: TextStyle(color: accent)),
    ]));
  }
}

class BrandAppBarTitle extends StatelessWidget {
  const BrandAppBarTitle({super.key, required this.title, this.onLongPress});

  final String title;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Row(children: [
        const BrandLogo(variant: BrandLogoVariant.onLight),
        const SizedBox(width: KhaanaSpace.s2),
        Flexible(child: Text(title, overflow: TextOverflow.ellipsis)),
      ]),
    );
  }
}

class KhaanaButton extends StatelessWidget {
  const KhaanaButton({super.key, required this.label, required this.onPressed, this.variant = KhaanaButtonVariant.primary, this.loading = false, this.tall = false});

  final String label;
  final VoidCallback? onPressed;
  final KhaanaButtonVariant variant;
  final bool loading;
  final bool tall;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !loading;
    final height = tall ? KhaanaType.controlRider : KhaanaType.control;
    final child = loading
        ? SizedBox(width: KhaanaSpace.s5, height: KhaanaSpace.s5, child: CircularProgressIndicator(strokeWidth: 2, color: variant == KhaanaButtonVariant.primary ? KhaanaColors.onBrand : KhaanaColors.brand))
        : Text(label);
    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(KhaanaRadius.button));
    final style = switch (variant) {
      KhaanaButtonVariant.primary => FilledButton.styleFrom(
          backgroundColor: KhaanaColors.brand,
          disabledBackgroundColor: KhaanaColors.surface2,
          foregroundColor: KhaanaColors.onBrand,
          disabledForegroundColor: KhaanaColors.muted,
          minimumSize: Size.fromHeight(height),
          textStyle: tall ? KhaanaType.riderButton : KhaanaType.button,
          shape: shape,
        ).copyWith(backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return KhaanaColors.surface2;
          if (states.contains(WidgetState.pressed)) return KhaanaColors.brandPress;
          return KhaanaColors.brand;
        })),
      KhaanaButtonVariant.secondary => OutlinedButton.styleFrom(
          foregroundColor: KhaanaColors.ink,
          disabledForegroundColor: KhaanaColors.muted,
          side: const BorderSide(color: KhaanaColors.ink),
          minimumSize: Size.fromHeight(height),
          textStyle: KhaanaType.button.copyWith(color: KhaanaColors.ink),
          shape: shape,
        ),
      KhaanaButtonVariant.ghost => TextButton.styleFrom(
          foregroundColor: KhaanaColors.ink,
          disabledForegroundColor: KhaanaColors.muted,
          minimumSize: Size.fromHeight(height),
          textStyle: KhaanaType.button.copyWith(color: KhaanaColors.ink),
          shape: shape,
        ),
    };
    final press = enabled ? onPressed : null;
    return switch (variant) {
      KhaanaButtonVariant.primary => FilledButton(onPressed: press, style: style, child: child),
      KhaanaButtonVariant.secondary => OutlinedButton(onPressed: press, style: style, child: child),
      KhaanaButtonVariant.ghost => TextButton(onPressed: press, style: style, child: child),
    };
  }
}

class KhaanaCard extends StatelessWidget {
  const KhaanaCard({super.key, required this.child, this.padding = KhaanaSpace.card});

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: KhaanaColors.white,
      elevation: 0,
      shadowColor: KhaanaColors.charcoal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(KhaanaRadius.card),
        side: const BorderSide(color: KhaanaColors.line),
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

class KhaanaChip extends StatelessWidget {
  const KhaanaChip({super.key, required this.label, required this.selected, required this.onSelected});

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      showCheckmark: false,
      selectedColor: KhaanaColors.brand,
      backgroundColor: KhaanaColors.cream,
      side: BorderSide(color: selected ? KhaanaColors.brand : KhaanaColors.line),
      shape: StadiumBorder(side: BorderSide(color: selected ? KhaanaColors.brand : KhaanaColors.line)),
      labelStyle: KhaanaType.caption.copyWith(color: selected ? KhaanaColors.onBrand : KhaanaColors.muted, fontWeight: FontWeight.w700),
      onSelected: onSelected,
    );
  }
}

class KhaanaStatusBadge extends StatelessWidget {
  const KhaanaStatusBadge({super.key, required this.label, this.tone = 'available'});

  final String label;
  final String tone;

  @override
  Widget build(BuildContext context) {
    final (color, tint) = switch (tone) {
      'full' => (KhaanaColors.full, KhaanaColors.fullTint),
      'limited' => (KhaanaColors.limited, KhaanaColors.limitedTint),
      'closed' => (KhaanaColors.closed, KhaanaColors.closedTint),
      'info' => (KhaanaColors.info, KhaanaColors.infoTint),
      _ => (KhaanaColors.ok, KhaanaColors.okTint),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: KhaanaSpace.s2, vertical: KhaanaSpace.s2),
      decoration: BoxDecoration(color: tint, borderRadius: BorderRadius.circular(KhaanaRadius.pill)),
      child: Text(label, style: KhaanaType.caption.copyWith(color: color, fontWeight: FontWeight.w800)),
    );
  }
}

class KhaanaEmptyState extends StatelessWidget {
  const KhaanaEmptyState({super.key, required this.message, this.action});

  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(KhaanaSpace.s4),
      decoration: BoxDecoration(color: KhaanaColors.cream, borderRadius: BorderRadius.circular(KhaanaRadius.card)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(message, style: KhaanaType.body.copyWith(color: KhaanaColors.muted)),
        if (action != null) ...[const SizedBox(height: KhaanaSpace.s3), action!],
      ]),
    );
  }
}

class KhaanaErrorState extends StatelessWidget {
  const KhaanaErrorState({super.key, required this.title, required this.message, required this.actionLabel, required this.onRetry});

  final String title;
  final String message;
  final String actionLabel;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(title, style: KhaanaType.title),
          const SizedBox(height: KhaanaSpace.s2),
          Text(message, textAlign: TextAlign.center, style: KhaanaType.body.copyWith(color: KhaanaColors.muted)),
          const SizedBox(height: KhaanaSpace.s4),
          KhaanaButton(label: actionLabel, onPressed: onRetry),
        ]),
      ),
    );
  }
}

class KhaanaSkeleton extends StatelessWidget {
  const KhaanaSkeleton({super.key, this.lines = 3});

  final int lines;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (var index = 0; index < lines; index++) ...[
        if (index > 0) const SizedBox(height: KhaanaSpace.s2),
        Container(
          height: KhaanaSpace.s4,
          width: index == lines - 1 ? 160 : double.infinity,
          decoration: BoxDecoration(color: KhaanaColors.surface2, borderRadius: BorderRadius.circular(KhaanaRadius.button)),
        ),
      ],
    ]);
  }
}

class KhaanaStep {
  const KhaanaStep({required this.label, this.time = ''});

  final String label;
  final String time;
}

class KhaanaStepper extends StatelessWidget {
  const KhaanaStepper({super.key, required this.steps, required this.current, this.finished = false, this.currentKey});

  final List<KhaanaStep> steps;
  final int current;
  final bool finished;
  final Key? currentKey;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (var index = 0; index < steps.length; index++)
        _KhaanaStepRow(
          label: steps[index].label,
          time: steps[index].time,
          highlighted: index == current,
          done: index < current || finished,
          last: index == steps.length - 1,
          labelKey: index == current ? currentKey : null,
        ),
    ]);
  }
}

class _KhaanaStepRow extends StatelessWidget {
  const _KhaanaStepRow({required this.label, required this.time, required this.highlighted, required this.done, required this.last, this.labelKey});

  final String label;
  final String time;
  final bool highlighted;
  final bool done;
  final bool last;
  final Key? labelKey;

  @override
  Widget build(BuildContext context) {
    final color = done ? KhaanaColors.ok : highlighted ? KhaanaColors.info : KhaanaColors.muted;
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        width: KhaanaSpace.s4,
        child: Column(children: [
          Container(
            width: KhaanaSpace.s4,
            height: KhaanaSpace.s4,
            decoration: BoxDecoration(
              color: done || highlighted ? color : KhaanaColors.white,
              shape: BoxShape.circle,
              border: Border.all(color: done || highlighted ? color : KhaanaColors.line, width: 2),
            ),
          ),
          if (!last) Container(width: 2, height: KhaanaSpace.s6, color: done ? KhaanaColors.ok : KhaanaColors.line),
        ]),
      ),
      const SizedBox(width: KhaanaSpace.s4),
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(bottom: last ? 0 : KhaanaSpace.s4),
          child: Row(children: [
            Expanded(
              child: Text(
                label,
                key: labelKey,
                style: KhaanaType.body.copyWith(fontWeight: highlighted ? FontWeight.w800 : FontWeight.w600, color: color),
              ),
            ),
            if (time.isNotEmpty) Text(time, style: KhaanaType.caption),
          ]),
        ),
      ),
    ]);
  }
}
