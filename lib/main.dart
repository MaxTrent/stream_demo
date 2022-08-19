import 'package:flutter/material.dart';
import 'package:stream_demo/stream.dart';

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
  Color? bgColor;
  ColorStream? colorStream;

  @override
  void initState(){
    colorStream = ColorStream();
    changeColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }

  changeColor() async{
    await for(var eventColor in colorStream!.getColor()){
      setState(() {
        bgColor = eventColor;
      });
    }
  }
}
