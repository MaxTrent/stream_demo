import 'package:flutter/material.dart';
import 'package:stream_demo/stream.dart';
import 'dart:async';
import 'dart:math';
import 'dart:js';


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
  StreamTransformer? transformer;
  StreamSubscription? subscription;
  StreamSubscription? subscription2;
  String values = ' ';


  @override
  void initState(){
    numberStream = NumberStream();
    numberStreamController = numberStream!.controller;
    Stream stream = numberStreamController!.stream.asBroadcastStream();
    subscription = stream.listen((event) {
      setState(() {
        values += '$event - ';
      });
    });
    subscription2 = stream.listen((event) {
      setState(() {
        values += '$event - ';
      });
    });
    subscription!.onError((error){
      setState(() {
        lastNumber = -1;
      });
    });

    subscription!.onDone(() {
      print('OnDone was called');
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
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              values,
            ),
            ElevatedButton(
                onPressed: ()=> addRandomNumber(),
                child: Text('New Random Number'),),
            ElevatedButton(
                onPressed: ()=> stopStream(),
                child: Text('Stop Stream')),
          ],
        ),
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

  void addRandomNumber(){
    Random random = Random();
    int myNum = random.nextInt(10);
    if (numberStreamController!.isClosed){
      numberStream!.addNumberToSink(myNum);
    } else {
      setState(() {
        lastNumber = -1;
      });
    }
    numberStream!.addError();
  }

  void stopStream(){
    numberStreamController!.close();
  }
}
