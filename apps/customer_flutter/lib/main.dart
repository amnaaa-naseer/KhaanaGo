import 'package:flutter/material.dart';
import 'package:khaana_screens/khaana_screens.dart';

void main() {
  runApp(KhaanaApp(role: 'customer', api: HttpKhaanaApi(), homeId: 'E1-US1-UI3'));
}
