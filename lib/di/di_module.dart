import 'package:get_it/get_it.dart';

class MyService {}

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<MyService>(MyService());
}

void main() {
  setupLocator();
  final myService = locator<MyService>();
}
