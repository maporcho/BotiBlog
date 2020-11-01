// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destinations_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DestinationsStore<T> on DestinationsStoreBase<T>, Store {
  Computed<T> _$selectedDestinationComputed;

  @override
  T get selectedDestination => (_$selectedDestinationComputed ??= Computed<T>(
          () => super.selectedDestination,
          name: 'DestinationsStoreBase.selectedDestination'))
      .value;

  final _$selectedDestinationIndexAtom =
      Atom(name: 'DestinationsStoreBase.selectedDestinationIndex');

  @override
  int get selectedDestinationIndex {
    _$selectedDestinationIndexAtom.reportRead();
    return super.selectedDestinationIndex;
  }

  @override
  set selectedDestinationIndex(int value) {
    _$selectedDestinationIndexAtom
        .reportWrite(value, super.selectedDestinationIndex, () {
      super.selectedDestinationIndex = value;
    });
  }

  final _$DestinationsStoreBaseActionController =
      ActionController(name: 'DestinationsStoreBase');

  @override
  void selectDestination(int index) {
    final _$actionInfo = _$DestinationsStoreBaseActionController.startAction(
        name: 'DestinationsStoreBase.selectDestination');
    try {
      return super.selectDestination(index);
    } finally {
      _$DestinationsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedDestinationIndex: ${selectedDestinationIndex},
selectedDestination: ${selectedDestination}
    ''';
  }
}
