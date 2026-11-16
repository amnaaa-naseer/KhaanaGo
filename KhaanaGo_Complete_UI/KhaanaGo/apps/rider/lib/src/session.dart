import 'package:flutter/foundation.dart';
import 'package:khaana_design/khaana_design.dart';

enum RideStage { offer, pickup, ready, atStore, handover, dropoff, code, delivered }

class RiderSession extends ChangeNotifier {
  bool online = false;
  bool mapVisible = false;
  int prepPercent = 72;
  RideStage stage = RideStage.offer;
  DateTime? arrivedAt;
  String codeAttempt = '';
  bool codeAccepted = false;
  int deliveriesToday = 4;
  String vehicle = 'Motorbike';
  final code = '482913';
  final address = 'Home · F-11 Markaz';
  final vendorAddress = 'Shop 14, F-11 Markaz';

  static const basePay = 80;
  static const distancePay = 48;
  static const rainPay = 40;

  Duration get waited => arrivedAt == null ? Duration.zero : DateTime.now().difference(arrivedAt!);

  int get excessWaitingSeconds {
    final over = waited.inSeconds - PrototypeAssumptions.freeWaitingSeconds;
    return over > 0 ? over : 0;
  }

  void setVehicle(String next) {
    vehicle = next;
    notifyListeners();
  }

  void goOnline(bool value) {
    online = value;
    notifyListeners();
  }

  void acceptOffer() {
    if (!online) return;
    stage = RideStage.pickup;
    notifyListeners();
  }

  void declineOffer() {
    stage = RideStage.offer;
    notifyListeners();
  }

  void markKitchenReady() {
    prepPercent = 80;
    stage = RideStage.ready;
    notifyListeners();
  }

  void arriveAtStore() {
    stage = RideStage.atStore;
    arrivedAt = DateTime.now();
    notifyListeners();
  }

  void confirmPickup() {
    stage = RideStage.dropoff;
    notifyListeners();
  }

  void setCode(String value) {
    codeAttempt = value;
    codeAccepted = false;
    notifyListeners();
  }

  bool submitCode() {
    codeAccepted = codeAttempt == code;
    notifyListeners();
    return codeAccepted;
  }

  void confirmDelivered() {
    if (!codeAccepted) return;
    stage = RideStage.delivered;
    deliveriesToday += 1;
    notifyListeners();
  }

  void toggleMap() {
    mapVisible = !mapVisible;
    notifyListeners();
  }
}
