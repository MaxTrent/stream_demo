import 'package:flutter/material.dart';

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
  })
}


}