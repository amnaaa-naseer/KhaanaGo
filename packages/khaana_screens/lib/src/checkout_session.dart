import 'package:flutter/foundation.dart';

class CheckoutSession extends ChangeNotifier {
  String? token;
  String? userName;
  String vendorId = 'bakecharm';
  String vendorName = 'BakeCharm';
  bool vendorOpen = true;
  String itemId = 'cake';
  String itemName = 'Chocolate fudge cake';
  int price = 1850;
  bool fragile = true;
  bool available = true;
  int qty = 1;
  String note = '';
  String delivery = 'express';
  String slotId = '1830';
  String slotLabel = '6:30 PM';
  bool slotBookable = true;
  String payment = 'Cash on delivery';
  bool simulatePaymentFailure = false;
  String? orderId;
  String? orderCode;
  String? orderStatus;
  Map<String, dynamic>? activeOrder;
  String? _orderSignature;

  int get food => price * qty;
  int get deliveryBase => delivery == 'pooled' ? 120 : 180;
  int get discount => delivery == 'pooled' ? (deliveryBase * 0.3).round() : 0;
  int get deliveryFee => deliveryBase - discount;
  int get total => food + deliveryFee;

  void signIn(String nextToken, String name) {
    token = nextToken;
    userName = name;
    notifyListeners();
  }

  void selectVendor(Map vendor) {
    vendorId = '${vendor['id']}';
    vendorName = '${vendor['name']}';
    vendorOpen = vendor['open'] == true;
    notifyListeners();
  }

  void selectItem(Map item) {
    itemId = '${item['id']}';
    itemName = '${item['name']}';
    price = (item['price'] as num?)?.toInt() ?? price;
    fragile = item['fragile'] == true;
    available = item['available'] != false;
    if (fragile && delivery == 'pooled') delivery = 'express';
    qty = 1;
    notifyListeners();
  }

  void setQty(int value) {
    qty = value.clamp(1, 20);
    notifyListeners();
  }

  void setNote(String value) {
    note = value.length > 500 ? value.substring(0, 500) : value;
    notifyListeners();
  }

  void setDelivery(String value) {
    if (value == 'pooled' && fragile) return;
    delivery = value;
    notifyListeners();
  }

  void selectSlot(Map slot) {
    slotId = '${slot['id']}';
    slotLabel = '${slot['label']}';
    slotBookable = slot['bookable'] == true;
    notifyListeners();
  }

  void setPayment(String value) {
    payment = value;
    notifyListeners();
  }

  void setPaymentFailure(bool value) {
    simulatePaymentFailure = value;
    notifyListeners();
  }

  void rememberOrder(Map order) {
    final next = Map<String, dynamic>.from(order);
    final signature = '${next['id']}|${next['status']}|${next['events']}|${next['rider']}';
    activeOrder = next;
    orderId = '${next['id']}';
    orderCode = next['code']?.toString();
    orderStatus = '${next['status']}';
    if (signature == _orderSignature) return;
    _orderSignature = signature;
    notifyListeners();
  }

  Map<String, dynamic> orderBody() => {
        'vendorId': vendorId,
        'slotId': slotId,
        'delivery': delivery,
        'payment': payment,
        'simulateFailure': simulatePaymentFailure,
        'lines': [
          {'id': itemId, 'qty': qty, 'note': note},
        ],
      };
}
