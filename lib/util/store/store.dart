import 'package:mobx/mobx.dart';

// Include generated file
part 'store.g.dart';
final counter = Counter(); // Instantiate the store
// This is the class used by rest of your codebase
class Counter = _Counter with _$Counter;

// The store-class
abstract class _Counter with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}