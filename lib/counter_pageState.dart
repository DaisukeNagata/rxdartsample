import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdartsample/counter_custom_button.dart';
import 'counter_page.dart';
import 'counter_model.dart';

class CounterPageState extends State<CounterPage> {
  int _counter = 0;
  var subject = PublishSubject<int>();
  var productListModel = CounterListModel();

  void incrementCounter() {
    setState(() {
      // 購読
      subject.listen((data) {
        _counter = data;
      });

      productListModel.add(_counter + 1);
      // 発行
      subject.add(productListModel.products.last.count);
    });
  }

  void reset() {
    setState(() {
      subject.add(0);
      productListModel.products = [];
    });
  }

  @override
  void dispose() {
    subject.close();
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(
              width: size.width,
              height:  size.height-100,
              child:CounterCustomButton(this),
            )
          ],
        ),
      ),
    );
  }
}