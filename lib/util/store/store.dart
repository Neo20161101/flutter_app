import 'package:mobx/mobx.dart';
// Include generated file
part 'store.g.dart';

class StateStore = TodoBase with _$StateStore;

abstract class TodoBase with Store {
  final greeting = Observable('Hello World');
  @observable
  int value = 0;

  @observable
  String token = '';

  @observable
  String description = '';

  @observable
  bool done = false;

  @action
  void increment() {
    value++;
  }
}