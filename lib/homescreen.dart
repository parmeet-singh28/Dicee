// import 'dart:ffi';

import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// child: Padding(
//   padding: EdgeInsets.all(16.0),
//   child: Text('Hello World!'),
// ),
class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;
  late AnimationController _controller;
  var animation;
  @override
  void initState() {
    super.initState();
    animate();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  animate() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);
    // _controller.forward();
    animation.addListener(() {
      setState(() {});
      print(_controller.value);
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          leftDiceNumber = Random().nextInt(6) + 1;
          rightDiceNumber = Random().nextInt(6) + 1;
        });
        print("Completed");
        _controller.reverse();
      }
    });
  }

  void roll() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dicee"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onDoubleTap: roll,
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Image(
                        height: 200.0 - (animation.value) * 200,
                        image: AssetImage(
                            'assets/images/dice-png-$leftDiceNumber.png'))),
              )),
              Expanded(
                  child: GestureDetector(
                onDoubleTap: roll,
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Image(
                        height: 200.0 - animation.value * 200,
                        image: AssetImage(
                            'assets/images/dice-png-$rightDiceNumber.png'))),
              )),
            ],
          ),
          ElevatedButton(
              onPressed: roll,
              child: Text(
                "Roll",
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
        ]),
      ),
    );
  }
}
