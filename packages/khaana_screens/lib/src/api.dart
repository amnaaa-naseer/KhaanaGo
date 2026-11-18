import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_base.dart';

abstract class KhaanaApi {
  String? token;
  Future<Map<String, dynamic>> state({String role = 'customer'});
  Future<Map<String, dynamic>> login({required String role, required String identifier, required String password});
  Future<Map<String, dynamic>> holdSlot(String slotId, {String role = 'customer'});
  Future<Map<String, dynamic>> placeOrder(Map<String, dynamic> body);
  Future<Map<String, dynamic>> advance(String orderId, String action, {String role = 'vendor_staff', String? code});
  Future<Map<String, dynamic>> submit(String screenId, Map<String, String> fields, {String role = 'customer'});
}

class HttpKhaanaApi implements KhaanaApi {
  HttpKhaanaApi({String? base}) : base = base ?? defaultApiBase();

  final String base;
  @override
  String? token;

  Future<Map<String, dynamic>> _send(String method, String path, {Map<String, dynamic>? body, String role = 'customer'}) async {
    final request = http.Request(method, Uri.parse('$base$path'))
      ..headers.addAll({
        'content-type': 'application/json',
        if (token != null) 'authorization': 'Bearer $token',
      });
    // Browsers reject a body on GET/HEAD. Only POST calls pass one.
    if (body != null && method != 'GET' && method != 'HEAD') {
      request.body = jsonEncode(body);
    }
    final sent = await http.Client().send(request);
    final text = await sent.stream.bytesToString();
    final decoded = text.isEmpty ? <String, dynamic>{} : jsonDecode(text) as Map<String, dynamic>;
    if (sent.statusCode >= 400) {
      throw ApiException(decoded['error']?.toString() ?? 'Something went wrong.');
    }
    return decoded;
  }

  @override
  Future<Map<String, dynamic>> state({String role = 'customer'}) => _send('GET', '/v1/state', role: role);

  @override
  Future<Map<String, dynamic>> login({required String role, required String identifier, required String password}) async {
    final result = await _send('POST', '/v1/auth/login', body: {'role': role, 'identifier': identifier, 'password': password}, role: role);
    token = result['token']?.toString();
    return result;
  }

  @override
  Future<Map<String, dynamic>> holdSlot(String slotId, {String role = 'customer'}) {
    return _send('POST', '/v1/slots/$slotId/hold', body: {}, role: role);
  }

  @override
  Future<Map<String, dynamic>> placeOrder(Map<String, dynamic> body) => _send('POST', '/v1/orders', body: body);

  @override
  Future<Map<String, dynamic>> advance(String orderId, String action, {String role = 'vendor_staff', String? code}) {
    return _send('POST', '/v1/orders/$orderId/$action', body: {'code': code, 'screen': action}, role: role);
  }

  @override
  Future<Map<String, dynamic>> submit(String screenId, Map<String, String> fields, {String role = 'customer'}) {
    return _send('POST', '/v1/screens/$screenId/submit', body: {'fields': fields}, role: role);
  }
}

class MemoryKhaanaApi implements KhaanaApi {
  MemoryKhaanaApi() {
    vendors = [
      {'id': 'bakecharm', 'name': 'BakeCharm', 'cuisine': 'Bakery', 'dietary': ['Vegetarian'], 'area': 'F-11 Markaz', 'open': true, 'intakePercent': 72, 'rating': 4.7, 'etaMin': 40, 'etaMax': 55},
      {'id': 'lazeez', 'name': 'Lazeez Karahi', 'cuisine': 'Pakistani', 'dietary': ['Halal'], 'area': 'G-9', 'open': true, 'intakePercent': 40, 'rating': 4.5, 'etaMin': 25, 'etaMax': 35},
      {'id': 'margalla', 'name': 'Margalla Grill', 'cuisine': 'BBQ', 'dietary': ['Halal'], 'area': 'F-10', 'open': false, 'opensAt': '12:00', 'intakePercent': 0, 'rating': 4.2, 'etaMin': 30, 'etaMax': 40},
    ];
    menu = [
      {'id': 'cake', 'vendorId': 'bakecharm', 'name': 'Chocolate fudge cake', 'price': 1850, 'available': true, 'fragile': true, 'allergens': 'Milk, egg, gluten'},
      {'id': 'brownie', 'vendorId': 'bakecharm', 'name': 'Walnut brownie', 'price': 450, 'available': false, 'fragile': false, 'allergens': 'Nuts, gluten'},
    ];
    slots = [
      {'id': '1830', 'vendorId': 'bakecharm', 'label': '6:30 PM', 'percent': 40, 'band': 'Available', 'bookable': true},
      {'id': '1930', 'vendorId': 'bakecharm', 'label': '7:30 PM', 'percent': 90, 'band': 'Full', 'bookable': false},
      {'id': 'lz1900', 'vendorId': 'lazeez', 'label': '7:00 PM', 'percent': 30, 'band': 'Available', 'bookable': true},
    ];
  }

  @override
  String? token;
  List<Map<String, dynamic>> vendors = [];
  List<Map<String, dynamic>> menu = [];
  List<Map<String, dynamic>> slots = [];
  List<Map<String, dynamic>> orders = [];
  List<Map<String, dynamic>> alerts = [];
  final Map<String, DateTime> holds = {};
  Map<String, dynamic> submissions = {};
  Map<String, dynamic> finance = {'revenue': 0, 'commission': 0, 'expenses': 1200};

  Map<String, dynamic> _snapshot() => {
        'vendors': vendors,
        'menu': menu,
        'slots': slots,
        'orders': orders,
        'stock': [
          {'name': 'Flour', 'quantity': 8, 'unit': 'kg', 'reorderAt': 5},
        ],
        'invoices': orders.where((o) => o['status'] == 'delivered').map((o) => {'id': 'INV-${o['id']}', 'total': o['total'], 'status': 'Pending – COD'}).toList(),
        'finance': finance,
        'complaints': [
          {'id': 'C-12', 'subject': 'Late delivery', 'status': 'Open'},
        ],
        'buffers': [
          {'name': 'Rain', 'percent': 15, 'area': 'Islamabad'},
        ],
        'submissions': submissions,
        'alerts': alerts.where((alert) => alert['status'] == 'open').toList(),
        'demo': true,
      };

  @override
  Future<Map<String, dynamic>> state({String role = 'customer'}) async => _snapshot();

  @override
  Future<Map<String, dynamic>> login({required String role, required String identifier, required String password}) async {
    if (identifier.isEmpty || password.isEmpty) throw ApiException('Enter your mobile or email and a password.');
    if (password.length < 8 || password.length > 128) throw ApiException('Password must be 8 to 128 characters. This check is provisional and awaiting review.');
    token = 'memory-$role';
    return {'user': {'name': identifier, 'role': role}, 'token': token};
  }

  @override
  Future<Map<String, dynamic>> holdSlot(String slotId, {String role = 'customer'}) async {
    final slot = slots.cast<Map<String, dynamic>>().where((s) => s['id'] == slotId).firstOrNull;
    if (slot == null || slot['bookable'] != true) throw ApiException('That slot is full. Choose another time.');
    holds[slotId] = DateTime.now().add(const Duration(minutes: 5));
    return {'slotId': slotId, 'expiresInSeconds': 300};
  }

  @override
  Future<Map<String, dynamic>> placeOrder(Map<String, dynamic> body) async {
    final requested = (body['lines'] as List?)?.cast<Map>() ?? [];
    if (requested.isEmpty) throw ApiException('Your cart is empty.');
    if (body['simulateFailure'] == true) throw ApiException('Payment did not go through. Your order has not been placed.');
    final hold = holds[body['slotId']];
    if (hold == null || hold.isBefore(DateTime.now())) throw ApiException('That slot hold expired. Pick another time.');
    final lines = <Map<String, dynamic>>[];
    String? vendorId;
    for (final line in requested) {
      final item = menu.cast<Map<String, dynamic>>().where((entry) => entry['id'] == line['id']).firstOrNull;
      if (item == null) throw ApiException('That item is not on the menu.');
      if (item['available'] == false) throw ApiException('That item is sold out.');
      if (vendorId != null && vendorId != item['vendorId']) throw ApiException('A cart can only contain one kitchen.');
      vendorId = '${item['vendorId']}';
      final qty = (line['qty'] as num?)?.toInt() ?? 1;
      lines.add({'id': item['id'], 'name': item['name'], 'price': item['price'], 'qty': qty, 'fragile': item['fragile'] == true, 'note': line['note'] ?? ''});
    }
    if (lines.any((line) => line['fragile'] == true) && body['delivery'] == 'pooled') {
      throw ApiException('A fragile item must use express delivery.');
    }
    final slot = slots.cast<Map<String, dynamic>>().firstWhere((s) => s['id'] == body['slotId']);
    if (slot['bookable'] != true) throw ApiException('That slot is full. Choose another time.');
    final food = lines.fold<int>(0, (sum, line) => sum + (line['price'] as int) * (line['qty'] as int));
    final deliveryBase = body['delivery'] == 'pooled' ? 120 : 180;
    final discount = body['delivery'] == 'pooled' ? (deliveryBase * 0.3).round() : 0;
    final placedAt = DateTime.now().toUtc().toIso8601String();
    final order = {
      'id': 'KG-${1042 + orders.length}',
      'status': 'new',
      'vendorId': vendorId,
      'vendorName': vendors.cast<Map<String, dynamic>>().where((entry) => entry['id'] == vendorId).firstOrNull?['name'],
      'food': food,
      'deliveryFee': deliveryBase - discount,
      'discount': discount,
      'total': food + deliveryBase - discount,
      'code': '${100000 + ((1042 + orders.length) * 7919) % 900000}',
      'slotLabel': slot['label'],
      'delivery': body['delivery'],
      'payment': body['payment'],
      'lines': lines,
      'createdAt': placedAt,
      'events': {'placed': placedAt},
    };
    orders = [order, ...orders];
    holds.remove(body['slotId']);
    return order;
  }

  @override
  Future<Map<String, dynamic>> advance(String orderId, String action, {String role = 'vendor_staff', String? code}) async {
    final order = orders.firstWhere((o) => o['id'] == orderId, orElse: () => throw ApiException('Order not found.'));
    if (action == 'pickup' && order['status'] == 'picked_up') return order;
    if (action == 'deliver' && order['status'] == 'delivered') return order;
    if (action == 'deliver' && code != '482913' && code != order['code']) throw ApiException('That code does not match. The delivery stays incomplete.');
    if (action == 'pickup' && order['status'] != 'ready' && order['status'] != 'ready_for_pickup') {
      throw ApiException('This order is not ready for pickup yet.');
    }
    const next = {'accept': 'preparing', 'ready': 'ready', 'handoff': 'ready_for_pickup', 'pickup': 'picked_up', 'deliver': 'delivered', 'cancel': 'cancelled'};
    final now = DateTime.now().toUtc().toIso8601String();
    final events = Map<String, dynamic>.from((order['events'] as Map?) ?? {});
    const rider = {'id': 'rider', 'name': 'Hamza Ali', 'vehicle': 'Motorbike'};
    if (action == 'accept') events['accepted'] = now;
    if (action == 'ready' || action == 'handoff') {
      if (action == 'ready') events['preparing'] = now;
      order['rider'] = rider;
      order['riderId'] = 'rider';
      alerts.removeWhere((alert) => alert['orderId'] == orderId && alert['type'] == 'pickup');
      alerts.add({'id': 'ALERT-$orderId', 'type': 'pickup', 'orderId': orderId, 'riderId': 'rider', 'status': 'open', 'vendorName': order['vendorName'] ?? 'BakeCharm', 'slotLabel': order['slotLabel']});
    }
    if (action == 'pickup') {
      events['ready'] = now;
      order['rider'] = rider;
      order['riderId'] = 'rider';
      for (final alert in alerts) {
        if (alert['orderId'] == orderId) alert['status'] = 'closed';
      }
    }
    if (action == 'deliver') {
      events['onTheWay'] = now;
      events['delivered'] = now;
    }
    order['events'] = events;
    order['status'] = next[action] ?? order['status'];
    if (action == 'deliver') finance['revenue'] = (finance['revenue'] as int) + 1850;
    return order;
  }

  @override
  Future<Map<String, dynamic>> submit(String screenId, Map<String, String> fields, {String role = 'customer'}) async {
    if (role == 'vendor_staff' && fields.values.join(' ').toLowerCase().contains('recipe')) {
      throw ApiException('You do not have access to this page.');
    }
    submissions[screenId] = fields;
    return {'ok': true, 'saved': fields};
  }
}

class ApiException implements Exception {
  ApiException(this.message);
  final String message;
  @override
  String toString() => message;
}
