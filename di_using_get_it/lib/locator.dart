import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

class MyService {
  void doSomething() {
    print("Service Called");
  }
}

void setupLocator() {
  //for singleton object created only once at the start  ...
  // locator.registerSingleton<MyService>(MyService());
  //-------------------------------------------------------
  //for singleton object created only once only when it's required ...
  locator.registerLazySingleton<MyService>(() => MyService());
  //-------------------------------------------------------
  //for distinct object supply on each call  ...
  // locator.registerFactory<MyService>(() => MyService());
}
