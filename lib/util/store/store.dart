import 'package:mobx/mobx.dart';
// Include generated file
part 'store.g.dart';

class stateStore = CounterBase with _$stateStore;

abstract class CounterBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}