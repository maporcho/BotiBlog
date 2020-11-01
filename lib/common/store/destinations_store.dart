import 'package:mobx/mobx.dart';

part 'destinations_store.g.dart';

class DestinationsStore = DestinationsStoreBase with _$DestinationsStore;

abstract class DestinationsStoreBase<T> with Store {
  List<T> destinations;

  @observable
  int selectedDestinationIndex;

  DestinationsStoreBase initialize(List<T> destinations,
      {T initialDestination}) {
    this.destinations = destinations;
    selectedDestinationIndex = destinations.indexOf(initialDestination);
    return this;
  }

  @computed
  T get selectedDestination => destinations[selectedDestinationIndex];

  @action
  void selectDestination(int index) {
    selectedDestinationIndex = index;
  }

  void reset() {
    selectedDestinationIndex = 0;
  }
}
