import 'package:flutter/material.dart';
import 'package:khaana_screens/khaana_screens.dart';

void main() {
  runApp(KhaanaApp(role: 'rider', api: HttpKhaanaApi(), homeId: 'E1-US2-UI2'));
}
