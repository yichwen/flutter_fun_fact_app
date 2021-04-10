import 'package:flutter/material.dart';
import 'package:fun_fact_app/colors.dart';

import 'facts.dart';

void main() => runApp(MaterialApp(
      home: new Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 2),
    );
    animation = new CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    );
    animation.addListener(() {
      setState(() {});
    });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  int factcounter = 0;
  int colorcounter = 0;

  void showFacts() {
    setState(() {
      dispfact = facts[factcounter];
      dispcolor = bgcolors[colorcounter];
      factcounter = factcounter < facts.length - 1 ? factcounter + 1 : 0;
      colorcounter = colorcounter < bgcolors.length - 1 ? colorcounter + 1 : 0;
      animationController.reset();
      animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dispcolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 75.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    'Did you Know?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 60.0,
                ),
                child: Opacity(
                  opacity: animation.value * 1,
                  child: Transform(
                    transform: new Matrix4.translationValues(
                        0.0, animation.value * -50.0, 0.0),
                    child: Text(
                      dispfact,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ),
              MaterialButton(
                color: Colors.white,
                minWidth: 160,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60.0,
                    vertical: 18.0,
                  ),
                  child: Text(
                    'Show Another Fun Fact',
                    style: TextStyle(
                      fontSize: 15,
                      color: dispcolor,
                    ),
                  ),
                ),
                onPressed: showFacts,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
