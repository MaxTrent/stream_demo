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


  @override
  void initState(){
    numberStream = NumberStream();
    numberStreamController = numberStream!.controller;
    Stream stream = numberStreamController!.stream;
    transformer = StreamTransformer<int, dynamic>.fromHandlers(
      handleData: (value, sink){
        sink.add(value * 10);
      },
      handleError: (error, trace, sink){
        sink.add(-1);
      },
      handleDone: (sink) {
        sink.close();
      }
    );
    stream.transform(transformer!).listen((event) {
      setState(() {
        lastNumber = event;
      });
    }).onError((error){
      setState(() {
        lastNumber = -1;
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
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              lastNumber.toString(),
            ),
            ElevatedButton(
                onPressed: ()=> addRandomNumber(),
                child: Text('New Random Number'),),
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
    //int myNum = random.nextInt(10);
    //numberStream!.addNumberToSink(myNum);
    numberStream!.addError();
  }
}
