import 'package:mobx/mobx.dart';
// Include generated file
part 'store.g.dart';

class stateStore = TodoBase with _$stateStore;

abstract class TodoBase with Store {
  // TodoBase(this.description);
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