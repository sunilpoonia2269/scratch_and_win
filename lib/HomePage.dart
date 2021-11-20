import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //import images

  AssetImage circle = AssetImage("images/circle.png");
  AssetImage lucky = AssetImage("images/rupee.png");
  AssetImage unlucky = AssetImage("images/sadFace.png");

  // get an array of 25 elements

  List<String> itemArray;
  int luckyNumber;
  int attemptLeft;
  String message;

  // init the array

  @override
  void initState() {
    super.initState();

    setState(() {
      itemArray = List<String>.generate(25, (index) => "empty");
      attemptLeft = 5;
      generateRandomNumber();
      message = "";
    });
  }

  generateRandomNumber() {
    var random = Random().nextInt(25);
    setState(() {
      luckyNumber = random;
    });
  }

  //define a getImage method

  AssetImage getImage(int index) {
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
        return lucky;

        break;
      case "unlucky":
        return unlucky;

        break;
    }
    return circle;
  }

  // Timer function

  timer() {
    new Timer(new Duration(seconds: 2), () {
      resetGame();
    });
  }

  //play Game method

  playGame(int index) {
    if (attemptLeft > 0) {
      if (luckyNumber == index) {
        setState(() {
          itemArray[index] = "lucky";
          this.message = "You Won!!!";
        });
        timer();
      } else {
        setState(() {
          itemArray[index] = "unlucky";
        });
      }

      setState(() {
        attemptLeft = attemptLeft - 1;
      });
    }
    if (attemptLeft == 0) {
      setState(() {
        this.message = "Game Over!!!";
      });
      timer();
    }
  }

  // Show all

  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray[luckyNumber] = "lucky";
    });
    timer();
  }

  //Reset all

  resetGame() {
    setState(() {
      itemArray = List<String>.filled(25, "empty");
      attemptLeft = 5;
      message = "";
    });
    generateRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scratch and Win",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Attempts Left : ${attemptLeft}",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: itemArray.length,
              itemBuilder: (context, i) => SizedBox(
                width: 50.0,
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    this.playGame(i);
                  },
                  child: Image(
                    image: this.getImage(i),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              color: Colors.pink,
              onPressed: () {
                this.showAll();
              },
              child: Text(
                "Show All",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              padding: EdgeInsets.all(10.0),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
              color: Colors.pink,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              onPressed: () {
                this.resetGame();
              },
              child: Text(
                "Reset Game",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              padding: EdgeInsets.all(10.0),
            ),
          ),
          Container(
            height: 30.0,
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "SR Software Solution",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontFamily: "MonoRobot",
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
