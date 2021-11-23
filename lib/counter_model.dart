class CountModel {
  int count;

  CountModel(this.count);
}

class CounterListModel {
  List<CountModel> products = [];

  void add(int index) {
    products.add(CountModel(index));
  }
}