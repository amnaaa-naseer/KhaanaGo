import 'package:flutter/foundation.dart';
import 'package:khaana_design/khaana_design.dart';

enum PortalRole { owner, staff, admin }

class MenuRow {
  MenuRow({required this.name, required this.category, required this.price, this.available = true});

  String name;
  String category;
  int price;
  bool available;
}

class KitchenTicket {
  KitchenTicket({required this.number, required this.summary, required this.column, this.allergen, this.note});

  final String number;
  final String summary;
  String column;
  final String? allergen;
  final String? note;
  bool markedEighty = false;
}

class BufferRule {
  BufferRule({required this.name, required this.period, required this.area, required this.percent});

  String name;
  String period;
  String area;
  int percent;
}

class StaffMemberRecord {
  StaffMemberRecord({
    required this.name,
    required this.employeeId,
    required this.duties,
    this.active = true,
  });

  String name;
  String employeeId;
  List<String> duties;
  bool active;
}

class PortalSession extends ChangeNotifier {
  PortalRole? role;
  int failedAdminAttempts = 0;
  bool adminLocked = false;
  bool intakePaused = false;
  bool nutritionApiDown = false;
  bool showNewOrder = true;
  int ordersPerHour = 12;
  String? capacityError;

  final staffMembers = [
    StaffMemberRecord(
      name: 'Usman Ali',
      employeeId: 'STAFF-04',
      duties: ['Take orders', 'Prepare food', 'Edit stock'],
    ),
    StaffMemberRecord(
      name: 'Farhan Raza',
      employeeId: 'STAFF-02',
      duties: ['Prepare food'],
    ),
  ];

  final menu = [
    MenuRow(name: 'Chocolate cake', category: 'Cakes', price: 1850),
    MenuRow(name: 'Brownie box', category: 'Cakes', price: 950, available: false),
    MenuRow(name: 'Chicken karahi', category: 'Mains', price: 1450),
  ];

  final tickets = [
    KitchenTicket(
      number: '123',
      summary: 'Custom cake · 1 lb, Happy Birthday Hira',
      column: 'new',
      allergen: 'No nuts',
      note: 'No nuts',
    ),
    KitchenTicket(number: '121', summary: 'Cupcakes × 6', column: 'preparing'),
  ];

  final rules = [
    BufferRule(name: 'Rain', period: 'While rain is reported', area: 'Islamabad', percent: 15),
    BufferRule(name: 'Dinner peak', period: '7:00–9:00 PM', area: 'F-11', percent: 10),
  ];

  final ingredients = [
    ('Flour', 'kg', 4, 5, 'Non-perishable'),
    ('Cream', 'litre', 1, 2, 'Perishable'),
    ('Eggs', 'dozen', 2, 2, 'Perishable'),
  ];

  bool get isStaff => role == PortalRole.staff;

  bool allows(String route) {
    const publicRoutes = {
      '/vendor/sign-in',
      '/admin/sign-in',
      '/vendor/apply-1',
      '/vendor/apply-2',
      '/vendor/apply-3',
      '/vendor/apply-status',
      '/vendor/locked',
      '/vendor/reset-password',
      '/not-found',
      '/error',
    };
    if (publicRoutes.contains(route)) return true;
    if (role == PortalRole.admin) return route.startsWith('/admin');
    if (role == null) return route.contains('sign-in');
    const ownerOnly = {
      '/vendor/dashboard',
      '/vendor/recipe',
      '/vendor/recipe-list',
      '/vendor/nutrition',
      '/vendor/finance',
      '/vendor/bom',
      '/vendor/bank',
      '/vendor/staff',
      '/vendor/staff/edit',
      '/vendor/commission',
      '/vendor/expenses',
      '/vendor/net-profit',
      '/vendor/audit-log',
    };
    if (isStaff && ownerOnly.contains(route)) return false;
    return route.startsWith('/vendor');
  }

  void saveStaffMember({
    required String name,
    required String employeeId,
    required List<String> duties,
  }) {
    final existing = staffMembers.where((s) => s.employeeId == employeeId).toList();
    if (existing.isNotEmpty) {
      existing.first.name = name;
      existing.first.duties = duties;
    } else {
      staffMembers.add(StaffMemberRecord(name: name, employeeId: employeeId, duties: duties));
    }
    notifyListeners();
  }

  void deactivateStaff(StaffMemberRecord member) {
    member.active = false;
    notifyListeners();
  }

  void signIn(PortalRole next) {
    role = next;
    notifyListeners();
  }

  void signOut() {
    role = null;
    notifyListeners();
  }

  bool tryAdmin(String password) {
    if (adminLocked) return false;
    if (password == 'wrong') {
      failedAdminAttempts += 1;
      if (failedAdminAttempts >= 6) adminLocked = true;
      notifyListeners();
      return false;
    }
    failedAdminAttempts = 0;
    signIn(PortalRole.admin);
    return true;
  }

  void saveCapacity(String raw) {
    final value = int.tryParse(raw);
    if (value == null || value <= 0) {
      capacityError = 'Enter an orders-per-hour value greater than zero.';
    } else {
      ordersPerHour = value;
      capacityError = null;
      intakePaused = PrototypeAssumptions.intakeBandLabel(((10 * 100) / value).round()) == 'Full';
    }
    notifyListeners();
  }

  void resumeIntake() {
    intakePaused = false;
    notifyListeners();
  }

  void toggleItem(MenuRow row) {
    row.available = !row.available;
    notifyListeners();
  }

  String? addItem({required String name, required String price, required String category}) {
    final parsed = int.tryParse(price);
    if (parsed == null || parsed < 0) return 'Enter a price that is a number and is not negative.';
    if (name.trim().isEmpty || category.trim().isEmpty) return 'Name and category are required.';
    menu.add(MenuRow(name: name.trim(), category: category.trim(), price: parsed));
    notifyListeners();
    return null;
  }

  void moveTicket(KitchenTicket ticket, String column) {
    ticket.column = column;
    showNewOrder = tickets.any((item) => item.column == 'new');
    notifyListeners();
  }

  void markEighty(KitchenTicket ticket) {
    ticket.markedEighty = true;
    notifyListeners();
  }

  void rejectTicket(KitchenTicket ticket) {
    tickets.remove(ticket);
    showNewOrder = tickets.any((item) => item.column == 'new');
    notifyListeners();
  }

  void dismissAlert() {
    showNewOrder = false;
    notifyListeners();
  }

  String? saveRecipe({required String name, required String qty, required String unit}) {
    if (name.trim().isEmpty || qty.trim().isEmpty) return 'Ingredient name and quantity are required.';
    if (double.tryParse(qty) == null) return 'Quantity must be a number.';
    if (unit.trim().isEmpty) return 'Choose a unit.';
    notifyListeners();
    return null;
  }

  void toggleNutritionApi() {
    nutritionApiDown = !nutritionApiDown;
    notifyListeners();
  }

  void saveRule(BufferRule rule) {
    if (!rules.contains(rule)) rules.add(rule);
    notifyListeners();
  }
}
