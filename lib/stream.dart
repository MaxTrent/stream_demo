import 'dart:js';

import 'package:flutter/material.dart';
import 'dart:async';


class ColorStream{
  Stream? colorStream;

  Stream<Color> getColor() async* {
  final List<Color> colors = [
    Colors.blueGrey,
    Colors.deepPurpleAccent,
    Colors.orange,
    Colors.lightGreen,
    Colors.brown,
  ];

  yield* Stream.periodic(Duration(seconds: 1), (int t){
    int index = t%5;
    return colors[index];
  });
}

}


class NumberStream{
  StreamController controller = StreamController<int>();

  addNumberToSink(int newNumber){
    controller.sink.add(newNumber);
  }

  close(){
    controller.close();
  }

  addError() {
    controller.sink.addError('Error');
  }


}