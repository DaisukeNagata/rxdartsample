import 'package:flutter/material.dart';
import 'counter_pageState.dart';

class CounterCustomButton extends StatelessWidget {

  final CounterPageState myHomePageState;

  CounterCustomButton(this.myHomePageState);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              onPressed: myHomePageState.reset,
              child: Icon(Icons.close),
            ),
            FloatingActionButton(
              onPressed: myHomePageState.incrementCounter,
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}