/// Provisional values copied from `config/prototype-assumptions.json`.
///
/// These are decisions awaiting team and supervisor review.
/// They are not approved Chapter 2 requirements.
/// The Android minimum version is intentionally omitted. The conflict
/// between "Android 10 or older" and "Android 10 and up" stays open.
class PrototypeAssumptions {
  const PrototypeAssumptions._();

  static const statusLabel = 'Provisional · awaiting review';

  static const passwordMinCharacters = 8;
  static const passwordMaxCharacters = 128;
  static const backendPasswordPolicy = 'pending_review';

  static const instructionMaxCharacters = 500;

  static const imageAllowedTypes = ['jpg', 'jpeg', 'png'];
  static const imageMaxBytes = 5242880;

  static const slotHoldSeconds = 300;
  static const availableBelowPercent = 60;
  static const limitedFromPercent = 60;
  static const fullAtOrAbovePercent = 85;

  static const deliveryCodeLength = 6;

  static const checkInGraceSeconds = 120;
  static const secondPickupHoldSeconds = 300;
  static const freeWaitingSeconds = 480;

  /// Null until a rate is chosen. Do not display a rupee amount.
  static const int? waitingPayRatePerMinute = null;

  static const pooledDiscountPercent = 30;
  static const pooledExtraMinutesMin = 10;
  static const pooledExtraMinutesMax = 15;

  static const mapsAreSimulated = true;

  static String intakeBandLabel(int percent) {
    if (percent >= fullAtOrAbovePercent) return 'Full';
    if (percent >= limitedFromPercent) return 'Limited';
    return 'Available';
  }
}
