// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

<<<<<<< HEAD
mixin _$Counter on _Counter, Store {
  final _$valueAtom = Atom(name: '_Counter.value');
=======
mixin _$stateStore on TodoBase, Store {
  final _$valueAtom = Atom(name: 'TodoBase.value');
>>>>>>> 95ea15f64403e54d60a5d0a8ea935aa7e71bdff3

  @override
  int get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

<<<<<<< HEAD
  final _$_CounterActionController = ActionController(name: '_Counter');
=======
  final _$descriptionAtom = Atom(name: 'TodoBase.description');

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  final _$doneAtom = Atom(name: 'TodoBase.done');

  @override
  bool get done {
    _$doneAtom.reportRead();
    return super.done;
  }

  @override
  set done(bool value) {
    _$doneAtom.reportWrite(value, super.done, () {
      super.done = value;
    });
  }

  final _$TodoBaseActionController = ActionController(name: 'TodoBase');
>>>>>>> 95ea15f64403e54d60a5d0a8ea935aa7e71bdff3

  @override
  void increment() {
    final _$actionInfo =
<<<<<<< HEAD
        _$_CounterActionController.startAction(name: '_Counter.increment');
    try {
      return super.increment();
    } finally {
      _$_CounterActionController.endAction(_$actionInfo);
=======
        _$TodoBaseActionController.startAction(name: 'TodoBase.increment');
    try {
      return super.increment();
    } finally {
      _$TodoBaseActionController.endAction(_$actionInfo);
>>>>>>> 95ea15f64403e54d60a5d0a8ea935aa7e71bdff3
    }
  }

  @override
  String toString() {
    return '''
<<<<<<< HEAD
value: ${value}
=======
value: ${value},
description: ${description},
done: ${done}
>>>>>>> 95ea15f64403e54d60a5d0a8ea935aa7e71bdff3
    ''';
  }
}
