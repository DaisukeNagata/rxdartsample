import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ProductModel {
  String productName, productPrice;
  int productName2, productPrice2;

  ProductModel(this.productName, this.productPrice, this.productName2,
      this.productPrice2);
}

class ProductListModel {
  List<ProductModel> products = [];

  void add(String st) {
    int count = int.parse(st) + 1;
    products.add(ProductModel(st, count.toString(), 3, 4));
  }
}

void main() {
  MyApp().myapp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var subject = PublishSubject<String>();
  var p = ProductListModel();

  void myapp() async {
    p.add("1");

    // 購読
    subject.listen((data) {
      print('検知1------');
      print(data);
    });

    // 発行
    subject.add(p.products.last.productName);
    subject.add(p.products.last.productPrice);
    subject.add(p.products.last.productName2.toString());
    subject.add(p.products.last.productPrice2.toString());

    await Future.delayed(Duration(seconds: 5)); // このコードは検証用 5秒待つ
    print('【ここまで発行1回目】');
    // 購読
    subject.listen((data) {
      print('検知2------');
      print(data);
    });
    subject.listen((data) {
      print('検知3------');
      print(data);
    });
    subject.add("Item3");
    await Future.delayed(Duration(seconds: 5)); // このコードは検証用 5秒待つ
    print('【ここまで発行2回目】');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ⑤
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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ④
    return Scaffold(
      // ③
      body: Center(
        // ②
        child: Text(
          // ①
          '$_counter',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
