import 'package:flutter/material.dart';
import 'package:stream_demo/stream.dart';
import 'dart:async';
import 'dart:math';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamHomePage(),
    );
  }
}

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({Key? key}) : super(key: key);

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {
  int? lastNumber;
  NumberStream? numberStream;
  StreamController? numberStreamController;
  Color? bgColor;
  ColorStream? colorStream;

  @override
  void initState(){
    numberStream = NumberStream();
    numberStreamController = numberStream!.controller;
    Stream stream = numberStreamController!.stream;
    stream.listen((event) {
      setState(() {
        lastNumber = event;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream'),
      ),
      body: Container(
        decoration: BoxDecoration(color: bgColor),
      ),
    );
  }

  changeColor() async{
    colorStream!.getColor().listen((eventColor) {
      setState(() {
        bgColor = eventColor;
      });
    });
  }
}
