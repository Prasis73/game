import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:roulette/roulette.dart';
import 'arrow.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roulette',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class MyRoulette extends StatelessWidget {
  const MyRoulette({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final RouletteController controller;




  @override
  Widget build(BuildContext context) {
    StreamController<int> controller = StreamController<int>();
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          width: 260,
          height: 260,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: FortuneBar(
              selected: controller.stream,
              styleStrategy: const AlternatingStyleStrategy(),
              items: const [
                FortuneItem(child: Text('Han Solo'),
            style: FortuneItemStyle(
            color: Colors.red, // <-- custom circle slice fill color
            borderColor: Colors.green, // <-- custom circle slice stroke color
            borderWidth: 3, // <-- custom circle slice stroke width
          ),),
                FortuneItem(child: Text('Yoda')),
                FortuneItem(child: Text('Obi-Wan Kenobi')),
              ],
            )
          ),
        ),
        const Arrow(),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {


  late RouletteController _controller;

  final colors = <Color>[
    Colors.red,
    Colors.grey,
    Colors.red,
    Colors.grey,
    Colors.red,
    Colors.grey,
    Colors.red,
    Colors.grey,
    Colors.white,

  ];

  @override
  void initState() {
    // Initialize the controller
    final group = RouletteGroup.uniform(
      colors.length,
      colorBuilder: colors.elementAt,
      textBuilder: (index) => (index + 1).toString(),
    );
    _controller = RouletteController(vsync: this, group: group);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roulette'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.pink.withOpacity(0.1),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              MyRoulette(controller: _controller),
            ],
          ),
        ),
      ),

    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}