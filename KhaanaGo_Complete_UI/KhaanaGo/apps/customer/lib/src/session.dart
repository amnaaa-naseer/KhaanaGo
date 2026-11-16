import 'package:flutter/foundation.dart';
import 'package:khaana_design/khaana_design.dart';

class VendorPlace {
  const VendorPlace({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.area,
    required this.open,
    required this.intakePercent,
    required this.rating,
    required this.opensAt,
    this.etaRange = '25–35 min',
    this.bookedHourly = 7,
    this.limitHourly = 12,
    this.tagline = 'Freshly prepared to kitchen capacity',
  });

  final String id;
  final String name;
  final String cuisine;
  final String area;
  final bool open;
  final int intakePercent;
  final double rating;
  final String opensAt;
  final String etaRange;
  final int bookedHourly;
  final int limitHourly;
  final String tagline;

  String get band =>
      open ? PrototypeAssumptions.intakeBandLabel(intakePercent) : 'Closed';
}

class Dish {
  const Dish({
    required this.id,
    required this.vendorId,
    required this.name,
    required this.category,
    required this.price,
    required this.available,
    required this.customizable,
    required this.fragile,
    this.description =
        'Prepared fresh per order with verified kitchen prep windows.',
    this.kcal,
    this.protein,
    this.carbs,
    this.fat,
    this.allergen,
    this.prepMinutes = 25,
    this.popular = false,
  });

  final String id;
  final String vendorId;
  final String name;
  final String category;
  final int price;
  final bool available;
  final bool customizable;
  final bool fragile;
  final String description;
  final int? kcal;
  final String? protein;
  final String? carbs;
  final String? fat;
  final String? allergen;
  final int prepMinutes;
  final bool popular;

  bool get hasNutrition => kcal != null;
}

class CartLine {
  CartLine({
    required this.dish,
    this.qty = 1,
    this.size,
    this.flavour,
    this.customText = '',
  });

  final Dish dish;
  int qty;
  String? size;
  String? flavour;
  String customText;

  int get unitPrice {
    var price = dish.price;
    if (size == '2 lb') price += 400;
    if (flavour == 'Vanilla') price += 0;
    return price;
  }

  int get lineTotal => unitPrice * qty;

  int get prepMinutes => dish.prepMinutes + (size == '2 lb' ? 20 : 0);
}

class DeliverySlot {
  DeliverySlot({
    required this.label,
    required this.booked,
    required this.capacity,
  });

  final String label;
  int booked;
  final int capacity;

  int get percent => capacity == 0 ? 100 : ((booked * 100) / capacity).round();
  int get remaining => capacity - booked;
  bool get isFull => PrototypeAssumptions.intakeBandLabel(percent) == 'Full';
  String get band => PrototypeAssumptions.intakeBandLabel(percent);
}

class CustomerOrderRecord {
  const CustomerOrderRecord({
    required this.id,
    required this.vendorName,
    required this.dateLabel,
    required this.itemsSummary,
    required this.total,
    required this.status,
    required this.invoiceNumber,
    required this.paymentStatus,
  });

  final String id;
  final String vendorName;
  final String dateLabel;
  final String itemsSummary;
  final int total;
  final String status;
  final String invoiceNumber;
  final String paymentStatus;
}

class CustomerSession extends ChangeNotifier {
  final addresses = [
    'Home · F-11 Markaz',
    'Office · G-9',
    'Hostel · H-12 NUST',
  ];
  String address = 'Home · F-11 Markaz';
  String customerName = 'Ayesha Khan';
  String customerMobile = '0300-1234567';
  String customerEmail = 'ayesha@example.com';
  String search = '';
  String selectedCategory = 'All';
  String selectedDietaryTag = 'Any';
  bool openNowOnly = true;
  bool sessionExpired = false;
  bool mapVisible = true;
  bool submitted = false;
  bool homeNetworkError = false;
  String? referenceImageName;
  String? specialInstructions;
  String? appliedVoucherCode;
  int voucherDiscount = 0;

  final List<CustomerOrderRecord> orderHistory = const [
    CustomerOrderRecord(
      id: 'KG-1042',
      vendorName: 'BakeCharm',
      dateLabel: 'Today · 6:30 PM Slot',
      itemsSummary:
          '1× Chocolate Cake (1 lb, No nuts) + 1× Brownie Box (Sold out)',
      total: 2014,
      status: 'Preparing',
      invoiceNumber: 'INV-2026-1042',
      paymentStatus: 'Paid (JazzCash)',
    ),
    CustomerOrderRecord(
      id: 'KG-1038',
      vendorName: 'Lazeez Cloud Kitchen',
      dateLabel: 'Yesterday · 8:00 PM Slot',
      itemsSummary: '1× Chicken Karahi + 1× Garlic Butter Naan Basket (×3)',
      total: 1974,
      status: 'Delivered',
      invoiceNumber: 'INV-2026-1038',
      paymentStatus: 'Paid (COD Collected)',
    ),
    CustomerOrderRecord(
      id: 'KG-1029',
      vendorName: 'BakeCharm',
      dateLabel: '2 days ago · 5:30 PM Slot',
      itemsSummary: '1× Lotus Biscoff Bento Cake',
      total: 1414,
      status: 'Rejected · Refunded',
      invoiceNumber: 'INV-2026-1029',
      paymentStatus: 'Refunded to Card',
    ),
  ];

  final vendors = const [
    VendorPlace(
      id: 'bake',
      name: 'BakeCharm',
      cuisine: 'Bakery · Custom cakes',
      area: 'F-11',
      open: true,
      intakePercent: 72,
      rating: 4.7,
      opensAt: '',
      etaRange: '35–50 min',
      bookedHourly: 9,
      limitHourly: 12,
      tagline: 'Artisan celebration cakes & Belgian fudge brownies',
    ),
    VendorPlace(
      id: 'lazeez',
      name: 'Lazeez Cloud Kitchen',
      cuisine: 'Desi · Karahi, rice',
      area: 'F-10',
      open: true,
      intakePercent: 40,
      rating: 4.5,
      opensAt: '',
      etaRange: '25–35 min',
      bookedHourly: 5,
      limitHourly: 12,
      tagline: 'Charcoal handi, Shinwari karahi & tandoori naan',
    ),
    VendorPlace(
      id: 'margalla',
      name: 'Margalla Biryani House',
      cuisine: 'Desi',
      area: 'F-11',
      open: false,
      intakePercent: 0,
      rating: 4.2,
      opensAt: '12:00 PM',
      etaRange: '30–40 min',
      bookedHourly: 0,
      limitHourly: 12,
      tagline: 'Slow-cooked Sindhi & Hyderabadi matka biryani',
    ),
  ];

  final dishes = [
    const Dish(
      id: 'cake',
      vendorId: 'bake',
      name: 'Chocolate cake',
      category: 'Cakes',
      price: 1850,
      available: true,
      customizable: true,
      fragile: true,
      popular: true,
      description: 'Rich Belgian dark chocolate sponge layered with whipped ganache and custompiped inscription.',
      kcal: 420,
      protein: '6 g',
      carbs: '52 g',
      fat: '21 g',
      allergen: 'Contains eggs, dairy and gluten. May contain nuts.',
      prepMinutes: 50,
    ),
    const Dish(
      id: 'bento',
      vendorId: 'bake',
      name: 'Lotus Biscoff Bento Cake',
      category: 'Cakes',
      price: 1250,
      available: true,
      customizable: true,
      fragile: true,
      description: 'Single-tier 4-inch lunchbox cake topped with caramelized Biscoff spread and crumbles.',
      kcal: 380,
      protein: '5 g',
      carbs: '49 g',
      fat: '18 g',
      allergen: 'Contains eggs, dairy, soy and wheat gluten.',
      prepMinutes: 35,
    ),
    Dish(
      id: 'brownie',
      vendorId: 'bake',
      name: 'Brownie box',
      category: 'Cakes',
      price: 950,
      available: false,
      customizable: false,
      fragile: false,
      description: 'Box of 6 walnut & sea-salt fudge brownies (sold out for current oven batch).',
    ),
    const Dish(
      id: 'karahi',
      vendorId: 'lazeez',
      name: 'Chicken karahi',
      category: 'Mains',
      price: 1450,
      available: true,
      customizable: false,
      fragile: false,
      popular: true,
      description: 'Wok-seared organic chicken cooked in vine tomatoes, green chillies, ginger juliennes and black pepper.',
      kcal: 680,
      protein: '42 g',
      carbs: '12 g',
      fat: '48 g',
      allergen: 'Contains dairy.',
      prepMinutes: 30,
    ),
    const Dish(
      id: 'biryani',
      vendorId: 'lazeez',
      name: 'Smoked Mutton Dum Biryani',
      category: 'Mains',
      price: 1180,
      available: true,
      customizable: false,
      fragile: false,
      popular: true,
      description: 'Aged basmati rice layered with tender spiced mutton, saffron, caramelized onions and mint raita.',
      kcal: 740,
      protein: '36 g',
      carbs: '78 g',
      fat: '28 g',
      allergen: 'Contains dairy (yogurt marinade & raita).',
      prepMinutes: 25,
    ),
    const Dish(
      id: 'naan',
      vendorId: 'lazeez',
      name: 'Garlic Butter Naan Basket (×3)',
      category: 'Sides & Drinks',
      price: 360,
      available: true,
      customizable: false,
      fragile: false,
      description: 'Three clay-oven khameeri naans brushed with roasted garlicdesi ghee and fresh coriander.',
      kcal: 290,
      protein: '8 g',
      carbs: '46 g',
      fat: '9 g',
      allergen: 'Contains wheat gluten and dairy.',
      prepMinutes: 12,
    ),
  ];

  VendorPlace? vendor;
  final List<CartLine> cart = [];
  String deliveryType = 'express';
  final slots = [
    DeliverySlot(label: '6:00 PM', booked: 3, capacity: 10),
    DeliverySlot(label: '6:30 PM', booked: 4, capacity: 10),
    DeliverySlot(label: '7:00 PM', booked: 7, capacity: 10),
    DeliverySlot(label: '7:30 PM', booked: 9, capacity: 10),
    DeliverySlot(label: '8:00 PM', booked: 10, capacity: 10),
    DeliverySlot(label: '8:30 PM', booked: 2, capacity: 10),
  ];
  String? selectedSlot = '6:30 PM';
  DateTime? holdUntil = DateTime.now().add(
    const Duration(seconds: PrototypeAssumptions.slotHoldSeconds),
  );
  String payment = 'Cash on delivery';
  bool arrivalWindowStale = true;
  String orderNumber = 'KG-1042';
  String deliveryCode = '482913';

  static const deliveryBase = 60;
  static const distanceCharge = 64;
  static const rainSurcharge = 40;

  List<VendorPlace> get visibleVendors {
    return vendors.where((vendor) {
      if (openNowOnly && !vendor.open) return false;
      if (selectedCategory != 'All' &&
          !vendor.cuisine.toLowerCase().contains(
            selectedCategory.toLowerCase(),
          )) {
        return false;
      }
      final query = search.trim().toLowerCase();
      if (query.isEmpty) return true;
      return vendor.name.toLowerCase().contains(query) ||
          vendor.cuisine.toLowerCase().contains(query);
    }).toList();
  }

  List<VendorPlace> get topRated {
    final rated = vendors.where((vendor) => vendor.rating >= 4.5).toList()
      ..sort((a, b) => b.rating.compareTo(a.rating));
    return rated;
  }

  List<Dish> dishesFor(String vendorId) =>
      dishes.where((dish) => dish.vendorId == vendorId).toList();

  int get foodTotal => cart.fold(0, (sum, line) => sum + line.lineTotal);
  int get deliveryFee => deliveryBase + distanceCharge + rainSurcharge;
  int get pooledDiscount => deliveryType == 'pooled'
      ? ((deliveryFee * PrototypeAssumptions.pooledDiscountPercent) / 100)
            .round()
      : 0;
  int get total => (foodTotal + deliveryFee - pooledDiscount - voucherDiscount)
      .clamp(0, 999999);
  bool get hasFragile => cart.any((line) => line.dish.fragile);
  bool get hasUnavailable => cart.any((line) => !line.dish.available);

  void updateProfile({required String name, required String mobile}) {
    customerName = name;
    customerMobile = mobile;
    notifyListeners();
  }

  void saveAddressEntry(String newAddress, {String? oldAddress}) {
    if (oldAddress != null) {
      final idx = addresses.indexOf(oldAddress);
      if (idx != -1) {
        addresses[idx] = newAddress;
      } else {
        addresses.add(newAddress);
      }
      if (address == oldAddress) address = newAddress;
    } else if (!addresses.contains(newAddress)) {
      addresses.add(newAddress);
      address = newAddress;
    }
    notifyListeners();
  }

  void deleteAddress(String target) {
    if (addresses.length <= 1) return;
    addresses.remove(target);
    if (address == target) {
      address = addresses.first;
    }
    notifyListeners();
  }

  void setDietaryTag(String tag) {
    selectedDietaryTag = tag;
    notifyListeners();
  }

  void attachReferenceImage(String fileName, String notes) {
    referenceImageName = fileName;
    specialInstructions = notes;
    notifyListeners();
  }

  String? applyVoucherCode(String rawCode) {
    final code = rawCode.trim().toUpperCase();
    if (code.isEmpty) return 'Enter a voucher code.';
    if (code == 'RAMADAN20') {
      appliedVoucherCode = null;
      voucherDiscount = 0;
      notifyListeners();
      return 'Voucher RAMADAN20 has expired (E3-US4-TC2). Total remains unchanged.';
    }
    if (code == 'SAVE500') {
      appliedVoucherCode = null;
      voucherDiscount = 0;
      notifyListeners();
      return 'Voucher SAVE500 requires a minimum food subtotal of Rs 3,500 (E3-US4 AC2).';
    }
    if (code == 'KHAANA15') {
      appliedVoucherCode = 'KHAANA15';
      voucherDiscount = ((foodTotal > 0 ? foodTotal : 1850) * 0.15).round();
      notifyListeners();
      return null;
    }
    return 'Voucher "$code" is not valid or has reached its usage limit.';
  }

  void reorderAvailableItems() {
    cart.clear();
    final cake = dishes.firstWhere((d) => d.id == 'cake');
    cart.add(
      CartLine(
        dish: cake,
        size: '1 lb',
        flavour: 'Chocolate',
        customText: 'Reorder',
      ),
    );
    notifyListeners();
  }

  void signIn() {
    sessionExpired = false;
    notifyListeners();
  }

  void showExpired() {
    sessionExpired = true;
    notifyListeners();
  }

  void setAddress(String value) {
    address = value;
    notifyListeners();
  }

  void setSearch(String value) {
    search = value;
    notifyListeners();
  }

  void setCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  void toggleOpenNow() {
    openNowOnly = !openNowOnly;
    notifyListeners();
  }

  void toggleHomeError() {
    homeNetworkError = !homeNetworkError;
    notifyListeners();
  }

  void openVendor(VendorPlace place) {
    if (!place.open) return;
    vendor = place;
    notifyListeners();
  }

  String? addDish(
    Dish dish, {
    String? size,
    String? flavour,
    String customText = '',
  }) {
    if (!dish.available) return 'This item is unavailable and cannot be added.';
    if (dish.customizable && (size == null || size.isEmpty))
      return 'Choose a size.';
    if (cart.isNotEmpty && cart.first.dish.vendorId != dish.vendorId) {
      return 'This cart is for one restaurant. Clear it before adding from another.';
    }
    cart.add(
      CartLine(
        dish: dish,
        size: size,
        flavour: flavour,
        customText: customText,
      ),
    );
    notifyListeners();
    return null;
  }

  void clearCart() {
    cart.clear();
    deliveryType = 'express';
    notifyListeners();
  }

  void setQty(CartLine line, int qty) {
    line.qty = qty;
    notifyListeners();
  }

  void removeLine(CartLine line) {
    cart.remove(line);
    if (cart.isEmpty) deliveryType = 'express';
    notifyListeners();
  }

  void chooseDelivery(String type) {
    if (type == 'pooled' && hasFragile) return;
    deliveryType = type;
    notifyListeners();
  }

  void selectSlot(DeliverySlot slot) {
    if (slot.isFull) return;
    selectedSlot = slot.label;
    holdUntil = DateTime.now().add(
      const Duration(seconds: PrototypeAssumptions.slotHoldSeconds),
    );
    notifyListeners();
  }

  void takeSelectedSlot() {
    for (final slot in slots) {
      if (slot.label == selectedSlot) slot.booked = slot.capacity;
    }
    selectedSlot = null;
    holdUntil = null;
    notifyListeners();
  }

  void freeAFullSlot() {
    for (final slot in slots) {
      if (slot.isFull) {
        slot.booked = slot.capacity - 4;
        break;
      }
    }
    notifyListeners();
  }

  void setPayment(String value) {
    payment = value;
    notifyListeners();
  }

  void toggleMap() {
    mapVisible = !mapVisible;
    notifyListeners();
  }

  bool placeOrder() {
    if (submitted || hasUnavailable || selectedSlot == null) return false;
    if (holdUntil != null && !holdUntil!.isAfter(DateTime.now())) return false;
    submitted = true;
    notifyListeners();
    return true;
  }

  void replaceStaleWindow() {
    arrivalWindowStale = false;
    notifyListeners();
  }

  List<String> nearestFreeSlots() => slots
      .where((slot) => !slot.isFull && slot.label != selectedSlot)
      .map((slot) => slot.label)
      .toList();
}
