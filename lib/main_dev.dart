
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'app.dart';
import 'di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(Environment.dev);
  runApp(const MyApp());
}

