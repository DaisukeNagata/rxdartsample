import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CountModel {
  int count;

  CountModel(this.count);
}

class ProductListModel {
  List<CountModel> products = [];

  void add(int index) {
    products.add(CountModel(index));
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int count = 0;
  var subject = PublishSubject<int>();
  var productListModel = ProductListModel();

  void _incrementCounter() {
    setState(() {
      // 購読
      subject.listen((data) {
        _counter = data;
      });
      count = count += 1;
      productListModel.add(count);
      // 発行
      subject.add(productListModel.products.last.count);
    });
  }

  void reset() {
    setState(() {
      subject.add(0);
      count = 0;
      productListModel.products = [];
    });
  }

  @override
  void dispose() {
    subject.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '$_counter',
          style: Theme
              .of(context)
              .textTheme
              .headline4,
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: reset,
            child: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
