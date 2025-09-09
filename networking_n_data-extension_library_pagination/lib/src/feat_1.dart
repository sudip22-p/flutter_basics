import 'hidden_class.dart';

class FeatureA {
  void run() {
    final private = PrivateClass();
    private.doThis();
  }
}
